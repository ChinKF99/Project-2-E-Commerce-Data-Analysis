/*
===========================================================
Stored Procedure: Load silver layer (Bronze > Silver)
===========================================================
Script purpose:
	This stored procedure performts the ETL (Extract, Transform, Load)
	process to pupulate the 'silver' schema tables from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and cleansed data from Bronze into Silver tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC Silver.load_silver;
===============================================================================
*/
USE Ecommerce

EXEC silver.load_silver

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	DECLARE @batch_start_time DATETIME, @batch_end_time DATETIME
	DECLARE @start_time DATETIME, @end_time DATETIME
	BEGIN TRY

		PRINT '==============================='
		PRINT 'LOADING silver.ecommerce'
		PRINT '==============================='

		-- Loading silver.ecommerce
		SET @batch_start_time = GETDATE()
	    SET @start_time = GETDATE();

		PRINT '>>>>>TRUNCATING TABLE: silver.ecommerce';
		TRUNCATE TABLE silver.ecommerce;
		PRINT '>>>>>INSERTING TO TABLE: silver.ecommerce';

		-- CTE to esure data cleansing, standardizaiton & consistency
		WITH cte_cleaned_data AS (
		SELECT
			CAST(LTRIM(RTRIM(customer_id)) AS INT) AS customer_id,
			LTRIM(RTRIM(invoice_no)) AS invoice_no,
			CONVERT(DATE, invoice_date , 101) AS invoice_date,
			UPPER(country) AS country,
			LTRIM(RTRIM(stock_code)) AS stock_code_category,
			LTRIM(RTRIM(UPPER(REPLACE(stock_name, '"', '')))) AS stock_name_category,
			CAST(LTRIM(RTRIM(stock_quantity)) AS INT) as stock_quantity,
			CAST(stock_unit_price AS FLOAT) AS stock_unit_price
		FROM bronze.ecommerce
		-- Exclude rows which have NULL value data in these 2 column
		WHERE stock_name IS NOT NULL AND customer_id IS NOT NULL),

		-- CTE to add variant_id as some stock_id/stock_name of 1 product consist of multiple stock_unit_price
		-- E.G. [stock_id = 101] [stock_name: towel] [Price:0.85, 0.49]
		cte_add_variantid AS(
		SELECT
			customer_id,
			invoice_no,
			invoice_date,
			country,
			stock_code_category,
			stock_name_category,
			DENSE_RANK() OVER ( PARTITION BY stock_code_category ORDER BY stock_unit_price ASC
			) AS variant_id,
			stock_quantity,
			stock_unit_price
		FROM cte_cleaned_data
		-- Exclude data value such as Manual input, postage, discount and so on
		WHERE stock_code_category NOT LIKE '[a-zA-Z]%'),

		-- CTE to add stock_code_variant, stock_name_variant column
		cte_add_stockid_stockname_variant_data AS(
		SELECT
			customer_id,
			invoice_no,
			invoice_date,
			country,
			stock_code_category,
			stock_name_category,
			variant_id,
			-- Add variant_id to differentiate each variant for code & name due to different pricing
			stock_code_category +' v' + CAST(variant_id AS NVARCHAR(10)) AS stock_code_variant,
			stock_name_category +' v' + CAST(variant_id AS NVARCHAR(10)) AS stock_name_variant,
			stock_quantity,
			stock_unit_price
		FROM cte_add_variantid)

		-- Insert data to table silver.ecommerce using CTE: cte_cleaned_order_data
		INSERT INTO silver.ecommerce
		SELECT
			*
		FROM cte_add_stockid_stockname_variant_data

		SET @end_time = GETDATE()
		PRINT '>>>>>LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' SECONDS';
        PRINT '>>>>>LOAD COMPLETE silver.ecommerce';
        PRINT '>>>>>-------------';
		
		PRINT '===============================';
		PRINT 'LOADING silver.dim_customer';
		PRINT '===============================';

		-- Loading silver.dim_customers
		SET @start_time = GETDATE();

		PRINT '>>>>>TRUNCATING TABLE: silver.dim_customer';
		TRUNCATE TABLE silver.dim_customers;
		PRINT '>>>>>INSERTING TO TABLE: silver.dim_customer';

		-- CTE to find out the latest row record base on invoice_date
		WITH cte_latest_record AS (
			SELECT 
			customer_id,
			country,
			ROW_NUMBER() OVER (PARTITION BY customer_id
			-- To label latest record as value: flag = 1
			ORDER BY invoice_date DESC
			) AS flag
		FROM silver.ecommerce)

		-- Insert data to table using CTE: cte_latest_record
		INSERT INTO silver.dim_customers
		SELECT
			customer_id,
			country
		FROM cte_latest_record
		-- flag =1 to only insert the latest row record
		WHERE flag =1

		SET @end_time = GETDATE();
		PRINT '>>>>>LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' SECONDS';
        PRINT '>>>>>LOAD COMPLETE silver.dim_customers';
        PRINT '>>>>>-------------';

		PRINT '===============================';
		PRINT 'LOADING silver.dim_stocks';
		PRINT '===============================';

		-- Loading silver.dim_stocks
		SET @start_time = GETDATE();
		PRINT '>>>>>TRUNCATING TABLE: silver.dim_stocks';
		TRUNCATE TABLE silver.dim_stocks;
		PRINT '>>>>>INSERTING TO TABLE: silver.dim_stocks';

		--CTE to filter and keep only 1 record for stock of each variant
		WITH cte_filter_stocks AS(
		SELECT
			stock_code_category,
			stock_name_category,
			variant_id,
			stock_code_variant,
			stock_name_variant,
			stock_unit_price,
			-- Only keep 1 record for each stock of each variant
			-- Note: Some products have the same stock_name but different stock_code & pricing
			ROW_NUMBER() OVER ( PARTITION BY stock_code_variant ORDER BY stock_unit_price ASC
			) AS flag
		FROM silver.ecommerce)

		-- Insert data to table using CTE: cte_filter_stocks
		INSERT INTO silver.dim_stocks
		SELECT
			stock_code_category,
			stock_name_category,
			variant_id,
			stock_code_variant,
			stock_name_variant,
			stock_unit_price
		FROM cte_filter_stocks
		WHERE flag = 1

		SET @end_time = GETDATE();
		PRINT '>>>>>LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' SECONDS';
        PRINT '>>>>>LOAD COMPLETE silver.dim_stocks';
        PRINT '>>>>>-------------';


		PRINT '===============================';
		PRINT 'LOADING silver.fact_sales';
		PRINT '==============================='

		-- Loading silver.fact_sales
		SET @start_time = GETDATE();
		PRINT '>>>>>TRUNCATING TABLE: silver.fact_sales';
		TRUNCATE TABLE silver.fact_sales;
		PRINT '>>>>>INSERTING TO TABLE: silver.fact_sales';

		INSERT INTO silver.fact_sales
		SELECT
			customer_id,
			invoice_no,
			invoice_date,
			stock_code_category,
			stock_name_category,
			stock_code_variant,
			stock_name_variant,
			stock_quantity,
			stock_unit_price,
			stock_quantity * stock_unit_price AS stock_sales
		FROM silver.ecommerce

		SET @end_time = GETDATE();
		PRINT '>>>>>LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' SECONDS';
        PRINT '>>>>>LOAD COMPLETE silver.fact_sales';
        PRINT '>>>>>-------------';

		SET @batch_end_time = GETDATE();
		PRINT 'BATCH LOAD DURATON ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' SECONDS';
		PRINT '>>>>>LOAD COMPLETE SILVER LAYER';
        PRINT '>>>>>-------------';
	END TRY

	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING SILVER LAYER'
		PRINT 'ERROR MESSAGE ' + ERROR_MESSAGE();
		PRINT 'ERROR NUMBER ' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR STATE ' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END
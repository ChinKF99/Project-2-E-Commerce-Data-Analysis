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
		WITH cte_cleaned_order_data AS (
		SELECT
			LTRIM(RTRIM(invoice_no)) AS invoice_no,
			LTRIM(RTRIM(stock_code)) AS stock_code,
			LTRIM(RTRIM(UPPER(REPLACE(stock_name, '"', '')))) AS stock_name,
			CAST(LTRIM(RTRIM(stock_quantity)) AS INT) as stock_quantity,
			CONVERT(DATE, invoice_date , 101) AS invoice_date,
			CAST(stock_unit_price AS FLOAT) AS stock_unit_price,
			CAST(LTRIM(RTRIM(customer_id)) AS INT) AS customer_id,
			UPPER(country) AS country
		FROM bronze.ecommerce
		-- Exclude rows which have NULL value data in these 2 column
		WHERE stock_name IS NOT NULL AND customer_id IS NOT NULL)

		-- Insert data to table using CTE: cte_cleaned_order_data
		INSERT INTO silver.ecommerce
		SELECT
			*
		FROM cte_cleaned_order_data
		ORDER BY customer_id ASC, invoice_date DESC

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

		-- CTE to clean data and add variant_id to stock with the same stock_code but different stock_unit_price
		WITH cte_clean_addvariant_stocks AS(
		SELECT
			stock_name,
			stock_code,
			stock_unit_price,
			DENSE_RANK() OVER ( PARTITION BY stock_code ORDER BY stock_unit_price ASC
			) AS variant_id
		FROM silver.ecommerce
		-- Exclude stock_name value such as Manual input, postage discount and so on
		WHERE stock_code NOT LIKE '[a-zA-Z]%'),

		--CTE to filter and keep only 1 record for each stock of each variant
		cte_filter_stocks AS(
		SELECT
			stock_name +' v' + CAST(variant_id AS NVARCHAR(10)) AS stock_name_variant,
			stock_code,
			stock_unit_price,
			variant_id,
			-- Only keep 1 record for each stock of each variant
			ROW_NUMBER() OVER ( PARTITION BY stock_name +' v' + CAST(variant_id AS NVARCHAR(10)) ORDER BY stock_unit_price ASC
			) AS flag
		FROM cte_clean_addvariant_stocks) 

		-- Insert data to table using CTE: cte_filter_stocks
		INSERT INTO silver.dim_stocks
		SELECT
			stock_name_variant,
			stock_code,
			stock_unit_price,
			variant_id
		FROM cte_filter_stocks
		WHERE flag = 1
		ORDER BY stock_code, stock_unit_price

		SET @end_time = GETDATE();
		PRINT '>>>>>LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' SECONDS';
        PRINT '>>>>>LOAD COMPLETE silver.dim_stocks';
        PRINT '>>>>>-------------';


		PRINT '===============================';
		PRINT 'LOADING silver.fact_sales';
		PRINT '==============================='

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
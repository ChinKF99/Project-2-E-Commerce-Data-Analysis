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

EXEC silver.load_silver

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME
	BEGIN TRY
		PRINT '==============================='
		PRINT 'LOADING SILVER LAYER'
		PRINT '==============================='

		-- Loading silver.construction
	    SET @start_time = GETDATE();

		PRINT '>>>>>TRUNCATING TABLE: silver.ecommerce';
		TRUNCATE TABLE silver.ecommerce;
		PRINT '>>>>>INSERTING TO TABLE: silver.ecommerce';
		INSERT INTO silver.ecommerce
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
		-- Exclude NULL values data from these 2 column
		WHERE stock_name IS NOT NULL AND customer_id IS NOT NULL
		SET @start_time = GETDATE()
		PRINT '>>>>>LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' SECONDS';
        PRINT '>>>>>LOAD COMPLETE'
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
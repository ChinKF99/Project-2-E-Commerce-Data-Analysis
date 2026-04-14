/*
===========================================================
Stored Procedure: Load bronze layer (source > bronze)
===========================================================
Script purpose:
	This stored procedure loads data into the 'bronze' schema from external csv file.
	It performs the following actions:
	- Truncates the bronze table before loading data.
	- Use the 'BULK INSERT' command to load data from csv file to bronze table.

Parameters:
	None.
	This stored procedure does not accept any parameter or return any value.

Usage:
	EXEC bronze.load_bronze;
===============================================================================
*/

USE Ecommerce
EXEC bronze.load_bronze

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
	
	BEGIN
		BEGIN TRY
			DECLARE @start_time DATETIME, @end_time DATETIME;
			PRINT '=====================';
			PRINT 'LOADING BRONZE LAYER';
			PRINT '=====================';
			SET @start_time = GETDATE();
			TRUNCATE TABLE bronze.ecommerce;
			PRINT 'INSERTING TO TABLE';
			BULK INSERT bronze.ecommerce
			-- Change the file path to local machine e.g. *FROM: Local machine File Path*
			FROM 'C:\Users\khaifoox\OneDrive - Intel Corporation\Desktop\Data Analyst Project\Project-2-E-Commerce-Data-Analysis-main\cleaned_data.csv'
			WITH(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				ROWTERMINATOR = '0x0a',
				TABLOCK
			);
			SET @end_time = GETDATE();
			PRINT 'LOADING DURATION:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT 'LOAD COMPLETE';
			PRINT '---------------------';
		END TRY

		BEGIN CATCH
		PRINT '==========================================';
			PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
			PRINT 'Error Message' + ERROR_MESSAGE();
			PRINT 'Error Number' + CAST(ERROR_NUMBER() AS NVARCHAR);
			PRINT 'Error State' + CAST(ERROR_STATE() AS NVARCHAR);
		END CATCH
	END


				

		
	


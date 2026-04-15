/*
=====================================================================
DDL Script: Create Bronze Tables
=====================================================================
Script Purposes:
	This script create tables in 'bronze' schema, dropping 
	any exiting tables if they already exists.
	Run this script to re-define the DDL structure of 'bronze' Tables
*/

USE Ecommerce

DROP TABLE IF EXISTS bronze.ecommerce
GO

CREATE TABLE bronze.ecommerce(
	invoice_no NVARCHAR(300),
	stock_code NVARCHAR(300),
	stock_name NVARCHAR(300),
	stock_quantity NVARCHAR(300),
	invoice_date NVARCHAR(300),
	stock_unit_price NVARCHAR(300),
	customer_id NVARCHAR(300),
	country NVARCHAR(300)
)
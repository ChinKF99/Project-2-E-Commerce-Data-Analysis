/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
	Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

DROP TABLE IF EXISTS silver.ecommerce
GO

CREATE TABLE silver.ecommerce (
    invoice_no NVARCHAR(50),
    stock_code NVARCHAR(50),
    stock_name NVARCHAR(100),
    stock_quantity INT,
    invoice_date DATE,
    stock_unit_price FLOAT,
    customer_id INT,
    country NVARCHAR(50)
);

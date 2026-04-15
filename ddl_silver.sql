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

USE Ecommerce

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

DROP TABLE IF EXISTS silver.dim_customers
GO

CREATE TABLE silver.dim_customers (
    customer_id INT,
    country NVARCHAR(50)
);


DROP TABLE IF EXISTS silver.dim_stocks
GO

CREATE TABLE silver.dim_stocks (
    stock_code NVARCHAR(50),
    stock_name NVARCHAR(100),
    stock_unit_price FLOAT
);


DROP TABLE IF EXISTS silver.fact_sales
GO

CREATE TABLE silver.fact_sales (
    customer_id INT,
    invoice_no NVARCHAR(50),
    invoice_date DATE,
    stock_code NVARCHAR(50),
    stock_quantity INT,
    stock_unit_price FLOAT
);

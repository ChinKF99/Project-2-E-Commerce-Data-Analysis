/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
	Run this script to re-define the DDL structure of 'silver' Tables

Usage: Execute as below
===============================================================================
*/

USE Ecommerce

DROP TABLE IF EXISTS silver.ecommerce
GO

CREATE TABLE silver.ecommerce (
    customer_id INT,
    invoice_no NVARCHAR(50),
    invoice_date DATE,
    country NVARCHAR(50),
    stock_code_category NVARCHAR(50),
    stock_name_category NVARCHAR(100),
    variant_id INT,
    stock_code_variant NVARCHAR(50),
    stock_name_variant NVARCHAR(100),
    stock_quantity INT,
    stock_unit_price FLOAT
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
    stock_code_category NVARCHAR(50),
    stock_name_category NVARCHAR(100),
    variant_id INT,
    stock_code_variant NVARCHAR(50),
    stock_name_variant NVARCHAR(100),
    stock_unit_price FLOAT
);


DROP TABLE IF EXISTS silver.fact_sales
GO

CREATE TABLE silver.fact_sales (
    customer_id INT,
    invoice_no NVARCHAR(50),
    invoice_date DATE,
    stock_code_category NVARCHAR(50),
    stock_name_category NVARCHAR(100),
    stock_code_variant NVARCHAR(50),
    stock_name_variant NVARCHAR(100),
    stock_quantity INT,
    stock_unit_price FLOAT,
    stock_sales FLOAT,
    country NVARCHAR(50)
);

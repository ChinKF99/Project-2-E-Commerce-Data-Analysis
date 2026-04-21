/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purposes:
	This script creates views for the Gold layer.
	The Gold represent the final dimension and fact tables (Star Schema)

	Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/


DROP VIEW IF EXISTS gold.dim_customers
GO

CREATE VIEW gold.dim_customers AS
SELECT
    ROW_NUMBER() OVER (ORDER BY customer_id) AS customer_key, -- Surrogate key
    customer_id  AS customer_id,
    country AS country
FROM silver.dim_customers
GO

-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================
DROP VIEW IF EXISTS gold.dim_stocks
GO

CREATE VIEW gold.dim_stocks AS
SELECT
    ROW_NUMBER() OVER (ORDER BY stock_code_variant) AS stock_key, -- Surrogate key
    stock_code_category AS stock_code_category,
    stock_name_category AS stock_name_category,
    variant_id AS variant_id,
    stock_code_variant AS stock_code_variant,
    stock_name_variant AS stock_name_variant,
    stock_unit_price AS price
FROM silver.dim_stocks
GO

-- =============================================================================
-- Create Fact Table: gold.fact_sales
-- =============================================================================
DROP VIEW IF EXISTS gold.fact_sales
GO

CREATE VIEW gold.fact_sales AS
SELECT
    customer_id AS customer_id,
    invoice_no AS invoice_no,
    invoice_date AS invoice_date,
    stock_code_category AS stock_code_category,
    stock_name_category AS stock_name_category,
    stock_code_variant AS stock_code_variant,
    stock_name_variant AS stock_name_variant,
    stock_quantity AS quantity,
    stock_unit_price AS price,
    stock_sales AS sales,
    country AS country
FROM silver.fact_sales
GO
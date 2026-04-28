/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/


-- ====================================================================
-- Checking 'silver.dim_customers'
-- ====================================================================

-- Check for NULLs or Duplicates in customer_id for *silver.dim_customers table*
-- Expectation: No Results
SELECT DISTINCT
customer_id,
COUNT(*) as duplicate
FROM silver.dim_customers
GROUP BY customer_id
HAVING count(*) >1 OR customer_id IS NULL

-- Check for NULLS & data standardization & consistency for country column
-- Expectation: No Results
SELECT DISTINCT
country
FROM silver.dim_customers
WHERE country is NULL OR country != LTRIM(RTRIM(country))

-- ====================================================================
-- Checking 'silver.dim_stocks'
-- ====================================================================

-- Check for NULLS & duplicate in stock_code_variant
-- Expectation: No Results
SELECT DISTINCT
stock_code_variant,
COUNT(*) AS duplicate
FROM silver.dim_stocks
GROUP BY stock_code_variant
HAVING count(*) >1 or stock_code_variant is NULL

-- ====================================================================
-- Checking 'silver.fact_sales'
-- ====================================================================

-- Check for NULLS for sotck_quantity, stock_unit_price, stock_unit_sales
-- Expectation: No Results
SELECT DISTINCT
stock_quantity,
stock_unit_price,
stock_sales
FROM silver.fact_sales
WHERE stock_quantity is NULL or stock_unit_price IS NULL or stock_sales IS NULL

-- Check for data accuracy, stock_quantity x stock_unit_price = stock_unit_sales
-- Expectation: No Results
SELECT DISTINCT
*
FROM silver.fact_sales
WHERE (stock_quantity * stock_unit_price) != stock_sales

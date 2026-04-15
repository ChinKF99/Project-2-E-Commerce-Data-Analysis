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
SELECT
customer_id,
COUNT(*) as duplicate
FROM silver.dim_customers
GROUP BY customer_id
HAVING count(*) >1 OR customer_id IS NULL

-- Check for NULLS & data standardization & consistency for country column
-- Expectation: No Results
SELECT 
country
FROM silver.dim_customers
WHERE country is NULL OR country != LTRIM(RTRIM(country))

-- ====================================================================
-- Checking 'silver.dim_stocks'
-- ====================================================================

-- Check for NULLS & data standardization & consistency for stock_code
-- Expectation: No Results
SELECT
stock_code,
COUNT(*)
FROM --To be filled
GROUP BY stock_code
HAVING count(*) >1 or stock_code is NULL

-- Check for NULLS & data standardization & consistency for stock_name
-- Expectation: No Results
SELECT
stock_name
FROM --To be filled
WHERE stock_name is NULL OR stock_name != LTRIM(RTRIM(stock_name))

-- Check for NULLS for sotck_quantity
-- Expectation: No Results
SELECT
stock_quantity
FROM --To be filled
WHERE stock_quantity is NULL

-- Check for NULLS for plan_end_date
-- Expectation: No Results
SELECT 
plan_end_date
FROM --To be filled
WHERE plan_end_date IS NULL

-- Check for NULLS for stock_unit_price
-- Expectation: No Results
SELECT 
stock_unit_price
FROM --To be filled
WHERE stock_unit_price IS NULL



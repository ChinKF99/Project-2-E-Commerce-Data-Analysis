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

SELECT
    stock_name_variant,
    stock_code,
    stock_unit_price,
    variant_id
FROM cte_filter_stocks
WHERE flag = 1
ORDER BY stock_code, stock_unit_price



{{ config(materialized='view') }}

WITH base_products AS (
    SELECT 
        {{ dbt_utils.generate_surrogate_key(['PRODUCTID']) }} AS product_key,
        PRODUCTID AS product_id, 
        REPLACE(PRODUCTNAME, '"', '') AS product_name, 
        REPLACE(PRODUCTDESCRIPTION, '"', '') AS product_desc, 
        CATEGORYID AS category_id, 
        COALESCE(REPLACE(QUANTITYPERUNIT, '"', ''), 'Unit') AS quantity_per_unit,
        UNITPRICE AS unit_price_usd, 
        UNITSINSTOCK AS units_in_stock, 
        UNITSONORDER AS units_on_order, 
        REORDERLEVEL AS reorder_level, 
        DISCONTINUED AS discontinued
    FROM 
        {{ ref('base_dunder_mifflin__products') }}
),

categories_with_keys AS (
    SELECT
        category_key,
        category_id
    FROM 
        {{ ref('stg_dunder_mifflin__categories') }}
),

products_with_keys AS (
    SELECT
        p.product_key,
        p.product_id,
        p.product_name,
        p.product_desc,
        c.CATEGORY_KEY AS category_id,
        p.quantity_per_unit,
        p.unit_price_usd,
        p.units_in_stock,
        p.units_on_order,
        p.reorder_level,
        p.discontinued
    FROM 
        base_products p
    JOIN 
        categories_with_keys c 
    ON 
        p.category_id = c.category_id
)

SELECT * 
FROM products_with_keys

{{ config(materialized='table') }}

WITH dim_products_cleaned AS (
    SELECT *
    FROM 
        {{ ref('stg_dunder_mifflin__products') }}
)

SELECT * 
FROM dim_products_cleaned

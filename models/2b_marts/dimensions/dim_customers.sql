{{ config(materialized='table') }}

WITH dim_customers_cleaned AS (
    SELECT *
    FROM 
        {{ ref('stg_dunder_mifflin__customers') }}
)

SELECT *
FROM dim_customers_cleaned


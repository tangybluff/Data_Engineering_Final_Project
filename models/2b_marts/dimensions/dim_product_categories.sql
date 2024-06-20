{{ config(materialized='table') }}

WITH dim_categories_cleaned AS (
    SELECT *
    FROM {{ ref('stg_dunder_mifflin__categories') }}
)

SELECT *
FROM dim_categories_cleaned

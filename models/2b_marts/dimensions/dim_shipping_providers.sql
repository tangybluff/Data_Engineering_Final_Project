{{ config(materialized='table') }}

WITH dim_shippers_cleaned AS (
    SELECT *
    FROM 
        {{ ref('stg_dunder_mifflin__shippers') }}
)

SELECT * FROM dim_shippers_cleaned


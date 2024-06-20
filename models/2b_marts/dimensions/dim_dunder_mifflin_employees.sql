
{{ config(materialized='table') }}

WITH dim_employees_cleaned AS (
    SELECT *
    FROM 
        {{ ref('stg_dunder_mifflin__employees') }}
)

SELECT * FROM dim_employees_cleaned
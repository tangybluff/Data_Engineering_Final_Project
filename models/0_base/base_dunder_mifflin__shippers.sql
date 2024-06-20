-- Here, I will create my base model for my SHIPPERS table
-- models/base/base_shippers.sql

{{ config(materialized='view') }}

WITH base_shippers AS (
    SELECT 
        SHIPPERID, 
        COMPANYNAME, 
        PHONE
    FROM 
        {{ source('DUNDER_MIFFLIN', 'SHIPPERS') }}
)

SELECT * FROM base_shippers

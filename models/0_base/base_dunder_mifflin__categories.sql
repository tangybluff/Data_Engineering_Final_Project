-- Here, I will create my base model for my CATEGORIES table
-- models/base/base_categories.sql

{{ config(materialized='view') }}

WITH base_categories AS (
    SELECT 
        CATEGORYID, 
        CATEGORYNAME, 
        DESCRIPTION
    FROM 
        {{ source('DUNDER_MIFFLIN', 'CATEGORIES') }}
)

SELECT * FROM base_categories

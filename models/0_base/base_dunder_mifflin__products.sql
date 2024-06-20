-- Here, I will create my base model for my PRODUCTS table
-- models/base/base_products.sql

{{ config(materialized='view') }}

WITH base_products AS (
    SELECT 
        PRODUCTID, 
        PRODUCTNAME, 
        PRODUCTDESCRIPTION, 
        SUPPLIERID, 
        CATEGORYID, 
        QUANTITYPERUNIT, 
        UNITPRICE, 
        UNITSINSTOCK, 
        UNITSONORDER, 
        REORDERLEVEL, 
        DISCONTINUED
    FROM 
        {{ source('DUNDER_MIFFLIN', 'PRODUCTS') }}
)

SELECT * FROM base_products

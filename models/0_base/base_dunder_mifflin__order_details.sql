-- Here, I will create my base model for my ORDERDETAILS table
-- models/base/base_orderdetails.sql

{{ config(materialized='view') }}

WITH base_orderdetails AS (
    SELECT 
        ORDERID, 
        PRODUCTID, 
        UNITPRICE, 
        QUANTITY, 
        DISCOUNT
    FROM 
        {{ source('DUNDER_MIFFLIN', 'ORDERDETAILS') }}
)

SELECT * FROM base_orderdetails

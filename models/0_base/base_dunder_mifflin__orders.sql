-- Here, I will create my base model for my ORDERS table
-- models/base/base_orders.sql

{{ config(materialized='view') }}

WITH base_orders AS (
    SELECT 
        ORDERID, 
        CUSTOMERID, 
        EMPLOYEEID, 
        ORDERDATE, 
        REQUIREDDATE, 
        SHIPPEDDATE, 
        SHIPVIA, 
        FREIGHT, 
        SHIPNAME, 
        SHIPADDRESS, 
        SHIPCITY, 
        SHIPREGION, 
        SHIPPOSTALCODE, 
        SHIPCOUNTRY
    FROM 
        {{ source('DUNDER_MIFFLIN', 'ORDERS') }}
)

SELECT * FROM base_orders

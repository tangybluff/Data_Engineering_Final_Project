{{ config(materialized='view') }}

WITH stg_orderdetails AS (
    SELECT 
        ORDERID AS order_id, 
        PRODUCTID AS product_id, 
        UNITPRICE AS unit_price_usd, 
        QUANTITY AS quantity, 
        DISCOUNT AS discount
    FROM 
        {{ ref('base_dunder_mifflin__order_details') }}
)

SELECT * FROM stg_orderdetails

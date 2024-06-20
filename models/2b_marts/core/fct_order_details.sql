{{ config(materialized='table') }}

WITH stg_orderdetails AS (
    SELECT 
        order_id, 
        product_id, 
        unit_price_usd, 
        quantity, 
        discount,
        ROUND(quantity * unit_price_usd - (quantity * unit_price_usd) * discount, 2) AS line_total_usd
    FROM 
        {{ ref('stg_dunder_mifflin__order_details') }}
),

orders AS (
    SELECT *
    FROM 
        {{ ref('stg_dunder_mifflin__orders') }}
),

products AS (
    SELECT *
    FROM 
        {{ ref('stg_dunder_mifflin__products') }}
),

joined_tables AS (
    SELECT 
        o.order_key,
        p.product_key,
        od.quantity,
        od.unit_price_usd,
        od.discount,
        od.line_total_usd
    FROM stg_orderdetails AS od
    LEFT JOIN orders AS o
        ON od.order_id = o.order_id
    LEFT JOIN products AS p
        ON od.product_id = p.product_id
)

SELECT * FROM joined_tables

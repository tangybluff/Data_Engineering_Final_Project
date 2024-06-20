{{ config(materialized='table') }}

WITH orders_cte AS (
    SELECT *
    FROM {{ ref('stg_dunder_mifflin__orders') }}
),

customers AS (
    SELECT *
    FROM 
        {{ ref('stg_dunder_mifflin__customers') }}
),

employees AS (
    SELECT *
    FROM 
        {{ ref('stg_dunder_mifflin__employees') }}
),

shippers AS (
    SELECT *
    FROM 
        {{ ref('stg_dunder_mifflin__shippers') }}
),

joined_tables AS (
    SELECT 
        o.order_key,
        c.customer_key,
        e.employee_key,
        s.shipper_key,
        o.order_date_utc,
        o.required_date_utc,
        o.shipped_date_utc,
        o.shipping_cost,
        o.destination_recipient,
        o.destination_address,
        o.destination_city,
        o.destination_region,
        o.destination_zip_code,
        o.destination_country
    FROM orders_cte AS o
    LEFT JOIN customers AS c
        ON o.customer_id = c.customer_id
    LEFT JOIN employees AS e
        ON o.employee_id = e.employee_id
    LEFT JOIN shippers AS s
        ON o.shipper_id = s.shipper_id
)

SELECT * FROM joined_tables

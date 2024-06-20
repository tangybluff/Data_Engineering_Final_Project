{{ config(materialized='view') }}

WITH orders_cte AS (
    SELECT *
    FROM {{ ref('base_dunder_mifflin__orders') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['ORDERID']) }} AS order_key,
    ORDERID AS order_id,
    CUSTOMERID AS customer_id, -- needs to be the KEY from customers staging
    EMPLOYEEID AS employee_id, -- needs to be the KEY from employees staging
    CONVERT_TIMEZONE('UTC',ORDERDATE)::DATE AS order_date_utc,
    CONVERT_TIMEZONE('UTC',REQUIREDDATE)::DATE AS required_date_utc,
    CONVERT_TIMEZONE('UTC',SHIPPEDDATE)::DATE AS shipped_date_utc,
    SHIPVIA AS shipper_id, -- needs to be the KEY from shippers staging
    FREIGHT AS shipping_cost,
    SHIPNAME AS destination_recipient,
    SHIPADDRESS AS destination_address,
    SHIPCITY AS destination_city,
    SHIPREGION AS destination_region,
    SHIPPOSTALCODE AS destination_zip_code,
    SHIPCOUNTRY AS destination_country
FROM orders_cte


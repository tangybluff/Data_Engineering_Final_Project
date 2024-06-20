-- Which clients have been making the most profitable purchases?

{{ config(materialized='table') }}

SELECT
    o.customer_key,
    c.company_name,
    SUM(d.unit_price_usd * d.quantity) AS total_revenue
FROM {{ ref('int_dunder_mifflin__order_details') }} AS d
JOIN {{ ref('int_dunder_mifflin__orders') }} AS o ON d.order_key = o.order_key
JOIN {{ ref('stg_dunder_mifflin__customers') }} AS c ON o.customer_key = c.customer_key
GROUP BY 1, 2

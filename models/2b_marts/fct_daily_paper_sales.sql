-- How many total paper sales were made each day?

{{ config(materialized='table') }}

SELECT
    DATE(o.order_date_utc) AS order_date,
    p.product_name,
    SUM(d.quantity) AS total_quantity_sold
FROM {{ ref('int_dunder_mifflin__order_details') }} AS d
JOIN {{ ref('int_dunder_mifflin__orders') }} AS o ON d.order_key = o.order_key
JOIN {{ ref('stg_dunder_mifflin__products') }} AS p ON d.product_key = p.product_key
JOIN {{ ref('stg_dunder_mifflin__categories') }} AS c ON p.category_id = c.category_key
WHERE LOWER(c.category_name) LIKE '%paper%'
GROUP BY 1, 2

-- What is the total amount of products sold by each employee?

{{ config(materialized='table') }}

SELECT
    o.employee_key,
    e.first_name || ' ' || e.last_name AS employee_name,
    p.product_name,
    SUM(d.quantity) AS total_quantity_sold
FROM {{ ref('int_dunder_mifflin__order_details') }} AS d
JOIN {{ ref('int_dunder_mifflin__orders') }} AS o ON d.order_key = o.order_key
JOIN {{ ref('stg_dunder_mifflin__employees') }} AS e ON o.employee_key = e.employee_key
JOIN {{ ref('stg_dunder_mifflin__products') }} AS p ON d.product_key = p.product_key
GROUP BY 1, 2, 3
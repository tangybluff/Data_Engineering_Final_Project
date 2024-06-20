-- Which business buys from which employees the most?

{{ config(materialized='table') }}

SELECT
    o.customer_key,
    c.company_name,
    o.employee_key,
    e.first_name || ' ' || e.last_name AS employee_name,
    SUM(d.quantity) AS total_quantity_sold
FROM {{ ref('int_dunder_mifflin__order_details') }} AS d
JOIN {{ ref('int_dunder_mifflin__orders') }} AS o ON d.order_key = o.order_key
JOIN {{ ref('stg_dunder_mifflin__customers') }} AS c ON o.customer_key = c.customer_key
JOIN {{ ref('stg_dunder_mifflin__employees') }} AS e ON o.employee_key = e.employee_key
GROUP BY 1, 2, 3, 4

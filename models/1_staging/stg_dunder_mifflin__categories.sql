{{ config(materialized='view') }}

WITH categories_cte AS (
    SELECT *
    FROM {{ ref('base_dunder_mifflin__categories') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['CATEGORYID']) }} AS category_key,
    CATEGORYID as category_id,
    CATEGORYNAME AS category_name
FROM categories_cte

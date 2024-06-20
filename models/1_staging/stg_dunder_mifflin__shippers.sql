{{ config(materialized='view') }}

WITH base_shippers AS (
    SELECT 
        {{ dbt_utils.generate_surrogate_key(['SHIPPERID']) }} AS shipper_key,
        SHIPPERID AS shipper_id, 
        COMPANYNAME AS shipping_company, 
        CONCAT(
            SUBSTR(PHONE, 2, 3), '-',
            SUBSTR(PHONE, 7, 3), '-',
            SUBSTR(PHONE, 11, 4)
        ) AS phone_num
    FROM 
        {{ ref('base_dunder_mifflin__shippers') }}
)

SELECT * FROM base_shippers


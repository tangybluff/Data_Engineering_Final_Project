{{ config(materialized='view') }}

WITH base_customers_cleaned AS (
    SELECT 
        {{ dbt_utils.generate_surrogate_key(['CUSTOMERID']) }} AS customer_key,
        CUSTOMERID AS customer_id, 
        COMPANYCODE AS company_code, 
        REPLACE(COMPANYNAME, '"', '') AS company_name,
        CONTACTNAME AS contact_name, 
        COALESCE(CONTACTTITLE, 'NONE') AS contact_title,
        ADDRESS AS address, 
        CITY AS city,
        STATE AS state, 
        POSTALCODE AS zip_code, 
        COUNTRY AS country, 
        PHONE AS phone_num
    FROM 
        {{ ref('base_dunder_mifflin__customers') }}
)

SELECT 
    customer_key,
    customer_id, 
    company_code, 
    company_name, 
    contact_name, 
    contact_title, 
    address, 
    city, 
    state, 
    zip_code, 
    country, 
    phone_num
FROM base_customers_cleaned


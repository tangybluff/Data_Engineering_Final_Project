-- Here, I will create my base model for my CUSTOMERS table
-- models/base/base_customers.sql

{{ config(materialized='view') }}

WITH base_customers AS (
    SELECT 
        CUSTOMERID, 
        COMPANYCODE, 
        COMPANYNAME, 
        CONTACTNAME, 
        CONTACTTITLE, 
        ADDRESS, 
        CITY, 
        STATE, 
        POSTALCODE, 
        COUNTRY, 
        PHONE
    FROM 
        {{ source('DUNDER_MIFFLIN', 'CUSTOMERS') }}
)

SELECT * FROM base_customers

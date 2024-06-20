-- Here, I will create my base model for my EMPLOYEES table
-- models/base/base_employees.sql

{{ config(materialized='view') }}

WITH base_employees AS (
    SELECT 
        EMPLOYEEID, 
        LASTNAME, 
        FIRSTNAME, 
        MIDDLENAME, 
        TITLE, 
        TITLEOFCOURTESY, 
        BIRTHDATE, 
        HIREDATE, 
        TERMINATIONDATE,
        ADDRESS, 
        CITY, 
        STATE, 
        POSTALCODE, 
        COUNTRY, 
        HOMEPHONE, 
        EXTENSION, 
        NOTES
    FROM 
        {{ source('DUNDER_MIFFLIN', 'EMPLOYEES') }}
)

SELECT * FROM base_employees

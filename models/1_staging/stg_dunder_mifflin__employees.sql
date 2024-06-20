
{{ config(materialized='view') }}

WITH base_employees AS (
    SELECT 
        {{ dbt_utils.generate_surrogate_key(['EMPLOYEEID']) }} AS employee_key,
        EMPLOYEEID AS employee_id, 
        LASTNAME AS last_name, 
        FIRSTNAME AS first_name, 
        MIDDLENAME AS middle_name, 
        TITLE AS job_title, 
        BIRTHDATE AS date_of_birth, 
        HIREDATE AS hire_date, 
        TERMINATIONDATE AS termination_date,
        ADDRESS AS address, 
        CITY AS city, 
        STATE AS state, 
        POSTALCODE AS zip_code, 
        COUNTRY AS country, 
        HOMEPHONE AS home_phone, 
        EXTENSION AS extension_num, 
        REPLACE(NOTES, '"', '') AS staff_notes
    FROM 
        {{ ref('base_dunder_mifflin__employees') }}
),

deceased_removed AS (
    SELECT *
    FROM base_employees
    WHERE staff_notes IS NULL OR staff_notes NOT ILIKE '%deceased%'
)

SELECT * FROM deceased_removed
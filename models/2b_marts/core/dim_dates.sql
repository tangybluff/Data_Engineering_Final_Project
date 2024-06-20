{{
  config(
    materialized='table'
  )
}}

WITH date_dimension AS (
  {{ dbt_date.get_date_dimension("1949-01-01", "2050-12-31") }}
)

SELECT 
    date_day AS full_date,
    day_of_week_name AS weekday_name,
    day_of_week_name_short AS weekday_name_short,
    day_of_month,
    week_start_date,
    week_end_date,
    month_name,
    month_name_short,
    quarter_of_year,
    quarter_start_date,
    quarter_end_date,
    year_number
FROM date_dimension

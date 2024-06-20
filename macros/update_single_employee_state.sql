{% macro update_single_employee_state() %}
    {% set sql %}
        UPDATE {{ source('DUNDER_MIFFLIN','EMPLOYEES')}}
        SET STATE = 'PA'
        WHERE EMPLOYEEID = 31
    {% endset %}

    {% do run_query(sql)%}
{% endmacro %}
--- call_func.sql

--- Call a caching PL/SQL function
connect hr/hr

select department_name, emp_count(department_id) no_of_emps
from departments
where department_name = 'Accounting'
/

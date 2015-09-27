--- query3.sql
--- Cache result of both queries, then use the cached result.

connect hr/hr
set echo on

select /*+ result_cache q_name(Q1) */ * from departments
/


select department_name, emp_count
 from (select /*+ result_cache q_name(Q2) */ 
      department_id, count(*) emp_count
      from employees
      group by department_id) e, departments d
 where e.department_id = d.department_id
/


set echo off

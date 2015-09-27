--- plan_query2.sql
set echo on
connect hr/hr

--- Generate the execution plan.
--- (The query name Q2 is optional)
explain plan for
 select department_name, emp_count
 from (select /*+ result_cache q_name(Q2) */ 
      department_id, count(*) emp_count
      from employees
      group by department_id) e, departments d
 where e.department_id = d.department_id;

set echo off

--- Display the execution plan.
@$ORACLE_HOME/rdbms/admin/utlxpls



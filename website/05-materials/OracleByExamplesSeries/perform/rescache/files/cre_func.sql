--- cre_func.sql

--- Create a function that populates the cache

connect hr/hr

create or replace function EMP_COUNT(dept_no number)
return number
result_cache relies_on (employees)
is
 v_count number;
begin
 select count(*) into v_count
 from employees
 where department_id = dept_no;

 return v_count;
end;
/ 

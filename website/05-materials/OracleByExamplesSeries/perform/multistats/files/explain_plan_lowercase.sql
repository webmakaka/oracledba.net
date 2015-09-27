explain plan for
select *
from customers_obe
where lower(country_id) = 'us';
select plan_table_output
from table(dbms_xplan.display('plan_table',null,'BASIC ROWS'));
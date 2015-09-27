explain plan for
select *
from customers_obe
where country_id = 'US' and cust_state_province = 'CA';
select plan_table_output
from table(dbms_xplan.display('plan_table',null,'BASIC ROWS'));
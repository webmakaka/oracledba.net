-- connect 
connect apps/apps; 
set timing on; 

--
var tname varchar2(30); 
var sname varchar2(30); 


-- init vars
exec :sname := 'HR_STS';


set linesize 120
col text format a30

--
-- check content of sts
--
select sql_id, plan_hash_value, buffer_gets, elapsed_time/1000000, 
       executions "#execs", substr(sql_text,1, 30) text
from user_sqlset_statements 
where sqlset_name = :sname
order by executions, sql_id, plan_hash_value;


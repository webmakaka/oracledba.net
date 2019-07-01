set timing on; 

-- declare variables 
var sts_name varchar2(30); 
var tname   varchar2(30); 

-- init variables 
exec :sts_name := 'small_gfk_sts';
exec :tname := 'tune_gfk_task';

-- create a tuning task and execute it
exec :tname := dbms_sqltune.create_tuning_task(sqlset_name => :sts_name, task_name => :tname); 

-- disable sqltune test execute
-- exec dbms_sqltune.set_tuning_task_parameter(:tname, 'TEST_EXECUTE', 'NO');

-- set local time limit 
exec dbms_sqltune.set_tuning_task_parameter(:tname, 'LOCAL_TIME_LIMIT', 20);

-- execute the task to tune sql
exec dbms_sqltune.execute_tuning_task(:tname); 

-- display results
set long 1000000 longchunksize 1000000000 linesize 200;
select dbms_sqltune.report_tuning_task(:tname, 'text', 'all', 'summary') 
from dual; 


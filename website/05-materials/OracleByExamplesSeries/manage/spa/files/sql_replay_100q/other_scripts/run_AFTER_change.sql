set long 1000000 longchunksize 1000000000 linesize 300

--
-- name execution
--------------------------------------
exec :ename := 'my_exec_AFTER_change';

--
-- make after change version 
-----------------------------------------
exec dbms_sqltune.execute_tuning_task(task_name => :tname, -
     execution_type => 'TEST EXECUTE', - 
     execution_name => :ename);
SELECT dbms_sqltune.report_tuning_task(:tname, 'text', 'all', 'summary')
FROM dual;


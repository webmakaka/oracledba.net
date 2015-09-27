set long 1000000 longchunksize 1000000000 linesize 300

-- declare 
var ename_1 varchar2(30); 
var ename_2 varchar2(30); 

-- init
exec :ename_1 := 'my_exec_BEFORE_change';
exec :ename_2 := 'my_exec_WITHOUT_change_2';

--
-- 1. make after tuning execution 
-----------------------------------
exec dbms_sqltune.execute_tuning_task(task_name => :tname, -
     execution_type => 'TEST EXECUTE', - 
     execution_name => :ename_2);

--
-- 2. compare and analyze performance 
-----------------------------------------
exec dbms_sqltune.execute_tuning_task(task_name => :tname, -
     execution_type => 'ANALYZE PERFORMANCE', - 
     execution_params => dbms_advisor.arglist( -
                         'execute_name1', :ename_1, -
                         'execute_name2', :ename_2));


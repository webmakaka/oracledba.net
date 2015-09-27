-- connect 
set long 1000000 longchunksize 1000000000 linesize 300

--
-- 1. set compare metric to be optimizer_cost just to be deterministic 
-----------------------------------------------------------------------
exec dbms_sqltune.set_tuning_task_parameter(:tname, -
     'compare_metric', 'buffer_gets'); 

--
-- 2. adjust workload impact threshold 
--------------------------------------------
-- exec dbms_sqltune.set_tuning_task_parameter(:tname, -
--     'GLOBAL_IMPACT_THRESHOLD', 0.01); 

--
-- 3. compare and analyze performance 
-----------------------------------------
exec dbms_sqltune.execute_tuning_task(task_name => :tname, -
     execution_type => 'ANALYZE PERFORMANCE');

--
-- 4. display report
--
-- SELECT dbms_sqltune.report_tuning_task(:tname, 'text', 'test_v1')
-- FROM dual;


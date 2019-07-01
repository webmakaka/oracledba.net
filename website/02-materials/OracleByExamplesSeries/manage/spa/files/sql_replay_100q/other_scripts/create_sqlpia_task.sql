SET ECHO ON
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100
SET LONG 2000000000

-- connect 
connect gfk/gfk; 
set timing on; 

-- declare vars
var tname varchar2(30); 
var sname varchar2(30); 


-- init vars
exec :sname := 'small_gfk_sts_100';
exec :tname := 'my_sqlpia_demo_task_100';


--
-- 1. create a task with a purpose of change impact analysis
------------------------------------------------------------
exec :tname := dbms_sqltune.create_tuning_task(sqlset_name => :sname, -
               task_name => :tname, task_type => 'SQLPIA');

--
-- 2. check task status
---------------------------
SELECT task_name, status 
FROM user_advisor_tasks 
WHERE task_name = :tname; 

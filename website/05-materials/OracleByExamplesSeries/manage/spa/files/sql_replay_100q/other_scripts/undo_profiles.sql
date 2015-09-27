connect gfk/gfk; 
var tname   varchar2(30); 
--
-- 1. drop any existing profiles
-- 
exec sys.dbms_sqltune_internal.test_drop_sql_profiles;
select count(*) from dba_sql_profiles; 

--
-- 2. drop the sqltune task
-- 
exec :tname := 'tune_gfk_task';
exec dbms_sqltune.drop_tuning_task(:tname);


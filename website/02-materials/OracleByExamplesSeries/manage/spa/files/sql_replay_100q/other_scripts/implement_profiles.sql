--
-- implement sql profiles recommended by sqltune 
-----------------------------------------------------------
exec dbms_sqltune.implement_tuning_task(:tname, 'PROFILES'); 

--
-- check profiles
------------------------------------
select name, status from dba_sql_profiles;


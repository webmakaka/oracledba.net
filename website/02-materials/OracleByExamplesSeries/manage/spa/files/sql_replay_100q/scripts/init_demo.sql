--
-- c. drop index that affect query_14, query_50, and query_51.
--    This will cause sever degradation. This is just 
--ALTER INDEX "ADM_PG_FEATUREVALUE_PK" UNUSABLE;
DROP INDEX "LU_ELEMENTRANGE_REL_IDX";
DROP INDEX "LU_ELEMENTGROUP_REL_IDX1";

--
-- b. drop any existing profiles
-- 
exec sys.dbms_sqltune_internal.test_drop_sql_profiles;
select count(*) from dba_sql_profiles;

--
-- 2. drop the sqltune task
-- 
var tname varchar2(30);
exec :tname := 'tune_apps_task';
exec dbms_sqltune.drop_tuning_task(:tname);

--
-- 3. drop the sqlpia task 
--
exec :tname := 'my_sqlpia_demo_task';
exec dbms_sqltune.drop_tuning_task(:tname);

--
-- 4. drop existing sql tuning set. 
--
exec dbms_sqltune.drop_sqlset('small_apps_sts');

--
-- 5. set advisor threshold for comparison
-- GP: Changing parameter name to reflect new release
exec dbms_advisor.set_default_task_parameter('SQL Performance Impact', -
     'WORKLOAD_IMPACT_THRESHOLD', 0);
exec dbms_advisor.set_default_task_parameter('SQL Performance Impact', -
     'SQL_IMPACT_THRESHOLD', 0);

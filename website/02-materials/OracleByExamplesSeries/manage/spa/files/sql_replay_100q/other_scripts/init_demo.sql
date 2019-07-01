
-- ---------------------------------------------------------------------------
-- 1. setup the enviornment before we start the demo
-- ---------------------------------------------------------------------------
--
-- a. drop indexes created 
--    when making the changes.
DROP INDEX "SCOTT"."ADM_PG_FEATUREVALUE_IDX2";
DROP INDEX "SCOTT"."LU_ELEMENTRANGE_REL_IDX";
DROP INDEX "SCOTT"."LU_ELEMENTGROUP_REL_IDX1";


--
-- b. rebuild indices on query1 affetct almost all queries.
-- ALTER INDEX "ADM_PG_FEATUREVALUE_PK" REBUILD NOLOGGING;

CREATE INDEX "LU_ELEMENTRANGE_REL_IDX" ON "LU_ELEMENTRANGE_REL" ("ELEMENTRANGE_ID" )  
PCTFREE 10 INITRANS 2 MAXTRANS 255 
STORAGE(INITIAL 65536 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) 
TABLESPACE "SYSTEM" NOLOGGING;

CREATE INDEX "LU_ELEMENTGROUP_REL_IDX1" ON "LU_ELEMENTGROUP_REL" ("ELEMENTGROUP_ID" )  
PCTFREE 10 INITRANS 2 MAXTRANS 255 
STORAGE(INITIAL 131072 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) 
TABLESPACE "SYSTEM" NOLOGGING;

--
-- b. drop any existing profiles
-- 
exec sys.dbms_sqltune_internal.test_drop_sql_profiles;
select count(*) from dba_sql_profiles; 

--
-- 2. drop the sqltune task
-- 
var tname varchar2(30); 
exec :tname := 'tune_gfk_task';
exec dbms_sqltune.drop_tuning_task(:tname);

--
-- 3. drop the sqlpia task 
--
exec :tname := 'my_sqlpia_demo_task';
exec dbms_sqltune.drop_tuning_task(:tname);

--
-- 4. drop existing sql tuning set. 
--
exec dbms_sqltune.drop_sqlset('small_gfk_sts');

--
-- 5. set advisor threshold for comparison
--
exec dbms_advisor.set_default_task_parameter('SQL Performance Impact', -
     'GLOBAL_IMPACT_THRESHOLD', 0.025); 
exec dbms_advisor.set_default_task_parameter('SQL Performance Impact', -
     'LOCAL_IMPACT_THRESHOLD', 0.025); 


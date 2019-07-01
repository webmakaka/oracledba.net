--- plan_query1.sql
connect hr/hr

--- Generate the execution plan.
--- (The query name Q1 is optional)
explain plan for
 select /*+ result_cache q_name(Q1) */ * from departments;

set echo off
--- Display the execution plan. Verify that the query result 
--- is placed in the Result Cache.
@$ORACLE_HOME/rdbms/admin/utlxpls

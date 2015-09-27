--------------------------------------------------------------------
-- create my sql tuning set and populate it from the cursor cache
connect apps/apps;

set autotrace off; 
var sts_name varchar2(30); 
exec :sts_name := 'HR_WORKLOAD';

exec dbms_sqltune.drop_sqlset(:sts_name);
exec dbms_sqltune.create_sqlset(:sts_name, 'HR SQL Workload');

DECLARE
   stscur dbms_sqltune.sqlset_cursor;
BEGIN

   OPEN stscur FOR
     SELECT VALUE(P)                              
     FROM TABLE(dbms_sqltune.select_cursor_cache(
          'sql_text like ''SELECT /* my_query%'' 
      and sql_text not like ''%ratio_to_report%'' and module =''APPS_DEMO''',
          null, null, null, null, null, null, 'ALL')) P; 

   -- populate the sqlset  
   dbms_sqltune.load_sqlset(:sts_name, stscur);

end; 
/

-- check content of sts
select sql_id, plan_hash_value, buffer_gets, elapsed_time, substr(sql_text,1, 30) text, executions
from dba_sqlset_statements 
where sqlset_name = :sts_name
order by sql_id, plan_hash_value;


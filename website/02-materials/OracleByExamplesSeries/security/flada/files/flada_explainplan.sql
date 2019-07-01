set echo on
explain plan for
SELECT employee_id, last_name, salary
FROM hr.employees
AS OF TIMESTAMP
(SYSTIMESTAMP - INTERVAL '10' MINUTE)
WHERE last_name = 'Fox'
/
set echo off
@$ORACLE_HOME/rdbms/admin/utlxpls
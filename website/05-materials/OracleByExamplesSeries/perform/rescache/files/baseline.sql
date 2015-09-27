SET ECHO ON
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 150
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 1000

connect / as sysdba

--- Establish the cache content
set serveroutput on
execute dbms_result_cache.memory_report

--- flush.sql

--- Start with a clean slate. Flush the cache and shared pool. 
--- Verify that memory was released.
connect / as sysdba


SET ECHO ON
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 150
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 1000
SET SERVEROUTPUT ON

execute dbms_result_cache.flush
alter system flush shared_pool
/
execute dbms_result_cache.memory_report

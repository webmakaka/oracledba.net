REM "******************************************* "
REM "For demo purposes ONLY:"
REM "Execute script as SYSDBA" 

CONNECT / AS SYSDBA

set echo on
set serveroutput on
-- set verify on
set term on
set lines 200
set pages 44
set pause on

/*== Create another tablespace ==*/

DROP TABLESPACE fla_tbs2 INCLUDING CONTENTS
/

CREATE SMALLFILE TABLESPACE fla_tbs2 
DATAFILE '/u01/app/oracle/oradata/orcl/fla_tbs02.dbf' 
SIZE 10M REUSE AUTOEXTEND ON NEXT 640K MAXSIZE 32767M 
NOLOGGING EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO
/
pause Press [Enter] to continue...

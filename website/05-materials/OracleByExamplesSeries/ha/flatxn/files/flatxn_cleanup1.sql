REM Execute this script script for training purposes only
REM Undo Setup for Flashback Transaction
REM Execute script as SYSDBA

set echo on
set serveroutput on
set term on
set lines 200
set pause on

connect / as sysdba

DELETE FROM hr.regions WHERE region_id=10;
DELETE FROM hr.regions WHERE region_id=20;
DELETE FROM hr.regions WHERE region_id=30;
DELETE FROM hr.regions WHERE region_id=40;
DELETE FROM hr.regions WHERE region_id=50;
COMMIT;

ALTER DATABASE DROP SUPPLEMENTAL LOG DATA (PRIMARY KEY) COLUMNS;
ALTER DATABASE DROP SUPPLEMENTAL LOG DATA;
REVOKE EXECUTE ON dbms_flashback FROM hr;
REVOKE select any transaction FROM hr;

exit

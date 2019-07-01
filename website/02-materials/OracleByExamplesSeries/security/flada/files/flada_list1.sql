REM "******************************************* "
REM "For demo purposes ONLY:"

connect / as sysdba

set echo on
set serveroutput on
-- set verify on
set term on
set lines 200
set pages 44
set pause on pause "Press [Enter] to continue ..."

/*== To list the available data dictioary views ==*/

SELECT table_name
FROM   dict
WHERE  table_name LIKE '%FLASHBACK_ARCHIVE%'
/
pause Press [Enter] to continue ...

col FLASHBACK_ARCHIVE_NAME format A25
col ARCHIVE_TABLE_NAME format A20
col TABLE_NAME format A12
col OWNER_NAME format A10

DESC dba_flashback_archive
pause Press [Enter] to continue ...

/*== To query the time when the flashback data archive(s) have been created ==*/

SELECT flashback_archive_name, create_time, status
FROM   dba_flashback_archive
/
pause Press [Enter] to continue ...

DESC dba_flashback_archive_ts
pause Press [Enter] to continue ...

/*== To list the tablespace(s), which are used for flashback data archives ==*/

SELECT * 
FROM   dba_flashback_archive_ts
/
pause Press [Enter] to continue ...

DESC dba_flashback_archive_tables
pause Press [Enter] to continue ...

/*== Query the table name(s), the owner name(s), and ==*/
/*== the internal "history" table name(s) of the flashback data archive ==*/

SELECT * 
FROM   dba_flashback_archive_tables
/

pause Press [Enter] to continue ...
clear columns

connect hr/HR

SELECT table_name
FROM   dict
WHERE  table_name LIKE '%FLASHBACK_ARCHIVE%'
/
pause Press [Enter] to continue ...
exit

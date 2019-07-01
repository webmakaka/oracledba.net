REM "******************************************* "
REM "For demo purposes ONLY:"
REM "  * Unlock HR account with the HR password"
REM "  * Setup for Flashback Data Archive"
REM "Execute script as SYSDBA" 

CONNECT / AS SYSDBA

set echo on
set serveroutput on
-- set verify on
set term on
set lines 200
set pages 44
set pause on

/*== Create a tablespace for your flashback data archive ==*/
DROP TABLESPACE fla_tbs1 INCLUDING CONTENTS
/
CREATE SMALLFILE TABLESPACE fla_tbs1 
DATAFILE '/u01/app/oracle/oradata/orcl/fla_tbs01.dbf' 
SIZE 10M REUSE AUTOEXTEND ON NEXT 640K MAXSIZE 32767M 
NOLOGGING EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO
/

/*== Set up the HR database account for this OBE ==*/
/*==  Note: The HR user has the UNLIMITED TABLESPACE system privilege. ==*/

ALTER USER hr IDENTIFIED BY "HR" ACCOUNT UNLOCK
/
/*== Setup for Flashback Data Archive completed ==*/
/*== The HR user has the password: HR ==*/

pause Press [Enter] to continue...


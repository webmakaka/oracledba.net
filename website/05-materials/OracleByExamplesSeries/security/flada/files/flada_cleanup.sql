REM Execute this script script for training purposes only
REM Undo Setup for Flashback Data Archive
REM Execute script as SYSDBA

set echo on
set serveroutput on
-- set verify on
set term on
set lines 200
set pause on

connect / as sysdba

DROP TABLESPACE fla_tbs1 INCLUDING CONTENTS
/
DROP TABLESPACE fla_tbs2 INCLUDING CONTENTS
/
ALTER USER hr PASSWORD EXPIRE ACCOUNT LOCK
/

prompt Flashback Data Archive cleanup complete.
pause Press [Enter] to continue...
exit

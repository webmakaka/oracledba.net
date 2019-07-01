set serveroutput on
set verify on
set term on
set lines 200
set echo on
set pause off

connect / as sysdba

ALTER TABLE sf_demo.resumes
MODIFY LOB(resume)
(DEDUPLICATE LOB
COMPRESS HIGH)
/

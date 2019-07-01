set serveroutput on
set verify on
set term on
set lines 200
set pause off
set echo on

connect / as sysdba

ALTER TABLE sf_demo.resumes
MODIFY (resume ENCRYPT USING 'AES192')
/

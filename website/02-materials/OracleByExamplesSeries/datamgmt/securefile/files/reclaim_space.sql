set serveroutput on
-- set verify on
set term on
set lines 200
set pause off
set echo on

connect / as sysdba

ALTER TABLE sf_demo.resumes ENABLE ROW MOVEMENT
/
ALTER TABLE sf_demo.resumes SHRINK SPACE COMPACT
/
ALTER TABLE sf_demo.resumes SHRINK SPACE
/

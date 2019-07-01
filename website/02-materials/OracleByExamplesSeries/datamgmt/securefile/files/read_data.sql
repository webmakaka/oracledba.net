connect sf_demo/oracle

set serveroutput on
set verify on
set term on
set lines 200

timing start read_data
exec read_lob;
timing stop


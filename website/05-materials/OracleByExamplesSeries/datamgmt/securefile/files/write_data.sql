connect sf_demo/oracle

set serveroutput on
set verify on
set term on
set lines 200

timing start load_data 
exec write_lob('karl.brimmer.doc');
exec write_lob('monica.petera.doc');
exec write_lob('david.sloan.doc');
timing stop


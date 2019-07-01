
set echo on
set serveroutput on

begin
 for i in 1..654321 loop
  insert into t values(s.nextval,'first');
  commit;
 end loop;
end;
/

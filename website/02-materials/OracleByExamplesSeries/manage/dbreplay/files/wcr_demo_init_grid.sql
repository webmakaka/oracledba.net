SET ECHO ON
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100


connect scott/tiger

delete from wcr_grid;

declare
  id number;
  x  number;
  y  number;
  c  varchar2(100);
begin
  x := 0;
  y := 0;
  id := 0;
  c := 'black';

  for i in 1..10 loop

    for i in 1..10 loop

      insert into wcr_grid values (id, x, y, c);
      y := y + 1;
      id := id + 1;  

    end loop;

    x := x + 1;
    y := 0;

  end loop;
end;
/

commit;

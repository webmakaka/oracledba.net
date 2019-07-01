SET ECHO ON
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100

connect scott/tiger

drop table wcr_grid;
/

create table wcr_grid
(  pixid                number         not null
  ,xcoor                number         not null
  ,ycoor                number         not null
  ,color                varchar2(30)   not null
  ,constraint wcr_grid_pk primary key (pixid)
)
/

@wcr_demo_init_grid

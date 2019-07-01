SET ECHO ON
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100

connect scott/tiger

REM drop them
drop index wcr_grid_xcoor_ycoor;
drop index wcr_grid_pixid_xcoor_ycoor;
drop index wcr_grid_pixid_xcoor;
drop index wcr_grid_pixid_ycoor;
drop index wcr_grid_pixid_xcoor_color;
drop index wcr_grid_pixid_ycoor_color;
drop index wcr_grid_pixid_color;
drop index wcr_grid_xcoor_color;
drop index wcr_grid_ycoor_color;

REM create them
create index wcr_grid_xcoor_ycoor on wcr_grid(xcoor, ycoor);
create index wcr_grid_pixid_xcoor_ycoor on wcr_grid(pixid, xcoor, ycoor);
create index wcr_grid_pixid_xcoor on wcr_grid(pixid, xcoor);
create index wcr_grid_pixid_ycoor on wcr_grid(pixid, ycoor);
create index wcr_grid_pixid_xcoor_color on wcr_grid(pixid, xcoor, color);
create index wcr_grid_pixid_ycoor_color on wcr_grid(pixid, ycoor, color);
create index wcr_grid_pixid_color on wcr_grid(pixid, color);
create index wcr_grid_xcoor_color on wcr_grid(xcoor, color);
create index wcr_grid_ycoor_color on wcr_grid(ycoor, color);

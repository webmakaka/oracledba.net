drop table TypesTab;

create table TypesTab(
	num number, 
	bfloat binary_float, 
	bdouble binary_double, 
	vchar2 varchar2(24), 
	xchar char(24), 
	xraw raw(24), 
	xdat date);
	
insert into TypesTab values (
	111, 
	10000000.000001,
	1000000000000.000000002, 
 	'this is a varchar2', 
	'this is a char', 
	hextoraw (lpad ('b', 24, 'b')), 
	'19-Apr-2005');
commit;
select * from TypesTab;

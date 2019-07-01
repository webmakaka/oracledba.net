begin

dbms_stats.gather_schema_stats(
ownname=> '"APPS"' ,
options=> 'GATHER AUTO');

dbms_stats.gather_schema_stats(
ownname=> '"SCOTT"' ,
options=> 'GATHER AUTO');

end;
	

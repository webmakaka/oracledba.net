#!/bin/bash

export ORACLE_SID=orcl

export ORACLE_HOME=/u01/app/oracle/product/11.1.0/db_1

export PATH=/u01/app/oracle/product/11.1.0/db_1/bin:/bin:/usr/bin:/usr/local/bin:/usr/X11R6/bin

sqlplus / as sysdba <<FIN!

set echo on

variable obj number;

begin
select object_id into :obj from dba_objects where owner='HR' and object_name='OBETABLE';
end;
/

print obj;

update tab$ set cols=1 where obj#=:obj;

commit;

FIN!


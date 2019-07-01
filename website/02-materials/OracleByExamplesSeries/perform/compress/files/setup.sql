connect / as sysdba
set echo on
alter user sh identified by sh account unlock;
grant create tablespace to sh;
grant drop tablespace to sh;

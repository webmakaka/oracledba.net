set echo on
exec sys.dbms_sqltune.create_sqlset(sqlset_name  => 'SPM_STS', -
                                   sqlset_owner => 'SYS'); 

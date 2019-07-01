connect sf_demo/oracle
set pause off
set echo on

col TABLE_NAME format a18;
col COLUMN_NAME format a19;
col ENCRYPTION_ALG format a17;

SELECT *
FROM USER_ENCRYPTED_COLUMNS
/


-- run this script as SYS
connect / as sysdba

set echo on;
set serveroutput on
set term on;
set lines 200

set pause off

/*== Check the current segment type of the LOB ==*/
/*==                                           ==*/
/*== Note that the segment subtype for         ==*/
/*== BasicFile LOB storage is ASSM             ==*/

SELECT segment_name, segment_type, segment_subtype 
FROM dba_segments
WHERE tablespace_name = 'OBE_TBS1'
AND segment_type = 'LOBSEGMENT' 
/

pause Press [Enter] to continue...

set pause on

/*== Create the interim table for online redefinition ==*/
/*==
/*== Note that the recommended practice is to enable  ==*/
/*== COMPRESSION and DEDUPLICATION at table createion ==*/
/*== time. Also, the ALTER TABLE SHRINK operation is  ==*/
/*== not yet supported for SecureFiles LOBs in        ==*/
/*== release 1 of Oracle Database 11g.                ==*/

CREATE TABLE sf_demo.resumes_interim
(id NUMBER, first_name VARCHAR2(15),
last_name VARCHAR2 (40), resume BLOB)
LOB (resume) STORE AS SECUREFILE
(TABLESPACE obe_tbs2
 COMPRESS HIGH
 DEDUPLICATE)
/

pause Press [Enter] to continue...

/*== Perform the online redefinition ==*/

DECLARE
 error_count PLS_INTEGER := 0;
BEGIN

DBMS_REDEFINITION.START_REDEF_TABLE
('sf_demo', 'resumes', 'resumes_interim',
 'id id, first_name first_name, last_name last_name, resume resume',
 OPTIONS_FLAG => DBMS_REDEFINITION.CONS_USE_ROWID);
 
DBMS_REDEFINITION.COPY_TABLE_DEPENDENTS
('sf_demo', 'resumes', 'resumes_interim', 
1, true,true,true,false, error_count);

DBMS_OUTPUT.PUT_LINE('Errors := ' || TO_CHAR(error_count));
 
DBMS_REDEFINITION.FINISH_REDEF_TABLE
('sf_demo', 'resumes', 'resumes_interim');

END;
/

pause Press [Enter] to continue...

/*== Drop the interim table ==*/

DROP TABLE sf_demo.resumes_interim
/

pause Press [Enter] to continue...

set pause off

/*== Check the segment type of the migrated LOB ==*/
/*==                                            ==*/
/*== Note that the segment subtype for          ==*/
/*== SecureFiles LOB storage is SECUREFILE      ==*/

SELECT segment_name, segment_type, segment_subtype 
FROM dba_segments
WHERE tablespace_name = 'OBE_TBS2'
AND segment_type = 'LOBSEGMENT'
/
pause Press [Enter] to continue...

set pause off

/*== Check the DBA_LOBS data dictionary view for ==*/
/*== information on the SecureFiles COMPRESSION  ==*/
/*== and DEDUPLICATION settings                  ==*/

SELECT column_name, segment_name,
       compression, deduplication, securefile
FROM dba_lobs
WHERE owner = 'SF_DEMO' and table_name = 'RESUMES'
/


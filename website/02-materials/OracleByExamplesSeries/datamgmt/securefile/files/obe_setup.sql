-- run this script as SYS
connect / as sysdba

set echo on;
set serveroutput on
-- set verify on;
set term on;
set lines 200
set pause on

/*== Store the encryption key in the TDE wallet ==*/

ALTER SYSTEM SET ENCRYPTION KEY AUTHENTICATED BY "oracle"
/

pause Press [Enter] to continue...


/*== Create a database account for this OBE ==*/

DROP USER sf_demo CASCADE
/

CREATE USER sf_demo IDENTIFIED BY oracle
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users
/

GRANT connect, resource TO sf_demo
/

GRANT EXECUTE ANY PROCEDURE, CREATE ANY DIRECTORY TO sf_demo
/ 

pause Press [Enter] to continue...

/*== Create tablespaces to store the LOB tables     ==*/
/*==                                                ==*/
/*== Note that SecureFile LOB storage requires ASSM.==*/
/*== The segment allocation unit is 64MB.           ==*/

DROP TABLESPACE obe_tbs1 INCLUDING CONTENTS
/

CREATE TABLESPACE obe_tbs1
DATAFILE 'obe_tbs1.dbf' SIZE 150M REUSE
EXTENT MANAGEMENT LOCAL
UNIFORM SIZE 64M
SEGMENT SPACE MANAGEMENT AUTO
/

DROP TABLESPACE obe_tbs2 INCLUDING CONTENTS
/

CREATE TABLESPACE obe_tbs2
DATAFILE 'obe_tbs2.dbf' SIZE 150M REUSE
EXTENT MANAGEMENT LOCAL
UNIFORM SIZE 64M
SEGMENT SPACE MANAGEMENT AUTO
/

pause Press [Enter] to continue...

/*== As SF_DEMO, create a table with a LOB that uses BasicFile LOB storage ==*/

connect sf_demo/oracle

CREATE TABLE resumes 
(id NUMBER, first_name VARCHAR2(15),
last_name VARCHAR2(40), resume BLOB)
LOB(resume) STORE AS BASICFILE 
(TABLESPACE obe_tbs1)
/

pause Press [Enter] to continue...

/*== Create a DIRECTORY object. It is required for accessing the MS Word files ==*/
/*== to be loaded into the LOB column. Enter the full path to the files, omit  ==*/
/*== the final "/" at the end.                                                 ==*/
 
CREATE OR REPLACE DIRECTORY cwd AS '&directory_name';

pause Press [Enter] to continue...

/*== Create the procedure to read the MS Word files and load them into the LOB column ==*/

CREATE OR REPLACE PROCEDURE loadLOBFromBFILE_proc (dest_loc IN OUT BLOB, file_name IN VARCHAR2)
IS
   src_loc        BFILE := BFILENAME('CWD', file_name);
   amount         INTEGER := 4000;
BEGIN

   DBMS_LOB.OPEN(src_loc, DBMS_LOB.LOB_READONLY);
   amount := DBMS_LOB.GETLENGTH(src_loc);
   DBMS_LOB.LOADFROMFILE(dest_loc, src_loc, amount);
   DBMS_LOB.CLOSE(src_loc);

END;
/

show errors

pause Press [Enter] to continue...

/*== Create the procedure to insert LOBs into the table ==*/

CREATE OR REPLACE PROCEDURE write_lob (p_file IN VARCHAR2)
IS
 i  NUMBER;
 fn VARCHAR2(15);
 ln VARCHAR2(40);
 b  BLOB;

BEGIN
DBMS_OUTPUT.ENABLE;
DBMS_OUTPUT.PUT_LINE('Begin inserting rows...');
  FOR i IN 1 .. 30 LOOP
    fn:=SUBSTR(p_file,1,INSTR(p_file,'.')-1);
    ln:=SUBSTR(p_file,INSTR(p_file,'.')+1,LENGTH(p_file)-INSTR(p_file,'.')-4);
    INSERT INTO resumes VALUES (i, fn, ln, EMPTY_BLOB())
      RETURNING resume INTO b;
    loadLOBFromBFILE_proc(b,p_file);
    DBMS_OUTPUT.PUT_LINE('Row '|| i ||' inserted.');
  END LOOP;
  COMMIT;
END;
/

show errors

pause Press [Enter] to continue...

/*== Create the procedure to read LOBs from the table ==*/

CREATE OR REPLACE PROCEDURE read_lob
IS
     lob_loc         BLOB;
     CURSOR resumes_cur IS
       SELECT id, first_name, last_name, resume 
       FROM resumes;
     resumes_rec     resumes%ROWTYPE;
  BEGIN
  OPEN resumes_cur;
  LOOP
    FETCH resumes_cur INTO resumes_rec;
     lob_loc := resumes_rec.resume;
     DBMS_OUTPUT.PUT_LINE('The length is: '|| DBMS_LOB.GETLENGTH(lob_loc));
     DBMS_OUTPUT.PUT_LINE('The ID is: '|| resumes_rec.id);
     -- just print out the first 200 bytes of the LOB
     -- because DBMS_OUTPUT.PUT_LINE cannot display more than 255 bytes
     DBMS_OUTPUT.PUT_LINE('The blob is read: '||
             UTL_RAW.CAST_TO_VARCHAR2(DBMS_LOB.SUBSTR(lob_loc,200,1)));
    EXIT WHEN resumes_cur%NOTFOUND;
   END LOOP;
 CLOSE resumes_cur;
END;
/
show errors

pause Press [Enter] to continue...

/*== Create a procedure for checking BasicFile LOB space usage. ==*/
/*==                                                            ==*/
/*== Note that the DBMS_SPACE.SPACE_USAGE procedure has been    ==*/
/*== overloaded. There are 2 DBMS_SPACE.SPACE_USAGE procedures. ==*/
/*== The two cannot be used interchangeably. The invocation of  ==*/
/*== the DBMS_SPACE.SPACE_USAGE procedure here is ONLY valid    ==*/
/*== for use against BasicFile LOBs.                            ==*/

CREATE OR REPLACE PROCEDURE check_space_bf 
IS

   l_fs1_bytes NUMBER;
   l_fs2_bytes NUMBER;
   l_fs3_bytes NUMBER;
   l_fs4_bytes NUMBER;
   l_fs1_blocks NUMBER;
   l_fs2_blocks NUMBER;
   l_fs3_blocks NUMBER;
   l_fs4_blocks NUMBER;
   l_full_bytes NUMBER;
   l_full_blocks NUMBER;
   l_unformatted_bytes NUMBER;
   l_unformatted_blocks NUMBER;
   v_segname VARCHAR2(500);
BEGIN 
   SELECT segment_name 
   INTO v_segname 
   FROM user_lobs 
   WHERE table_name = 'RESUMES'
   AND column_name = 'RESUME';   

   DBMS_SPACE.SPACE_USAGE( 
      segment_owner      => 'SF_DEMO',
      segment_name       => v_segname, 
      segment_type       => 'LOB', 
      fs1_bytes          => l_fs1_bytes,
      fs1_blocks         => l_fs1_blocks, 
      fs2_bytes          => l_fs2_bytes,
      fs2_blocks         => l_fs2_blocks, 
      fs3_bytes          => l_fs3_bytes,
      fs3_blocks         => l_fs3_blocks,
      fs4_bytes          => l_fs4_bytes,
      fs4_blocks         => l_fs4_blocks,
      full_bytes         => l_full_bytes,
      full_blocks        => l_full_blocks,
      unformatted_blocks => l_unformatted_blocks,
      unformatted_bytes  => l_unformatted_bytes
   );
   DBMS_OUTPUT.ENABLE;
   DBMS_OUTPUT.PUT_LINE(' FS1 Blocks = '||l_fs1_blocks||' Bytes = '||l_fs1_bytes);
   DBMS_OUTPUT.PUT_LINE(' FS2 Blocks = '||l_fs2_blocks||' Bytes = '||l_fs2_bytes);
   DBMS_OUTPUT.PUT_LINE(' FS3 Blocks = '||l_fs3_blocks||' Bytes = '||l_fs3_bytes);
   DBMS_OUTPUT.PUT_LINE(' FS4 Blocks = '||l_fs4_blocks||' Bytes = '||l_fs4_bytes);
   DBMS_OUTPUT.PUT_LINE('Full Blocks = '||l_full_blocks||' Bytes = '||l_full_bytes);
   DBMS_OUTPUT.PUT_LINE('Unformatted Blocks = '||l_unformatted_blocks||' Bytes = '||l_unformatted_bytes);
   DBMS_OUTPUT.PUT_LINE('=============================================');
   DBMS_OUTPUT.PUT_LINE('Total Blocks = '||to_char(l_fs1_blocks + l_fs2_blocks +
                             l_fs3_blocks + l_fs4_blocks + l_full_blocks)||  ' ||  Total Bytes = '||
                             to_char(l_fs1_bytes + l_fs2_bytes +
                             l_fs3_bytes + l_fs4_bytes + l_full_bytes));
END;
/

show errors

pause Press [Enter] to continue...

/*== Create a procedure for checking SecureFiles LOB space usage. ==*/
/*==                                                              ==*/ 
/*== Note that the DBMS_SPACE.SPACE_USAGE procedure has been      ==*/
/*== overloaded. There are 2 DBMS_SPACE.SPACE_USAGE procedures.   ==*/
/*== The two cannot be used interchangeably. The invocation of    ==*/
/*== the DBMS_SPACE.SPACE_USAGE procedure here is ONLY valid      ==*/
/*== for use against SecureFiles LOBs.                            ==*/

CREATE OR REPLACE PROCEDURE check_space_sf
IS
   l_segment_size_blocks NUMBER;
   l_segment_size_bytes NUMBER;
   l_used_blocks NUMBER;
   l_used_bytes NUMBER;
   l_expired_blocks NUMBER;
   l_expired_bytes NUMBER;
   l_unexpired_blocks NUMBER;
   l_unexpired_bytes NUMBER;
   v_segname varchar2(30);
BEGIN 
   SELECT segment_name 
   INTO v_segname 
   FROM user_lobs 
   WHERE table_name = 'RESUMES'
   AND column_name = 'RESUME';   
   DBMS_SPACE.SPACE_USAGE( 
      segment_owner      => 'SF_DEMO',
      segment_name       => v_segname, 
      segment_type       => 'LOB', 
      segment_size_blocks => l_segment_size_blocks,
      segment_size_bytes  => l_segment_size_bytes,
      used_blocks         => l_used_blocks, 
      used_bytes          => l_used_bytes,
      expired_blocks         => l_expired_blocks, 
      expired_bytes          => l_expired_bytes,
      unexpired_blocks         => l_unexpired_blocks,
      unexpired_bytes          => l_unexpired_bytes
   );
   DBMS_OUTPUT.ENABLE;
   DBMS_OUTPUT.PUT_LINE(' Segment Blocks = '||l_segment_size_blocks||' Bytes = '||l_segment_size_bytes);
   DBMS_OUTPUT.PUT_LINE(' Used Blocks = '||l_used_blocks||' Bytes = '||l_used_bytes);
   DBMS_OUTPUT.PUT_LINE(' Expired Blocks = '||l_expired_blocks||' Bytes = '||l_expired_bytes);
   DBMS_OUTPUT.PUT_LINE(' Unexpired Blocks = '||l_unexpired_blocks||' Bytes = '||l_unexpired_bytes);
   DBMS_OUTPUT.PUT_LINE('=============================================');
END;
/
show errors


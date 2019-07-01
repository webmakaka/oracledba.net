create or replace and resolve java source named ClobClass  as
/*
 *	ClobClass.java
 */

import java.sql.*;
import oracle.sql.*;
import oracle.jdbc.*;

public class ClobClass
{
  /*
   * Insert a Clob into XobTab and returns the modified Clob
   * Notice IN and OUT parameters are passed as array of NUMBER andarray of Blob 
   */
   
  public static void Clobproc (NUMBER id[], Clob cl[]) throws SQLException
  {
    Connection conn = DriverManager.getConnection ("jdbc:oracle:kprb:");
    Statement stmt = conn.createStatement();

    OraclePreparedStatement ps = (OraclePreparedStatement)
       conn.prepareStatement ("INSERT INTO XobTab (ID, Clob_col) VALUES(?, ?)");

    ps.setNUMBER (1, id[0]);
    ps.setClob (2, cl[0]);
    ps.execute ();
    ps.close();

    String buf = "This is an Outbound CLOB";
    long amount = buf.length();

    OracleCallableStatement cs =
      (OracleCallableStatement)
        conn.prepareCall ("begin dbms_lob.writeappend (?, ?, ?); end;");

    cs.setClob (1, cl[0]);
    cs.setLong (2, amount);
    cs.setString (3, buf);
    cs.registerOutParameter (1, OracleTypes.CLOB);
    cs.execute ();

    cl[0] = cs.getClob (1);
    id[0] = new NUMBER(id[0].intValue() + 1000);
    cs.close();
  }
}
/
show errors;

create or replace procedure Clobwrap (x IN OUT number, y IN OUT Clob) 
  as language java
  name 'ClobClass.Clobproc(oracle.sql.NUMBER[], java.sql.Clob[])';
/

show errors;
set serveroutput on
declare
x Clob;
a number;
begin
  select id+200, Clob_col into a, x from Xobtab where id = 1 for update;
 
  dbms_output.put_line('IN ID NUMBER = ' || a);
  dbms_output.put_line('IN CLOB length = ' || dbms_lob.getlength(x));
 
  Clobwrap(a, x);
 
  dbms_output.put_line('OUT ID NUMBER = ' || a);
  dbms_output.put_line('OUT CLOB length = ' || dbms_lob.getlength(x));
end;
/




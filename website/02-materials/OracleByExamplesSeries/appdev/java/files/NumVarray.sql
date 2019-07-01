create or replace and resolve java source named NVarrayClass  as
/*
 *	NUMBER VARRAY 
 */

import java.sql.*;
import oracle.sql.*;
import oracle.jdbc.*;

public class NVarrayClass
{
 public static void nvaproc (NUMBER id[], Array va[], Array va2) 
    throws SQLException
  {
    Connection conn = DriverManager.getConnection ("jdbc:oracle:kprb:");
    Statement stmt = conn.createStatement();

    OraclePreparedStatement ps = (OraclePreparedStatement)
       conn.prepareStatement ("INSERT INTO VarrayTab (ID, NVA) VALUES(?, ?)");

    ps.setNUMBER (1, id[0]);
    ps.setARRAY (2, (ARRAY)va[0]);
    ps.execute ();
    ps.close();
    id[0] = new NUMBER(id[0].intValue() + 1000);
    va[0] = va2;
  }

 public static Array nvafunc(NUMBER id[], Array va[], Array va2) 
    throws SQLException
  {

    Connection conn = DriverManager.getConnection ("jdbc:oracle:kprb:");
    Statement stmt = conn.createStatement();

    OraclePreparedStatement ps = (OraclePreparedStatement)
       conn.prepareStatement ("SELECT NVA FROM VarrayTab WHERE ID = ? ");
    ps.setNUMBER (1, id[0]);
    OracleResultSet rs = (OracleResultSet) ps.executeQuery();
    Array a = null;
    while (rs.next())
    {
      a = (Array) rs.getObject(1);
    }
    ps.close();
   
    id[0] = new NUMBER(id[0].intValue() + 1000);
    va[0] = va2;
    return a;
  }
}
/
show errors;

create or replace procedure nvaproc (x IN OUT number, y IN OUT NVARRAY, 
  z IN NVARRAY) 
  as language java
  name 'NVarrayClass.nvaproc(oracle.sql.NUMBER[], java.sql.Array[],
        java.sql.Array)';
/
show errors;

create or replace function nvafunc (x IN OUT number, y IN OUT NVARRAY, 
  z IN NVARRAY) return NVARRAY 
  as language java
  name 'NVarrayClass.nvafunc(oracle.sql.NUMBER[], java.sql.Array[],
        java.sql.Array) return java.sql.Array';
/

show errors;

set serveroutput on
declare
a number;
x NVARRAY;
y NVARRAY;
z NVARRAY;
begin

  dbms_output.put_line('Calling Number VARRAY Procedure ');
  a := 11;
  x := NVARRAY(101, 102, 103, 104, 105, 106);
  y := NVARRAY(201, 202, 203, 204, 205, 206);

  dbms_output.put_line('IN number = ' || a);
  for i IN 1 .. x.COUNT loop
    dbms_output.put(x(i) || ' ');
  end loop;
  dbms_output.put_line(' '); 
 
  nvaproc(a, x, y);
 
  dbms_output.put_line('OUT ID = ' || a);
   dbms_output.put_line('OUT X = ');
  for i IN 1 .. x.COUNT loop
    dbms_output.put(x(i) || ' ');
  end loop;
  dbms_output.put_line(' ');   
  
  dbms_output.put_line('Calling Number VARRAY Function ');   
  a := 1;
  x := NVARRAY(101, 102, 103, 104, 105, 106);
  y := NVARRAY(201, 202, 203, 204, 205, 206);

  dbms_output.put_line(' ');

  z := nvafunc(a, x, y);

  dbms_output.put_line('OUT ID = ' || a);
  dbms_output.put_line('OUT X = ');
  for i IN 1 .. x.COUNT loop
    dbms_output.put(x(i) || ' ');
  end loop;     
  dbms_output.put_line(' ');

  dbms_output.put_line('OUT Z = ');
  for i IN 1 .. z.COUNT loop
    dbms_output.put(z(i) || ' ');
  end loop;  
  dbms_output.put_line(' ');

end;
/


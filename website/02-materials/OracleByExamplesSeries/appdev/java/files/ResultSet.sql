create or replace and resolve java source named refcur as
import java.sql.*;
import java.io.*;
import oracle.jdbc.*;
/*
 *  Mapping REF CURSOR to java.sql.Resultset
 */
public class refcur
{
  /*
   * Procedure returning a REF CURSOR via OUT parameter
   */
  public static void refcurproc (ResultSet rs[])
    throws SQLException
  {
    Connection conn = null;  
    conn = DriverManager.getConnection("jdbc:oracle:kprb:");
    ((OracleConnection)conn).setCreateStatementAsRefCursor(true);
    Statement stmt = conn.createStatement();
    ((OracleStatement)stmt).setRowPrefetch(1);
    ResultSet rset = stmt.executeQuery("select * from EMPLOYEES order by employee_id");
    rs[0] = rset;
    // fetch one row
    if (rset.next())
    {
      System.out.println("last_name = " + rset.getString(2));
    }
   }

  /*
   * Function returning a REF CURSOR 
   */
  public static ResultSet refcurfunc ()
    throws SQLException
  {
    Connection conn = null;  
    conn = DriverManager.getConnection("jdbc:oracle:kprb:");
    ((OracleConnection)conn).setCreateStatementAsRefCursor(true);
    Statement stmt = conn.createStatement();
    ((OracleStatement)stmt).setRowPrefetch(1);
    ResultSet rset = stmt.executeQuery("select * from EMPLOYEES order by employee_id");
    // fetch one row
    if (rset.next())
    {
      System.out.println("last_name = " + rset.getString(2));
    }
    return rset;
   }
}
/
show errors;


create or replace package refcur_pkg as
type EmpCurTyp IS REF CURSOR;
  function rcfunc return EmpCurTyp;
  procedure rcproc (rc OUT EmpCurTyp);
end refcur_pkg;
/
show errors;

create or replace package body refcur_pkg as 
 
procedure rcproc(rc OUT EmpCurTyp)
 as language java 
 name 'refcur.refcurproc(java.sql.Resultset[])';
 
function rcfunc return EmpCurTyp
 as language java 
 name 'refcur.refcurfunc() returns java.sql.ResultSet';

end refcur_pkg;
/
show errors;

set serveroutput on
call dbms_java.set_output(50000)

declare
  type EmpCurTyp IS REF CURSOR;
  rc EmpCurTyp;
  employee employees%ROWTYPE;
begin
  dbms_output.put_line(' ** Calling REF CURSOR FUNCTION' );
  
rc := refcur_pkg.rcfunc();
---
--- Alternatively the refcurfunc could be called as follows 
--refcur_pkg.rcproc(rc);
---
  LOOP
  	fetch rc into employee;
  	exit when rc%notfound;
  	dbms_output.put_line(' Name = ' || employee.last_name ||
            ' Department = ' || employee.department_id);
  end loop;
close rc;
end;
/
show errors;


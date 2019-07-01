create or replace java source named orasqlCHAR as 
/*
 * Mapping oracle.sql.CHAR  to/from SQL CHAR
 */
import java.sql.*;
import java.io.*;
import oracle.sql.*;
import oracle.jdbc.*;

public class orasqlCHAR 
{

 /* 
  * Map oracle.sql.CHAR to SQL CHAR 
  */ 

  public static void xputChar (CHAR c) throws SQLException
  {   
    Connection conn =
    	DriverManager.getConnection("jdbc:default:connection:");
  
    
    OraclePreparedStatement ops = (OraclePreparedStatement) 
       conn.prepareStatement("UPDATE TypesTab SET xchar = ?");
    ops.setCHAR (1, c);
    ops.execute();
    ops.close();
   }

  
   /* 
    * Map SQL CHAR column to oracle.sq.CHAR
    */     

  public static CHAR xgetChar() throws SQLException
  {      
    Connection conn =
    	DriverManager.getConnection("jdbc:default:connection:"); 	
    OracleStatement ostmt = (OracleStatement) conn.createStatement();
    CHAR ochar = null; 
    OracleResultSet ors = 
        (OracleResultSet) ostmt.executeQuery("SELECT xchar FROM TypesTab");
    while (ors.next()) 
    {
      ochar = ors.getCHAR(1);
    }
    ostmt.close();
    return ochar;   
  }
}

/
show errors;
alter java source orasqlCHAR compile;
show errors;

create or replace procedure putoraCHAR (c CHAR)
  as language java
  name 'orasqlCHAR.xputChar (oracle.sql.CHAR)';
/
show errors;

create or replace function getoraCHAR return CHAR 
  as language java
  name 'orasqlCHAR.xgetChar() return oracle.sql.CHAR';
/
show errors;

call putoraCHAR('Fooooooooooo');
set serveroutput on 
select getoraCHAR from dual;



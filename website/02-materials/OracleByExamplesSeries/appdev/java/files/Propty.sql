create or replace and resolve java source named propty as
import java.sql.*;
import java.util.*;
import java.io.*;

public class propty 
{

 public static void getppty(String fname) throws java.io.IOException
 {
  InputStream is     = null;
  
    // load from properties file
    is = ClassLoader.getSystemResourceAsStream(fname);
    Properties p = new Properties();
    p.load(is);
    is.close();
 
    // Print poperties values      
    System.out.println ("foo in config file: " + p.getProperty("foo"));
    System.out.println ("bar in config file: " + p.getProperty("bar"));
    System.out.println ("url in config file: " + p.getProperty("url"));
    System.out.println ("sid in config file: " + p.getProperty("sid"));
  }
}
/
show errors;
create or replace procedure getproperties(a varchar2)
  as language java name 
  'propty.getppty()';
/
show errors;


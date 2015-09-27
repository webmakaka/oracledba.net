create or replace and resolve java source named memtest  as
import oracle.aurora.vm.OracleRuntime;
public class memtest
{
/*
 * The following code sample is provided for for illustration purposes only.
 * The default values should work for most applications.
 * Before altering these values for your production system, please
 * go under tuning and testing exercices beforehand
 */
 public static void Tests ()
 {
    System.out.println("getSessionSize(): "
                               + OracleRuntime.getSessionSize());
                               
    System.out.println("Old NewspaceSize(): "
                               + OracleRuntime.getNewspaceSize());
    OracleRuntime.setNewspaceSize(2 * OracleRuntime.getNewspaceSize());                          
    System.out.println("New NewspaceSize(): "
                               + OracleRuntime.getNewspaceSize());
                               
    System.out.println("Old MaxRunspaceSize(): "
                               + OracleRuntime.getMaxRunspaceSize());
    OracleRuntime.setMaxRunspaceSize(2 * OracleRuntime.getMaxRunspaceSize());                          
    System.out.println("New MaxRunspaceSize(): "
                               + OracleRuntime.getMaxRunspaceSize());
                               
    System.out.println("getJavaPoolSize(): "
                               + OracleRuntime.getJavaPoolSize());
    System.out.println("getSessionSoftLimit(): "
                               + OracleRuntime.getSessionSoftLimit());
    System.out.println("Old SessionGCThreshold(): "
                               + OracleRuntime.getSessionGCThreshold());
    OracleRuntime.setSessionGCThreshold(2 * OracleRuntime.getSessionGCThreshold());
    System.out.println("New SessionGCThreshold(): "
                               + OracleRuntime.getSessionGCThreshold());

    System.out.println("Old NewspaceSize: " + OracleRuntime.getNewspaceSize());
    OracleRuntime.setNewspaceSize(2 * OracleRuntime.getNewspaceSize());
    System.out.println("New NewspaceSize: " + OracleRuntime.getNewspaceSize());
    
    System.out.println("Old MaxMemsize: " + OracleRuntime.getMaxMemorySize());
    OracleRuntime.setMaxMemorySize(2 * OracleRuntime.getMaxMemorySize());
    System.out.println("New MaxMemsize: " + OracleRuntime.getMaxMemorySize());
    
    System.out.println("Old JavaStackSize(): "
                                + OracleRuntime.getJavaStackSize());
    OracleRuntime.setJavaStackSize(2 * OracleRuntime.getJavaStackSize());
    System.out.println("New JavaStackSize(): "
                                + OracleRuntime.getJavaStackSize());
    
    System.out.println("Old ThreadStackSize(): "
                                + OracleRuntime.getThreadStackSize());
    OracleRuntime.setThreadStackSize(2 * OracleRuntime.getThreadStackSize());
    System.out.println("New ThreadStackSize(): "
                                + OracleRuntime.getThreadStackSize());
  }
}
/
show errors;

create or replace procedure memtests
  as language java name 
  'memtest.Tests()';
/

show errors;

set serveroutput on
Call dbms_java.set_output(50000);
call memtests();

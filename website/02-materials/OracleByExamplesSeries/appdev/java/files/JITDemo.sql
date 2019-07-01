set echo on
set timing on
 
 create or replace java source named JITDemo as
 public class JITDemo {
   public static long factorial(long aNumber) {
     long i;
     long result = 1;
    
     if (aNumber <= 1)
       return aNumber / aNumber;
     else {
       for (i = 1; i < aNumber; i++) result *= (i + 1);
     }
     return result;
   }
   public static long runFactorial(long aNumber) {
     long time_0, time_1;
     time_0 = System.currentTimeMillis();
     for(int i = 0; i < 100000; i++) {
       factorial(aNumber);
     }
     time_1 = System.currentTimeMillis();
     return (time_1 - time_0);
   }
 }
 /
 
 create or replace function factorial(n NUMBER) return NUMBER as language java name
 'JITDemo.runFactorial(long) return long';
 /
 
 -- Force compile
 select dbms_java.compile_method('JITDemo', 'factorial', '(J)J') from dual;
 
 var time_compiled NUMBER;
 var time_interpreted NUMBER;
 
 exec :time_compiled := factorial(20);
 select :time_compiled as JIT_TIME_MS from dual;
 
 -- Run Interpreted
 alter session set java_jit_enabled=false;
 
 exec :time_interpreted := factorial(20);
 select :time_interpreted as INTERP_TIME_MS from dual;
 
 -- Run compiled
 alter session set java_jit_enabled=true;
 
 
 select :time_interpreted / :time_compiled as INTERP_TO_JIT_RATIO from dual;
 

/*
 *  Basic Object type (scalar data types)
 *
 */

create or replace and resolve java source named BasicObjTyp as 

import java.sql.*;
import java.io.*;
import oracle.sql.*;
import oracle.jdbc.*;

public class BasicObjTyp
{
  public static String fString (String s) { return s; }
  public static int fint (int n) { return n; }
  public static DATE fDATE (DATE d) { return d; }
  public static RAW fRAW (RAW r) { return r; }
}
/

set serveroutput on

create or replace type myobjtyp as object (
  num_attr number,
  chr_attr varchar2(20),
  dat_attr date,
  raw_attr raw(20),

  static function intfunc (x number) return number,
  static function strfunc (x varchar2) return varchar2,
  static function datfunc (x date) return date,
  static function rawfunc (x raw) return raw
);
/


create or replace type body myobjtyp as

  static function intfunc (x number) return number 
         as language java name 'BasicObjTyp.fint(int) 
         return int';

  static function strfunc (x varchar2) return varchar2 
         as language java 
         name 'BasicObjTyp.fString(java.lang.String) 
         return java.lang.String';

  static function datfunc (x date) return date 
         as language java 
         name 'BasicObjTyp.fDATE(oracle.sql.DATE) 
         return oracle.sql.DATE';

  static function rawfunc (x raw) return raw 
         as language java 
         name 'BasicObjTyp.fRAW(oracle.sql.RAW) 
         return oracle.sql.RAW';
end;
/


declare
n number;
c varchar2(20);
d date;
r raw(20);
obj myobjtyp;

begin
  n := 469;
  c := 'Basic Object Type';
  d := '12-JUN-2005';
  r := '0102030405';
  
  obj := myobjtyp(n, c, d, r);

  dbms_output.put_line('*** Print Object Attributs ***');
  dbms_output.put_line(obj.num_attr);
  dbms_output.put_line(obj.chr_attr);
  dbms_output.put_line(obj.dat_attr);
  dbms_output.put_line(obj.raw_attr);
  dbms_output.put_line('** Invoke Object Methods *** ');
  dbms_output.put_line(myobjtyp.intfunc(n));
  dbms_output.put_line(myobjtyp.strfunc(c));
  dbms_output.put_line(myobjtyp.rawfunc(r));
  dbms_output.put_line(myobjtyp.datfunc(d));
  dbms_output.put_line('***** ');
end;
/


drop table VarrayTab;
rem
rem VARRAY of Number type
rem
create or replace type NVARRAY as VARRAY(10) of number
/
rem
rem VARRAY of VARCHAR2 type
rem
create or replace type VC2VARRAY as VARRAY(10) of varchar2(30)
/
rem
rem VARRAY of date type
rem
create or replace type DATVARRAY as VARRAY(10) of date
/
rem
rem Table of VARRAYs
rem (number varray, varchar2 varray, date varray)
rem
create table VarrayTab (id int, nva nvarray,
    vc2va vc2varray,  datva datvarray);

insert into VarrayTab values (1,
    NVARRAY(1, 2, 3, 4, 5, 6, 7, 8, 9, 10),
    VC2VARRAY('One', 'Two', 'Three', 'Four', 'Five', 'Six', 
              'Seven','Eight', 'Nine', 'Ten'),
    DATVARRAY('01-JAN-2005', '02-JAN-2005', '03-JAN-2005', '04-JAN-2005',
              '05-JAN-2005', '06-JAN-2005', '07-JAN-2005', '08-JAN-2005',
              '09-JAN-2005', '10-JAN-2005')
    );

insert into VarrayTab values (2, null, null, null);

insert into VarrayTab values (3,
    NVARRAY(31, 32, 33, 34, 35, 36, 37, 38, 39, 40),
    VC2VARRAY('Thirty One', 'Thirty Two', 'Thirty Three',
              'Thirty Four', 'Thirty Five', 'Thirty Six',
              'Thirty Seven', 'Thirty Eight'),
    DATVARRAY('01-MAR-2005', '02-MAR-2005', '03-MAR-2005', '04-MAR-2005',
              '05-MAR-2005', '06-MAR-2005', '07-MAR-2005', '08-MAR-2005',
              '09-MAR-2005', '10-MAR-2005')
    );
commit;


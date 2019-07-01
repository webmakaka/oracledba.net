rem
rem connect sys as sysdba;
rem grant create any directory to hr;
rem

connect hr/hr
rem
rem Create an alias for an existing file system directory
rem
create or replace directory bfiledir as '/export/home/oracle1/java';
rem
rem copy and paste a random pdf file as Figure1.pdf, Figure2.pdf 
rem and Figure3.pdf, under C:\temp or equivalent directory (i.e., /tmp)
rem

drop table Xobtab;

create table XobTab (id number, blob_col blob, clob_col clob, bfile_col bfile);

insert into XobTab values (1, empty_blob(), empty_clob(),
    bfilename('BFILEDIR', 'Figure1.pdf'));

insert into XobTab values (2, hextoraw(lpad('b', 1500, 'b')),
    lpad('c', 3500, 'c'), bfilename('BFILEDIR', 'Figure2.pdf'));

insert into XobTab values (3, hextoraw(lpad('b', 2000, 'b')),
    lpad('c', 4000, 'c'), bfilename('BFILEDIR', 'Figure3.pdf'));

commit;

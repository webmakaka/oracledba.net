REM "******************************************* "
REM "For demo purposes ONLY:"
REM "  * Setup for Flashback Transaction"
REM "Execute script as SYSDBA" 

set echo on
set serveroutput on
set term on
set lines 200
set pause on

/*== Set up the HR database account for this OBE ==*/

ALTER DATABASE ADD SUPPLEMENTAL LOG DATA;
ALTER DATABASE ADD SUPPLEMENTAL LOG DATA (PRIMARY KEY) COLUMNS;
GRANT EXECUTE ON dbms_flashback TO hr;
GRANT select any transaction TO hr;
pause Press [Enter] to continue...

/*== Create test data for flashback transaction ==*/
connect hr/hr

/*== Test transaction 1 ==*/
INSERT INTO hr.regions VALUES (10,'Pole');
INSERT INTO hr.regions VALUES (20,'Moon');
INSERT INTO hr.regions VALUES (30,'Venus');
INSERT INTO hr.regions VALUES (40,'Mars');
INSERT INTO hr.regions VALUES (50,'Saturn');
COMMIT;
pause Press [Enter] to continue...

/*== Test transaction 2 ==*/
/*== Region 10 and 20 has a WAW dependency on transaction 1 ==*/
UPDATE hr.regions SET region_name='Two Poles'  WHERE region_id = 10;
UPDATE hr.regions SET region_name='Many Moons' WHERE region_id = 20;
COMMIT;
pause Press [Enter] to continue...

/*== Test transaction 3 ==*/
/*== Region 10 has a WAW dependency on transaction 1 and 2 ==*/
/*== Region 40 and 50 has a WAW dependency on transaction 1 ==*/
UPDATE hr.regions SET region_name='No star'  WHERE region_id = 10;
UPDATE hr.regions SET region_name='Red star' WHERE region_id = 40;
UPDATE hr.regions SET region_name='Big star' WHERE region_id = 50;
COMMIT;
pause Press [Enter] to continue...

/*== Test transaction 4 ==*/
/*== Region 30 has a WAW dependency on transaction 1 ==*/
UPDATE hr.regions SET region_name='Still called Venus' WHERE region_id = 30;
COMMIT;

pause Press [Enter] to continue...

connect / as sysdba
ALTER SYSTEM ARCHIVE LOG CURRENT;

prompt "Setup for Flashback Transaction completed"
pause Press [Enter] to continue...

exit

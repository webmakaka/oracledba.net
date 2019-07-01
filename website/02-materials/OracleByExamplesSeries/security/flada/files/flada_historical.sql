REM "******************************************* "
REM "For demo purposes ONLY:"

connect hr/Ora-4-you

set echo on
set serveroutput on
-- set verify on
set term on
set lines 200
set pages 44
set pause on

/*== Now you decide to execute a query with the values from 15 minutes ago ==*/

SELECT employee_id, last_name, salary
FROM   hr.employees
AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '15' MINUTE)
WHERE  last_name = 'Fox'
/
pause  Press [Enter] to continue...

/*== You realize that all the updates were mistakes ==*/
/*== Revert to the original values from 15 minutes ago ==*/

UPDATE hr.employees
SET    salary = 
       (SELECT  salary FROM hr.employees
       AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '15' MINUTE)
       WHERE  last_name = 'Fox')
WHERE  last_name = 'Fox'
/
COMMIT
/
pause  Press [Enter] to continue...

/*== Confirm that the original values are restored with this previous DML statement ==*/
SELECT employee_id, last_name, salary
FROM   hr.employees
WHERE  last_name = 'Fox'
/
pause  Press [Enter] to continue...

exit

REM "********************************************** "
REM "For demo purposes ONLY: Flashback Data Archive "

connect hr/HR

set echo on
set serveroutput on
-- set verify on
set term on
set lines 200
set pages 44
set pause on pause "Press [Enter] to continue..."

/*== Query the current salary for Mr. Fox ==*/

SELECT employee_id, last_name, salary
FROM   hr.employees
WHERE  last_name = 'Fox'
/

pause Press [Enter] to continue...

/*== Increase the  salary three times by 1000 ==*/

UPDATE hr.employees
SET salary = salary + 1000
WHERE last_name = 'Fox'
/
COMMIT
/
UPDATE hr.employees
SET salary = salary + 1000
WHERE last_name = 'Fox'
/
COMMIT
/
UPDATE hr.employees
SET    salary = salary + 1000
WHERE  last_name = 'Fox'
/
COMMIT
/
pause Press [Enter] to continue...

/*== Query the up-to-date value for Mr. Fox ==*/

SELECT employee_id, last_name, salary
FROM   hr.employees
WHERE  last_name = 'Fox'
/

pause  Press [Enter] to continue...

set pause off

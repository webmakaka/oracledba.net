create or replace synonym departments for hr.departments
/
create or replace synonym locations for hr.locations 
/
create or replace synonym countries for hr.countries 
/
create or replace synonym employees for hr.employees 
/
create or replace synonym jobs for hr.jobs 
/
create or replace view DEPARTMENT_XQL of xmltype
with object id
(extract(object_value, '/Department/@DepartmentId').getnumberVal())
as
select column_value from XMLTable
       ('for $d in ora:view("DEPARTMENTS"), 
		 $l in ora:view("LOCATIONS"),
		 $c in ora:view("COUNTRIES")
	   where $d/ROW/LOCATION_ID = $l/ROW/LOCATION_ID
		and $l/ROW/COUNTRY_ID = $c/ROW/COUNTRY_ID 
	   return
	   <Department DepartmentId= "{$d/ROW/DEPARTMENT_ID/text()}" >
		<Name>{$d/ROW/DEPARTMENT_NAME/text()}</Name>
		<Location>
		  <Address>{$l/ROW/STREET_ADDRESS/text()}</Address>
		  <City>{$l/ROW/CITY/text()}</City>
		  <State>{$l/ROW/STATE_PROVINCE/text()}</State>
		  <Zip>{$l/ROW/POSTAL_CODE/text()}</Zip>
		  <Country>{$c/ROW/COUNTRY_NAME/text()}</Country>
		</Location>
		<EmployeeList>
		{
		   for $e in ora:view("EMPLOYEES"),
		  	 $m in ora:view("EMPLOYEES"),
			 $j in ora:view("JOBS")
		   where $e/ROW/DEPARTMENT_ID = $d/ROW/DEPARTMENT_ID
		      and $j/ROW/JOB_ID = $e/ROW/JOB_ID
			and $m/ROW/EMPLOYEE_ID = $e/ROW/MANAGER_ID
		   return
		   <Employee employeeNumber="{$e/ROW/EMPLOYEE_ID/text()}" >
			<FirstName>{$e/ROW/FIRST_NAME/text()}</FirstName>
			<LastName>{$e/ROW/LAST_NAME/text()}</LastName>
			<EmailAddress>{$e/ROW/EMAIL/text()}</EmailAddress>
			<Telephone>{$e/ROW/PHONE_NUMBER/text()}</Telephone>
			<StartDate>{$e/ROW/HIRE_DATE/text()}</StartDate>
			<JobTitle>{$j/ROW/JOB_TITLE/text()}</JobTitle>
			<Salary>{$e/ROW/SALARY/text()}</Salary>
			<Manager>{$m/ROW/LAST_NAME/text(), ", ", $m/ROW/FIRST_NAME/text()}</Manager>
		    </Employee>
		 }
		 </EmployeeList>
	    </Department>')
/

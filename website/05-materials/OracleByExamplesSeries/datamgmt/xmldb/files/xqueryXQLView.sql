select t.column_value from department_xql x, xmltable('for $i in .
	 where $i/Department/EmployeeList/Employee/LastName="Grant"
	 return $i/Department/Name'
	 passing value(x)) t
/

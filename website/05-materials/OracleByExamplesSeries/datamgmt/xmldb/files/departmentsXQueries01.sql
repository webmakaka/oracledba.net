select any_path 
from resource_view r
where XMLExists('declare namespace r="http://xmlns.oracle.com/xdb/XDBResource.xsd"; (: :)
                 /r:Resource[starts-with(r:DisplayName,"Accounting")]' passing r.res)
/
select any_path 
from resource_view r
where under_path(res,'/home/OE/XQDepartments') = 1
and XMLExists('declare namespace r="http://xmlns.oracle.com/xdb/XDBResource.xsd"; (: :)
                 /r:Resource[ends-with(r:DisplayName,"xml")]' passing r.res)
/

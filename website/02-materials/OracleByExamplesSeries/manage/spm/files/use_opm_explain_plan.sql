explain plan for
select /*USE_OPM*/ *
from sh.sales
where quantity_sold > 40
order by prod_id;

select *
from table(dbms_xplan.display(null, null, 'basic'));
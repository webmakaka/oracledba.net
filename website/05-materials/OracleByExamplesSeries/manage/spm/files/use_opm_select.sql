select /*USE_OPM*/ *
from sh.sales
where quantity_sold > 40
order by prod_id;
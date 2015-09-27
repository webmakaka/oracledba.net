select  dbms_stats.create_extended_stats(null,'customers_obe',
         '(country_id, cust_state_province)')
from dual;
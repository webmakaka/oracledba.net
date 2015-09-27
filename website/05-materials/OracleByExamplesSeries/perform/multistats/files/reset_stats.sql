exec dbms_stats.drop_extended_stats(null,'customers_obe', -
      '(country_id, cust_state_province)');
exec dbms_stats.drop_extended_stats(null,'customers_obe', -
      '(lower(country_id))');
select column_name, num_distinct, histogram
from user_tab_col_statistics where table_name = 'CUSTOMERS_OBE';
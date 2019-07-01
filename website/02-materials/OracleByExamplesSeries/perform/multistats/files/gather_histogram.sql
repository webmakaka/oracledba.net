exec dbms_stats.gather_table_stats(null,'customers_obe', -
      method_opt => 'for all columns size skewonly');
select column_name, num_distinct, histogram
from user_tab_col_statistics where table_name = 'CUSTOMERS_OBE';
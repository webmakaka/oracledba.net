exec dbms_stats.gather_table_stats(null,'customers_obe', -
      method_opt => 'for all columns size skewonly');
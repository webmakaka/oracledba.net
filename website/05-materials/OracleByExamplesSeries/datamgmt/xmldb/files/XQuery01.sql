-- 1. How many purchase orders are there in total

select column_value from xmltable('count(for $i in ora:view("PURCHASEORDER") return $i)');
/
select column_value from xmltable('count(for $i in ora:view("PO_SL_BIX_TABLE") return $i)');
/


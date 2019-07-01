-- Create an XMLType table using binary XML storage
drop table po_sl_bix_table purge;

-- Create a table for schemaless binary XML storage
CREATE TABLE PO_SL_BIX_TABLE OF XMLType
     XMLType STORE AS BINARY XML;
/
insert into po_sl_bix_table 
 select object_value from purchaseorder;
/

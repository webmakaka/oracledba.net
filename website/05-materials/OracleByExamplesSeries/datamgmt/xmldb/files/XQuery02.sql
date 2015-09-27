--Xquery: How many purchase orders were made by a particular user

select count(object_value) 
from PURCHASEORDER
where XMLExists('/PurchaseOrder[User="SBELL"]' passing object_value)
/
select count(object_value) 
from PO_SL_BIX_TABLE
where XMLExists('/PurchaseOrder[User="SBELL"]' passing object_value)
/


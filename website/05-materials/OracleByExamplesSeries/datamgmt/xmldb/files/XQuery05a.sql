
-- 1. List the description for each item on the purchase order

SELECT XMLQuery('/PurchaseOrder/LineItems/LineItem/Description' passing object_value returning content) 
FROM PURCHASEORDER
WHERE XMLExists('/PurchaseOrder[Reference="SBELL-2002100912333601PDT"]' passing object_value)
/

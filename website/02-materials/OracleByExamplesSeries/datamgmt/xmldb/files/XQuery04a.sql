--List the purchase orders References having a particular part id

SELECT XMLQuery('/PurchaseOrder/Reference' passing object_value returning content) 
FROM PURCHASEORDER
WHERE XMLExists('/PurchaseOrder/LineItems/LineItem/Part[@Id="717951002372"]' passing object_value)
/

-- 1. list the references for item 20 with a description containing "Picnic" on a purchase order

SELECT XMLQuery('/PurchaseOrder/Reference' passing object_value returning content) 
FROM PURCHASEORDER
WHERE XMLExists('/PurchaseOrder/LineItems/LineItem[@ItemNumber=20]/Description/text()[ora:contains(.,"Picnic") > 0]' passing object_value)
/

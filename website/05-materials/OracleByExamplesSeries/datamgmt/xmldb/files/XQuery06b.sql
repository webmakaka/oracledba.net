--same query on binary storage table
SELECT XMLQuery('/PurchaseOrder/Reference' passing object_value returning content).getStringVal() 
FROM PO_SL_BIX_TABLE
WHERE XMLExists('/PurchaseOrder/LineItems/LineItem[@ItemNumber=20]/Description/text()[ora:contains(.,"Picnic") > 0]' passing object_value)
/

--Same query on binary storage table
SELECT XMLQuery('/PurchaseOrder/Reference' passing object_value returning content).getStringVal() 
FROM PO_SL_BIX_TABLE
WHERE XMLExists('/PurchaseOrder/LineItems/LineItem/Part[@Id="717951002372"]' passing object_value)
/


--Xquery: Review a specific purchase order

SELECT XMLQuery('/PurchaseOrder/ShippingInstructions/name' passing object_value returning content) 
FROM PURCHASEORDER 
WHERE XMLEXISTS('/PurchaseOrder[Reference="SBELL-2002100912333601PDT"]' passing object_value)
/

























column id format 99;
column PATIENT_NAME format A30;
column PATIENT_ID format A10;
select id, 
        extractValue(t.anonDicom.metadata, 
        '/DICOM_OBJECT/*[@name="Patient''s Name"]/VALUE', 
        'xmlns=http://xmlns.oracle.com/ord/dicom/metadata_1_0') as "PATIENT_NAME", 
        extractValue(t.anonDicom.metadata, 
        '/DICOM_OBJECT/*[@name="Patient ID"]', 
        'xmlns=http://xmlns.oracle.com/ord/dicom/metadata_1_0') as "PATIENT_ID" 
from medical_image_table t; 


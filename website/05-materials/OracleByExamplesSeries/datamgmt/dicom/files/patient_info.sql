column id format 99;
column PATIENT_NAME format A30;
column PATIENT_ID format A10;
column MODALITY format A10;
select id, 
        extractValue(t.dicom.metadata, 
        '/DICOM_OBJECT/*[@name="Patient''s Name"]/VALUE', 
        'xmlns=http://xmlns.oracle.com/ord/dicom/metadata_1_0') as "PATIENT_NAME", 
        extractValue(t.dicom.metadata, 
        '/DICOM_OBJECT/*[@name="Patient ID"]', 
        'xmlns=http://xmlns.oracle.com/ord/dicom/metadata_1_0') as "PATIENT_ID", 
        extractValue(t.dicom.metadata, 
        '/DICOM_OBJECT/*[@name="Modality"]', 
        'xmlns=http://xmlns.oracle.com/ord/dicom/metadata_1_0') as "MODALITY" 
from medical_image_table t;
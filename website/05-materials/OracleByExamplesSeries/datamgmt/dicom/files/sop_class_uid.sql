select id, 
       t.dicom.getSOPClassUID() as SOP_Class_UID
from medical_image_table t;
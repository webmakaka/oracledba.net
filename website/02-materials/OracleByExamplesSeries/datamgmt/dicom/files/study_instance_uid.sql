select id, 
       t.dicom.getStudyInstanceUID() as Study_Instance_UID 
from medical_image_table t;
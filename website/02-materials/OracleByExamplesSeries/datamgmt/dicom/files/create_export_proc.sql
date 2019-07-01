create or replace procedure dicom_export (source_id number, filename varchar2) as
  dcmSrc ordsys.orddicom;
begin
  select dicom into dcmSrc from medical_image_table where id = source_id;
  dcmSrc.export('FILE', 'IMAGEDIR', filename);
end;
/
show errors;




-- Set Data Model Repository
execute ordsys.ord_dicom.setDataModel();
create or replace procedure generate_thumb(source_id number, verb varchar2) is
    dcmSrc    ordsys.orddicom;
    imgDst    ordsys.ordimage;
begin
  select dicom, imageThumb into dcmSrc, imgDst from medical_image_table 
         where id = source_id for update;
  dcmSrc.processCopy(verb, imgDst);
  update medical_image_table set imageThumb = imgDst where id = source_id;
  commit;
end;
/
show errors;
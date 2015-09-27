-- Set Data Model Repository
execute ordsys.ord_dicom.setDataModel();
create or replace procedure generate_anon(source_id number) is
    dcmSrc    ordsys.orddicom;
    anonDst   ordsys.orddicom;
    dest_sop_inst_uid varchar2(128) := '1.2.3';
begin
  select dicom, anonDicom into dcmSrc, anonDst from medical_image_table 
         where id = source_id for update;
  dcmSrc.makeAnonymous(dest_sop_inst_uid, anonDst);
  update medical_image_table set anonDicom = anonDst where id = source_id;
  commit;
end;
/
show errors;

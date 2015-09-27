-- Set Data Model Repository
execute ordsys.ord_dicom.setDataModel();
  
create or replace procedure image_import(dest_id number, filename varchar2) is
  dcm ordsys.orddicom;
begin
   delete from medical_image_table where id = dest_id;
   insert into medical_image_table (id, dicom, imageThumb, anonDicom) 
   values (dest_id, ordsys.orddicom('file', 'IMAGEDIR', filename, 0), 
           ordsys.ordimage.init(), ordsys.orddicom()) 
   returning dicom into dcm;
   dcm.import(1);

   update medical_image_table set dicom=dcm where id=dest_id;
   commit;
end;
/
show errors;


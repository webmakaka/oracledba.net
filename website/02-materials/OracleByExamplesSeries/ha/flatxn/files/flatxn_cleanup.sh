
echo "******************************************* "
echo "For cleanup of demo:"
echo "  * Change HR password back to HR"
echo "  * Disable ARCHIVELOG mode"

# rm -Rf example01.*
# rm -Rf users01.*

sqlplus "/ as sysdba" << EOF

ALTER SYSTEM SET db_recovery_file_dest_size = 2147483648 SCOPE=BOTH;

shutdown immediate
startup mount
alter database noarchivelog;
alter database open;
archive log list

PROMPT "Cleanup finished."
exit
EOF



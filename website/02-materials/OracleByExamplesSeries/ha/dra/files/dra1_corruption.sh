echo "******************************************* "
echo "For demo purposes ONLY:"
echo "* Corrupt datafiles to produce failures"

cp $ORACLE_BASE/oradata/orcl/users01.dbf users01.dbf.old

rm -Rf $ORACLE_BASE/oradata/orcl/users01.dbf

mv $ORACLE_BASE/oradata/orcl/example01.dbf $ORACLE_BASE/oradata/orcl/example01.dbf.old 

exit

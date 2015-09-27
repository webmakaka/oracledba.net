ORACLE_INCLUDE=$(ORACLE_HOME)/rdbms/public
ORACLE_LIB=$(ORACLE_HOME)/lib
OCI_LIBS=-L$(ORACLE_LIB) -lclntsh

.c.o:
	gcc -c $(GCCFLAGS) -I. -I$(ORACLE_INCLUDE) $<

wcr_demo: test_common.o wcr_demo.o
	gcc -g -o wcr_demo test_common.o wcr_demo.o $(OCI_LIBS)

clean:
	@rm *.o wcr_demo

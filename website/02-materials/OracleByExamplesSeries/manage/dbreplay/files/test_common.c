/* Ref cursor test */

/*---------------------------------------------------------------------*/
#include <test_common.h>
#include <oci.h>
#include <ocidfn.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


/* --------------------------------------------------------------------- */
/* insert one row into table and select the lob descriptor.
*/
void alloc_stmt_handles (ocienv *ctx, stmtdef *sptr)
{
  sb2 i;

  /* Get statement handles */
  if (OCIHandleAlloc( (dvoid *)(ctx->envhp), (dvoid **) &(sptr->stmhp),
                   (ub4) OCI_HTYPE_STMT,
                   (size_t) 0, (dvoid **) 0) != OCI_SUCCESS )
  {
    COMMENT("Fail to OCIHandleAlloc for statement handle");
    cleanup(ctx);
    exit(EX_FAILURE);
  }
}

/*-------------------------------------------------------------------------*/
/* Authenticate users and connect to server
*/
static 
void authenticate_user_generic(ocienv *ctx, char* link, char *module, ub4 mode);

void authenticate_user(ocienv *ctx)
{
  authenticate_user_generic(ctx, "", 0, OCI_DEFAULT);
}

void authenticate_sysdba(ocienv *ctx)
{
  authenticate_user_generic(ctx, "", 0, OCI_SYSDBA);
}

void authenticate_user_with_link(ocienv *ctx, char *link)
{
   authenticate_user_generic(ctx, link, 0, OCI_DEFAULT);
}

void authenticate_user_with_link_module(ocienv *ctx, char *link, char *module)
{
  authenticate_user_generic(ctx, link, module, OCI_DEFAULT);
}

static
void authenticate_user_generic(ocienv *ctx, char* link, char *module, ub4 mode)
{
   //COMMENT ("Authentication for scott is progress...");
  char *user = mode == OCI_SYSDBA ? "sys" : "scott";
  char *password = mode == OCI_SYSDBA ? "knl_test7" : "tiger";  

   if (OCIServerAttach(ctx->srvhp, ctx->errhp, 
                       (CONST OraText *)link,
                       strlen(link), 
                       0) != OCI_SUCCESS )
     errrpt(ctx, "conn2serv - OCIServerAttach");

   /* Set the server handle in service handle */
   if (OCIAttrSet (ctx->svchp, OCI_HTYPE_SVCCTX, ctx->srvhp, 0,
                   OCI_ATTR_SERVER, ctx->errhp) != OCI_SUCCESS)
     errrpt(ctx, "conn2serv - OCIAttrSet");

   /* set module handle */
   if (module)
     if (OCIAttrSet(ctx->authp, OCI_HTYPE_SESSION, (void *)module,
                    strlen((const char *)module), 
                    OCI_ATTR_MODULE, ctx->errhp) != OCI_SUCCESS)
     {
       errrpt(ctx, "conn2serv - OCIAttrSet OCI_ATTR_MODULE");
     }

   /* set the username/password in user handle */
   if (OCIAttrSet(ctx->authp, OCI_HTYPE_SESSION, user, strlen(user),
                  OCI_ATTR_USERNAME, ctx->errhp) != OCI_SUCCESS)
      errrpt(ctx, "conn2serv - OCIAttrSet");

   if (OCIAttrSet(ctx->authp, OCI_HTYPE_SESSION, password, strlen(password),
                  OCI_ATTR_PASSWORD, ctx->errhp) != OCI_SUCCESS)
      errrpt(ctx, "conn2serv - OCIAttrSet");

   /* Authenticate */
   if (OCISessionBegin (ctx->svchp, ctx->errhp, ctx->authp,
                  OCI_CRED_RDBMS, mode) != OCI_SUCCESS)
      errrpt(ctx, "conn2serv - ocisauth");

   //COMMENT ("Authentication for scott successful.");

   /* Set the Authentication handle in the service handle */
   if (OCIAttrSet(ctx->svchp, OCI_HTYPE_SVCCTX, ctx->authp, 0,
                  OCI_ATTR_SESSION, ctx->errhp) != OCI_SUCCESS)
      errrpt(ctx, "conn2serv - OCIAttrSet");

}


void deauthenticate(ctx)
ocienv *ctx;
{
  //COMMENT ("Logging off...\n");
  if (OCISessionEnd(ctx->svchp, ctx->errhp, ctx->authp, (ub4) 0))
  {
    errrpt(ctx, (CONST text *)"logout: ologof");
  }
  //COMMENT("Logged off.\n");
}

/*---------------------------------------------------------------*/
/*
** Allocate and initialise global and local context structures.
*/

ocienv *alloc_handles()
{
  ocienv * csptr;
  int i;

  csptr = (ocienv *) malloc(sizeof(ocienv));
  if (csptr ==  (ocienv *)  0)
  {
    COMMENT("Unable To Allocate Memory for ocienv ...");
    exit(EX_FAILURE);
  }
  memset ((void *) csptr, '\0', sizeof(ocienv));

  if (OCIInitialize((ub4) OCI_THREADED | OCI_OBJECT, 
                    (dvoid *)0, (dvoid * (*)()) 0,
                    (dvoid * (*)())0, (void (*)()) 0 ) != OCI_SUCCESS)
  {
    COMMENT("Fail to OCIInitialize...");
    /* cleanup(csptr); */
    exit(EX_FAILURE);
  }

  if (OCIEnvInit( (OCIEnv **) &csptr->envhp, (ub4) OCI_DEFAULT,
                   (size_t) 0, (dvoid **) 0 ) != OCI_SUCCESS)
  {
    COMMENT("Fail to OCIEnvInit for service handle...");
    cleanup(csptr);
    exit(EX_FAILURE);
  }

  /* Get Error Handle */
  if (OCIHandleAlloc( (dvoid *) csptr->envhp, (dvoid **) &csptr->errhp,
                   (ub4) OCI_HTYPE_ERROR,
                   (size_t) 0, (dvoid **) 0) != OCI_SUCCESS)
  {
    COMMENT("Fail to OCIHandleAlloc for error handle...");
    cleanup(csptr);
    exit(EX_FAILURE);
  }

  /* server context */
  if (OCIHandleAlloc( (dvoid *) csptr->envhp, (dvoid **) &csptr->srvhp,
                   (ub4) OCI_HTYPE_SERVER,
                   (size_t) 0, (dvoid **) 0) != OCI_SUCCESS)
  {
    COMMENT("Fail to OCIHandleAlloc for server handle...");
    cleanup(csptr);
    exit(EX_FAILURE);
  }

  /* Service Context */
  if (OCIHandleAlloc( (dvoid *) csptr->envhp, (dvoid **) &csptr->svchp,
                   (ub4) OCI_HTYPE_SVCCTX,
                   (size_t) 0, (dvoid **) 0) != OCI_SUCCESS )
  {
    COMMENT("Fail to OCIHandleAlloc for service handle...");
    cleanup(csptr);
    exit(EX_FAILURE);
  }

  /* Auth Context */
  if (OCIHandleAlloc( (dvoid *) csptr->envhp, (dvoid **) &csptr->authp,
                   (ub4) OCI_HTYPE_SESSION,
                   (size_t) 0, (dvoid **) 0) != OCI_SUCCESS )
  {
    COMMENT("Fail to OCIHandleAlloc for user handle...");
    cleanup(csptr);
    exit(EX_FAILURE);
  }

  /* allocate statment handles */
  {
    ub4 i;

    for (i = 0; i < NUMSTMT; i ++)
    {
      OCIHandleAlloc(csptr->envhp, 
                     (void **)&(csptr->s[i].stmhp), 
                     OCI_HTYPE_STMT, 
                     0, (void **)0);
    }
  }

  return csptr;
}


/* -------------------------------------------------------------- */
/*  Clean up all structures used.
*/

void cleanup(ctx)
ocienv *ctx;
{
  (void) OCIHandleFree((dvoid *) ctx->srvhp, (ub4) OCI_HTYPE_SERVER);
  (void) OCIHandleFree((dvoid *) ctx->svchp, (ub4) OCI_HTYPE_SVCCTX);
  (void) OCIHandleFree((dvoid *) ctx->errhp, (ub4) OCI_HTYPE_ERROR);
  (void) OCIHandleFree((dvoid *) ctx->authp, (ub4) OCI_HTYPE_SESSION);

  {
    ub4 i;
    
    for (i = 0; i < NUMSTMT; i++)
    {
      OCIHandleFree(ctx->s[i].stmhp, OCI_HTYPE_STMT);
    }
  }
}

/* ------------------------------------------------------------------------- */

/*
** Format the output error message and obtain error string from Oracle
** given the error code
*/
void errrpt(ctx, op)
     ocienv *ctx;
     CONST text *op;
{
  text  msgbuf[LONGTEXTLENGTH];
  sb4   errcode = 0;

  fprintf(stdout,"ORACLE error during %s\n", op);
  OCIErrorGet ((dvoid *) ctx->errhp, (ub4) 1, (text *) NULL, &errcode,
                    msgbuf, (ub4) sizeof(msgbuf), (ub4) OCI_HTYPE_ERROR);
  fprintf(stdout,"ERROR CODE = %d\n", errcode);
  fprintf(stdout,"%s\n", msgbuf);
}

void send_name_value_pair(ocienv *ctx, oratext *name, oratext *value)
{
  sword status;
  
  status = OCIAppCtxSet(ctx->authp, (dvoid *)"CLIENTCONTEXT", (ub4) 13,
                        (dvoid*)name, strlen((const char *)name), 
                        (dvoid*)value, strlen((const char *)value),
                        ctx->errhp, OCI_DEFAULT);
}

/* end of file ref_c.c */


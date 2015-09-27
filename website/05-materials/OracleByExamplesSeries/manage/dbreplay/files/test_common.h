 

/*
  ref cursor test
*/


#ifndef test_common
# define test_common

#ifndef OCI_ORACLE
#include <oci.h>
#endif

/*---------------------------------------------------------------------------
                           TYPES AND CONSTANTS
  ---------------------------------------------------------------------------*/
#define LFCOUNT          2
#define STMTLEN          1000

#define LONGTEXTLENGTH   1024
#define BUFSIZE          1024

#define EX_FAILURE       1
#define EX_SUCCESS       0


#define NUMSTMT  50
#define NUMBINDS 50

typedef struct { /* statement bind/define handles */
  OCIStmt    *stmhp;
  OCIBind    *bndhp[NUMBINDS];
  OCIDefine  *dfnhp[NUMBINDS];
} stmtdef;

typedef struct {                                         /* GLOBAL STRUCTURE */
  OCIEnv     *envhp;                                   /* Environment handle */
  OCISvcCtx  *svchp;                                       /* Service handle */
  OCIServer  *srvhp;                                       /* Server handles */
  OCIError   *errhp;                                         /* Error handle */
  OCISession *authp;                                /* Authentication handle */
  stmtdef     s[NUMSTMT];        /* a bunch of statment handles to play with */
} ocienv;

/* define macros to be used in tests */
#define COMMENT(x) (void) fprintf(stdout,"\nCOMMENT: %s\n", x)

/*---------------------------------------------------------------------------
                               FUNCTIONS
  ---------------------------------------------------------------------------*/

ocienv *alloc_handles(void);
void alloc_stmt_handles (ocienv *ctx, stmtdef *sptr);
void cleanup(ocienv *ctx);
void errrpt(ocienv *ctx, const text *op);
void authenticate_user(ocienv *ctx);
void authenticate_sysdba(ocienv *ctx);
void authenticate_user_with_link(ocienv *ctx, char *link);
void authenticate_user_with_link_module(ocienv *ctx, char *link, char* module);
void deauthenticate(ocienv *ctx);
void send_name_value_pair(ocienv *ctx, oratext *name, oratext *value);

#endif                                              /* test_common */


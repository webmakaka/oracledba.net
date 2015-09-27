/* wcr demo app */

/*---------------------------------------------------------------------*/
#include <test_common.h>
#include <oci.h>
#include <ocidfn.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <getopt.h>                             /* for commandline arguments */
#include <sys/types.h>
#include <unistd.h>
#include <math.h>

/* globals */
oratext color[] = "red plus space for more colors";
double  thinktime  = 1.0;                     /* mean think time is 1 second */
ub4     numpixels  = 100;                              /* default 10x10 grid */
ub4     numupdates = 60;                             /* do 60 random updates */
ub4     updpercmt  = 1;                              /* 1 updates per commit */
ub4     initialdelay = 0;

/* prototypes */
static void parse_arguments(int argc, char **argv);
static void run_test(ocienv *ctx);

int main (int argc, char **argv)
{
  ocienv *ctx;
  sword retval = 0;

  /* parse command line */
  parse_arguments(argc, argv);

  /* allocate and initialise ctx structure */
  ctx = alloc_handles();

  /* Allocate statement/bind/define handles */
  alloc_stmt_handles (ctx, &ctx->s[0]);

  /* Authenticate the user (connect to server) */
  authenticate_user(ctx);

  /* perform updates */
  run_test(ctx);

  /* Deauthenticate (logout) user */
  deauthenticate(ctx);

  /* Clean up */
  cleanup(ctx);
  return(EX_SUCCESS);
}

static void parse_arguments(int argc, char **argv)
{
  int     c = -1;
  boolean no_more_options = FALSE;
  char    *endptr;

  /* parse the command line */
  while (1)
  {
    static struct option long_options[] =
      {
        /* color to set the pixel too */
        {"color",       required_argument, 0, 'c'},

        /* think time between updates */
        {"thinktime",   required_argument, 0, 't'},

        /* number of pixels in the grid */
        {"numpixels",   required_argument, 0, 'p'},

        /* number of updates to perform */
        {"numupdates",  required_argument, 0, 'u'},

        /* number of updates before commit */
        {"updpercmt", required_argument, 0, 'r'},

        /* initial delay in seconds */
        {"delay", required_argument, 0, 'd'},

        {0, 0, 0, 0}
      };
    
    int option_idx;

    c = getopt_long_only(argc, argv, "c:t:p:u:r:d:", long_options, &option_idx);

    if (c == -1)
      break;                                       /* just break out of this */

    switch (c)
    {
    case 0: 
      {
        /* why do I exist? */
      } 
      break;

    case 'c': 
      {
        strcpy((char *)color, optarg);                   /* copy color value */
        
      }
      break;

    case 't':
      {
        double  d;

        d = strtod(optarg, &endptr);
        thinktime = d?d:thinktime;
      }
      break;

    case 'p':
      {
        long int pix;

        pix = strtol(optarg, &endptr, 10);
        numpixels = (ub4)(pix?pix:numpixels);
      }
      break;

    case 'u':
      {
        long int upd;

        upd = strtol(optarg, &endptr, 10);
        numupdates = (ub4)(upd?upd:numupdates);
      }
      break;

    case 'r':
      {
        long int upc;

        upc = strtol(optarg, &endptr, 10);
        updpercmt = (ub4)(upc?upc:updpercmt);
      }
      break;

    case 'd':
      {        
        initialdelay = strtol(optarg, &endptr, 10);
      }
      break;
    }
  }

  if (argc == 1)
  {
    printf("USAGE: %s [-c/--color <color>][-t/--thinktime <time>]"
           "[-p/--numpixels <number of pixels]"
           "[-u/--numupdates <number of updates]\n", argv[0]);
    printf("Using defaults!\n");
  }

  printf("Color: %s, Thinktime: %f, Number of pixels:%d,"
         " Number of updates:%d Initial delay:%d updates per commit:%d\n", 
         color, thinktime, numpixels, numupdates, initialdelay, updpercmt);

}

static void run_test(ocienv *ctx)
{
  const oratext *stmt = "update wcr_grid set color = :c where pixid = :id";
  const oratext *selstmt = "select pixid from wcr_grid where color = :c";
  int            curid, i;

  /* prepare and bind */
  if (OCIStmtPrepare(ctx->s[0].stmhp, ctx->errhp, (text *)stmt,
                     strlen((char *)stmt), OCI_NTV_SYNTAX,
                     OCI_DEFAULT) != OCI_SUCCESS)
  {
    printf("Failed to prepare %s:\n", stmt);
    exit(1);
  }

  OCIBindByName(ctx->s[0].stmhp, (OCIBind **) &(ctx->s[0].bndhp[0]),
                ctx->errhp, (text *)":c", (sb4)strlen(":c"),
                (void *)color, strlen((const char *)color) + 1, SQLT_STR,
                (void *)0, 0, 0, 0, 0, OCI_DEFAULT);

  OCIBindByName(ctx->s[0].stmhp, (OCIBind **) &(ctx->s[0].bndhp[1]),
                ctx->errhp, (text *)":id", (sb4)strlen(":id"),
                (void *)&curid, sizeof(curid), SQLT_INT, 
                (void *)0, 0, 0, 0, 0, OCI_DEFAULT);

  /* seed the random number generator */
  srandom(getpid());

  if (initialdelay)
    usleep((unsigned long)(initialdelay * 1000000));

  for (i = 0; i < numupdates; i ++ )
  {
    double ttime;
    ub4 execmode = 
      i % updpercmt == 0 ? OCI_COMMIT_ON_SUCCESS : OCI_DEFAULT;

    /* update a random pixel */ 
    curid = (int) ((double)random() / (double)RAND_MAX * (double)numpixels);

    if (OCIStmtExecute(ctx->svchp, ctx->s[0].stmhp, ctx->errhp, 
                       1, 0, NULL, NULL, execmode) != OCI_SUCCESS)
    {
      errrpt(ctx, stmt);
    }

    /* after every commit perform a query to count your colors */
    if (00 && execmode == OCI_COMMIT_ON_SUCCESS)
    {
#define NUM_ROWS 10
      ub4 pixids[NUM_ROWS];                           /* room for 10 fetches */
      sword status;

      if (OCIStmtPrepare(ctx->s[1].stmhp, ctx->errhp, (text *)selstmt, 
                         strlen((char *)selstmt), OCI_NTV_SYNTAX, 
                         OCI_DEFAULT) != OCI_SUCCESS)
      {
        errrpt(ctx, selstmt);
      }

      OCIBindByName(ctx->s[1].stmhp, (OCIBind **) &(ctx->s[1].bndhp[0]),
                    ctx->errhp, (text *)":c", (sb4)strlen(":c"), 
                    (void *)color, strlen((const char *)color) + 1, SQLT_STR,
                    (void *)0, 0, 0, 0, 0, OCI_DEFAULT);

      OCIDefineByPos(ctx->s[1].stmhp, &(ctx->s[0].dfnhp[0]), ctx->errhp, 
                     1,
                     (void *)pixids, sizeof(ub4), 
                     SQLT_INT, 0, 0, 0, OCI_DEFAULT);
      
      if (OCIStmtExecute(ctx->svchp, ctx->s[1].stmhp, ctx->errhp, 
                       0, 0, NULL, NULL, OCI_DEFAULT) != OCI_SUCCESS)
      {
        errrpt(ctx, stmt);
      }

      while ((status = OCIStmtFetch(ctx->s[1].stmhp, ctx->errhp, NUM_ROWS, 
                                    OCI_FETCH_NEXT, OCI_DEFAULT)) == OCI_SUCCESS
             || status == OCI_SUCCESS_WITH_INFO)               /* just fetch */
      {
        /*  printf("FETCH OK\n");fflush(stdout); */
      }
      
    }

    /* think about something */
    /* printf(".");fflush(stdout); */
    ttime = -log((double)random() / (double)RAND_MAX) * thinktime;
    usleep((unsigned long)(ttime * 1000000));
  }
}

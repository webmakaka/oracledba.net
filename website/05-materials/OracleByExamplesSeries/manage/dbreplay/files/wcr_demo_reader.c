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

oratext svr_link[] = "\0aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
ub4     numpixels   = 100;                             /* default 10x10 grid */

/* prototypes */
static void parse_arguments(int argc, char **argv);
static void run_monitor(ocienv *);

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
  authenticate_user_with_link_module(ctx, (char *)svr_link, "test_common");

  /* read from db and create the file with the grid */
  run_monitor(ctx); 

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
        /* think time between updates */
        {"svr_link",   required_argument, 0, 'l'},

        /* number of pixels in the grid */
        {"numpixels",   required_argument, 0, 'p'},

        {0, 0, 0, 0}
      };
    
    int option_idx;

    c = getopt_long_only(argc, argv, "l:p:", long_options, &option_idx);

    if (c == -1)
      break;                                       /* just break out of this */

    switch (c)
    {
    case 0: 
      {
        /* why do I exist? */
      } 
      break;

    case 'l':
      {
        strncpy((char *)svr_link, optarg, sizeof(svr_link) -1);
      }
      break;

    case 'p':
      {
        long int pix;

        pix = strtol(optarg, &endptr, 10);
        numpixels = (ub4)(pix?pix:numpixels);
      }
      break;

    }
  }
} 

/*---------------------------------------------------------------------------*/
static void run_monitor(ocienv *ctx)
{
  #define MAX_COLOR_NAME_LENGTH 100
  ub4 i, j;                                                       /* loopers */
  ub4 one_side = (ub4)(sqrt((double)numpixels));     /* assume correct input */
  const oratext *stmt = "select pixid, color from wcr_grid order by 1";
  ub4 pixid, col_ctr = 0;
  oratext color[MAX_COLOR_NAME_LENGTH];
  sword status;

  if (OCIStmtPrepare(ctx->s[0].stmhp, ctx->errhp, (text *)stmt,
                     strlen((char *)stmt), OCI_NTV_SYNTAX,
                     OCI_DEFAULT) != OCI_SUCCESS)
  {
    printf("Failed to prepare %s:\n", stmt);
    exit(1);
  }
  
  /* define stuff */
  OCIDefineByPos(ctx->s[0].stmhp, &(ctx->s[0].dfnhp[0]), ctx->errhp, 
                 1,
                 (void *)&pixid, sizeof(pixid),
                 SQLT_INT, 0, 0, 0, OCI_DEFAULT);

  OCIDefineByPos(ctx->s[0].stmhp, &(ctx->s[0].dfnhp[2]), ctx->errhp, 
                 2,
                 (void *)color , MAX_COLOR_NAME_LENGTH,
                 SQLT_STR, 0, 0, 0, OCI_DEFAULT);

  /* execute the statment */
  if (OCIStmtExecute(ctx->svchp, ctx->s[0].stmhp, ctx->errhp, 
                     0, 0, NULL, NULL, OCI_DEFAULT) != OCI_SUCCESS)
  {
    errrpt(ctx, stmt);
    /* print something to allow refresh */
    printf("Content-Type: text/html\n\n"
           "<html><head>"
           "<meta HTTP-EQUIV=\"REFRESH\" CONTENT=\"1\">"
           "<title> Test table page </title></head><body></body>");
    exit(0);        
  }
    
  /* write header */ 
  printf("Content-Type: text/html\n\n"
         "<html><head>\n"
         "<meta HTTP-EQUIV=\"REFRESH\" CONTENT=\"1\">\n"
         "<title> Test table page </title></head><body>");
  printf("<table height=\"100\%\" width=\"100\%\" border=\"1\">\n<tr>");
  
  /* fetch all rows and populate the grid */
  while ((status = OCIStmtFetch(ctx->s[0].stmhp, ctx->errhp, 1, 
                                OCI_FETCH_NEXT, OCI_DEFAULT)) == OCI_SUCCESS
         || status == OCI_SUCCESS_WITH_INFO)
  {
    printf("<td bgcolor=\"%s\"></td>\n", color);
    if (++col_ctr == one_side)
    {
      if (pixid != numpixels - 1)
      {
        printf("</tr>\n<tr>\n");
      }
      else
      {
        printf("</tr></table></body></html>");
      }
      col_ctr = 0;
    } 
  }     
}


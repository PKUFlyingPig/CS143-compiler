%{
#include <cool-parse.h>
#include <stringtab.h>
#include <utilities.h>

/* The compiler assumes these identifiers. */
#define yylval cool_yylval
#define yylex  cool_yylex

/* Max size of string constants */
#define MAX_STR_CONST 1025
#define YY_NO_UNPUT   /* keep g++ happy */

extern FILE *fin; /* we read from this file */

/* define YY_INPUT so we read from the FILE fin:
 * This change makes it possible to use this scanner in
 * the Cool compiler.
 */
#undef YY_INPUT
#define YY_INPUT(buf,result,max_size) \
	if ( (result = fread( (char*)buf, sizeof(char), max_size, fin)) < 0) \
		YY_FATAL_ERROR( "read() in flex scanner failed");

char string_buf[MAX_STR_CONST]; /* to assemble string constants */
char *string_buf_ptr;

extern int curr_lineno;
extern int verbose_flag;

extern YYSTYPE cool_yylval;

/*
 *  Add Your own definitions here
 */
int entry_index = 0;
int nested_comments = 0;
bool string_overflow();
%}
DARROW     =>
LESSEQUAL  <=
LEFTARROW  <- 
INTEGER    [0-9]+
a [aA]
b [bB]
c [cC]
d [dD]
e [eE]
f [fF]
h [hH]
i [iI]
j [jJ]
k [kK]
l [lL]
m [mM]
n [nN]
o [oO]
p [pP]
q [qQ]
r [rR]
s [sS]
t [tT]
u [uU]
v [vV]
w [wW]
x [xX]
y [yY]
z [zZ]

%X COMMENTS STRING
%%

 /*
  *  Comments
  */
--[^\n]*            ;
"(*"                { nested_comments += 1; BEGIN COMMENTS; }
<COMMENTS>"(*"      { nested_comments += 1; }
<COMMENTS>"*)"      { 
                      nested_comments -= 1; 
                      if (nested_comments == 0) BEGIN 0;
                    }
<COMMENTS>[\n]      { curr_lineno += 1; }
<COMMENTS>.         ;
<COMMENTS><<EOF>>   {
                      cool_yylval.error_msg = "EOF in comment";
                      BEGIN 0;
                      return (ERROR);
                    }
"*)"                {
                      cool_yylval.error_msg = "Unmatched *)";
                      return (ERROR);
                    }



 /*
  *  The multiple-character operators.
  */
{DARROW}		        { return (DARROW); }
{LEFTARROW}         { return (ASSIGN); }
{LESSEQUAL}         { return (LE); }


 /*
  * Keywords are case-insensitive except for the values true and false,
  * which must begin with a lower-case letter.
  */
{c}{l}{a}{s}{s}     { return (CLASS); }
{e}{l}{s}{e}        { return (ELSE); }
{f}{i}              { return (FI); }
{i}{f}              { return (IF); }
{i}{n}              { return (IN); }
{i}{n}{h}{e}{r}{i}{t}{s} { return (INHERITS); }
{i}{s}{v}{o}{i}{d}  { return (ISVOID); }
{l}{e}{t}           { return (LET); }
{l}{o}{o}{p}        { return (LOOP); }
{p}{o}{o}{l}        { return (POOL); }
{t}{h}{e}{n}        { return (THEN); }
{w}{h}{i}{l}{e}     { return (WHILE); } 
{c}{a}{s}{e}        { return (CASE); } 
{e}{s}{a}{c}        { return (ESAC); }
{n}{e}{w}           { return (NEW); }
{o}{f}              { return (OF); }
{n}{o}{t}           { return (NOT); }
t{r}{u}{e}          { cool_yylval.boolean = true; return (BOOL_CONST); }
f{a}{l}{s}{e}       { cool_yylval.boolean = false; return (BOOL_CONST); }


 /* Integer constants */
{INTEGER}           { 
                      cool_yylval.symbol = inttable.add_string(yytext);
                      return (INT_CONST); 
                    }
                    
 /*
  *  String constants (C syntax)
  *  Escape sequence \c is accepted for all characters c. Except for 
  *  \n \t \b \f, the result is c.
  *
  */
\"                  { string_buf_ptr = string_buf; BEGIN STRING; }
<STRING>\"          { 
                      *string_buf_ptr = '\0'; 
                      cool_yylval.symbol = stringtable.add_string(string_buf);
                      BEGIN 0; 
                      return (STR_CONST);
                    }
<STRING>\\.         { if (string_overflow()) {
                        cool_yylval.error_msg = "String constant too long";
                        BEGIN 0;
                        return (ERROR);
                      }
                      switch(yytext[1]) {
                        case 'b': *string_buf_ptr = '\b'; break;
                        case 't': *string_buf_ptr = '\t'; break;
                        case 'n': *string_buf_ptr = '\n'; break;
                        case 'f': *string_buf_ptr = '\f'; break;
                        default: *string_buf_ptr = yytext[1];
                      }
                      string_buf_ptr++;
                    }
<STRING>\\\n        { 
                      if (string_overflow()) {
                        cool_yylval.error_msg = "String constant too long";
                        BEGIN 0;
                        return (ERROR);
                      }
                      *string_buf_ptr = '\n'; string_buf_ptr++;
                    }
<STRING>\n          { 
                      if (string_overflow()) {
                        cool_yylval.error_msg = "String constant too long";
                        BEGIN 0;
                        return (ERROR);
                      }
                      cool_yylval.error_msg = "Unterminated string constant";
                      BEGIN 0;
                      curr_lineno++;
                      return (ERROR);
                    }
<STRING>.           { 
                      if (string_overflow()) {
                        cool_yylval.error_msg = "String constant too long";
                        BEGIN 0;
                        return (ERROR);
                      }
                      *string_buf_ptr = yytext[0]; string_buf_ptr++;
                    }
<STRING><<EOF>>     {
                      cool_yylval.error_msg = "EOF in string constant";
                      BEGIN 0;
                      return (ERROR);
                    }


  /*
   * White space characters
   */
[ \n\f\r\t\v]       { if (yytext[0] == '\n') curr_lineno += 1; }

 /*
  *  Single character tokens
  */
[-(){}<=;,+*/~:@\.]   { return yytext[0]; }

 /*
  *  Type Identifier
  */
[A-Z][a-zA-Z0-9_]*  {
                      cool_yylval.symbol = idtable.add_string(yytext);
                      return (TYPEID);
                    }

 /*
  *  Object Identifier
  */
[a-z][a-zA-Z0-9_]*  {
                      cool_yylval.symbol = idtable.add_string(yytext);
                      return (OBJECTID);
                    }

  /*
   *  Illegal character
   */
.                   {
                      cool_yylval.error_msg = strdup(yytext);
                      return (ERROR);
                    }
%%

bool string_overflow() {
  return string_buf_ptr - string_buf + 1 >= MAX_STR_CONST;
}
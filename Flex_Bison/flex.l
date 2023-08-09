%{
#define YYSTYPE int
#include "bison.tab.h"
#include <stdlib.h>
%}
  
%%
"while"|"else"|"if"|"int"|"return"|"cout"|"cin"|"for" {return ERROR;}
"(" {return LEFTPARENTHESIS;}
")" {return RIGHTPARENTHESIS;}
"+" {return PLUS;}
"-" {return MINUS;}
"*" {return TIMES;}
"/" {return DIVIDE;}
"{"|"}" {return ERROR;}
[a-zA-Z][a-zA-Z0-9]* {return ERROR;}
">>"|"<<"|"<="|">="|"=="|"<"|">"|"=" {return ERROR;}
[0]+[0-7]*[8-9]+[0-9]* {return ERROR;}
[0]+[0-7]+ {return ERROR;}
[0-9]+ { yylval=atoi(yytext); return INTEGER;}
[0-9]+["."][0-9]* {return ERROR;}
["][^"]*["] {return ERROR;}
; {return ERROR;}
"!" {return ERROR;}
"?" {return ERROR;}
"_" {return ERROR;}
"\\" {return ERROR;}
"^" {return ERROR;}
[\t\r]
[\n] {return END;}
[/][/][^"\n"]* {return ERROR;}
" "
%%

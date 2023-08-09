%{
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#define YYSTYPE int
int yylex();
int yyerror();
%}

%token INTEGER
%token PLUS MINUS TIMES DIVIDE
%token LEFTPARENTHESIS RIGHTPARENTHESIS
%token LEFT RIGHT
%token END
%token ERROR

%left PLUS MINUS
%left TIMES DIVIDE
%left LEFTPARENTHESIS RIGHTPARENTHESIS
%left NEG

%start Input
%%

Input:
     | Input Line
;

Line:
     END
     | Expression END { printf("Result = %d\n\nEnter the Expression \n", $1); }
;

Expression:
     Term { $$=$1; }
| Expression PLUS Term { $$=$1+$3; }
| Expression MINUS Term { $$=$1-$3; }
| MINUS Expression %prec NEG { $$=-$2; }
;

Term:
     Fact { $$=$1; }
| Term TIMES Fact { $$=$1*$3; }
| Term DIVIDE Fact { $$=$1/$3; }
;

Fact:
     INTEGER { $$=$1; }
| LEFTPARENTHESIS Expression RIGHTPARENTHESIS { $$=($2); }
| LEFT Expression RIGHT { $$=$2; }
;
%%

int yyerror(char *s) {
  printf("Entered expression is invalid! \n\n");
}

int main() {
  printf("Enter the expression \n");
  yyparse();
}

/* File: times.lex */
/* Simple lexer for integer multiplication */
%{
#include "times.tab.h"
%}

%%
[ \t]+ ;
[0-9]+ { yylval.integer = atoi(yytext); return INTCONST; }
"*" { return ASTERISK; }
"+" { return ADD; }
%%

int yywrap(void) { return 1; } 
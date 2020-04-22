/* File: times.lex */
/* Simple lexer for integer multiplication */
%{
#include "times.tab.h"
%}

%%
[ \t]+ ;
[0-9]+ { yylval.integer = atoi(yytext); return INTCONST; }
"*" { return ASTERISK; }
"+" { return PLUS; }
"-" { return SUB; }
"/" { return DIVIDE; }
"%" { return MOD; }
"^" { return POWER; }
"(" { return OPEN_BRACKET; }
")" { return CLOSE_BRACKET; }
%%

int yywrap(void) { return 1; } 
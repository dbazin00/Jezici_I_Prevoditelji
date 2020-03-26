/* File Zad1.lex */
%%
[0-9]+\.[0-9]+ {printf("%s je decimalni broj\n", yytext);}
%%
int yywrap(void) { return 1; }
int main ()
{
yylex();
return 0;
}
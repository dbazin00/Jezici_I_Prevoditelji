wordToUpperCase [" "]object[" "]|[" "]programming[" "]|[" "]languages[" "]|[" "]class[" "]|[" "]is[" "]
dot \.
emptyBrackets [(][a-z \n A-Z]*[)]
%{
	int i=0;
	int brojRecenica = 0;
%}

%%
{wordToUpperCase} {for(i=0; i<yyleng; i++) printf("%c", toupper(yytext[i]));}
{dot} {brojRecenica++;}
{emptyBrackets} {for(i=0; i<yyleng; i++) printf("( )");}
%%
int yywrap(void) { return 1; }
int main(int argc, char *argv[])
{
	yyin = fopen(argv[1], "r");
	if(yyin == NULL) exit(1);
	yylex();
	printf("\n\nBroj recenica:\t%d\n\n", brojRecenica);
	fclose(yyin);
	return 0;
}
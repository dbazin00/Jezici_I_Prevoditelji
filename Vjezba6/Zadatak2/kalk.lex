/* file: kalk.lex */
%{
#include "kalk.h"
#include "kalk.tab.h"

static struct pFunStrut {
	char *name;
	pmatFunT pmatFun;
}
pFunArr[] =
{ {"sin", sin}, {"cos", cos}, {"asin", asin}, {"acos", acos},
 {"tan", tan}, {"atan", atan}, {"sinh", sinh}, {"cosh", cosh},
 {"exp", exp}, {"abs", fabs}, {"log", log}, {"log10", log10},
 {"sqrt", sqrt}, {"ceil", ceil}, {"floor", floor},
 {NULL, NULL}
};
pmatFunT getFunPtr(char *name) {
	int i = 0;
	while(pFunArr[i].name != NULL) {
		if(strcmp(pFunArr[i].name, name) == 0)
			return pFunArr[i].pmatFun;
		i++;
	}
	return NULL;
}
int lineno;
%}
EXP [eE][-+]?[0-9]+
DOT \.
DIG [0-9]
%%
(({DIG}+{DOT}?)|({DIG}*{DOT}{DIG}+)){EXP}? { yylval.fValue = atof(yytext);
return NUMBER; }

pi { yylval.fValue = 3.14159265358979323846;
	return NUMBER; }
while return WHILE;
if return IF;
else return ELSE;
end return END;
print return PRINT;
[a-zA-Z_][a-zA-Z0-9_]* { pmatFunT pF = getFunPtr(yytext);
	if(pF) {
		yylval.pmatFun = pF;
		return MATFUN; }
	else {
		yylval.str = xstrdup(yytext);
		return VARIABLE;
	}
}
[\+\*\(\)\{\}\^\.\?;:\-<>=/] return yytext[0];

">=" return GE;
"<=" return LE;
"==" return EQ;
"!=" return NE;
\/\/.* ; /*comment //*/
[ \r\t]+ ; /* ignore whitespace */
\n { lineno++ ; return NL; }
. yyerror("Unknown character");
%%

int yywrap(void) { return 1; }
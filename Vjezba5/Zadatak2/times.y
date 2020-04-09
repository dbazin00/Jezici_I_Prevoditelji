%{
#include <stdio.h>
#include <stdlib.h>

typedef struct node_str {
	int elem;
	struct node_str* next;
}* Node;

Node list = NULL;
Node list2 = NULL;

int evaluate(Node l);
int addFun(Node l);
%}
%union {
	int integer;
	struct node_str* node_ptr;
}

%token ASTERISK
%token ADD
%token <integer> INTCONST
%type <node_ptr> e
%left ASTERISK
%left ADD
%%
e : e ASTERISK e
{
	$3->next = list;
	list = $3;
}

	| e ADD e
{
	list2 = $1;
	list2->next = NULL;

	list = $3;
	list->next = NULL;
}
	| INTCONST
{
	$$ = (Node)malloc(sizeof(struct node_str));
	$$->elem = $1;
	$$->next = NULL;
}
;
%%

yyerror(const char *s) {
	fprintf( stderr, "%s\n", s );
}

void main() {
	yyparse();

	printf("%d\n", evaluate(list) + addFun(list2));
}

int evaluate(Node l) {
	if( l == NULL )
		return 1;
	else
		return l->elem * evaluate(l->next);
} 

int addFun(Node l) {
	if( l == NULL )
		return 0;
	else
		return l->elem + addFun(l->next);
} 
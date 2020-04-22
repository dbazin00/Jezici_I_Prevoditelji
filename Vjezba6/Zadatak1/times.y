%{
#include <stdio.h>
#include <stdlib.h>

typedef struct node_str {
	int elem;
	struct node_str* left;
	struct node_str* right;
}* Node;
Node ast = NULL;

int evaluate(Node l);
int powFun(int b, int p);
%}
%union {
	int integer;
	struct node_str* node_ptr;
}

%token PLUS
%token ASTERISK
%token SUB
%token MOD
%token DIVIDE
%token POWER
%token OPEN_BRACKET
%token CLOSE_BRACKET
%token <integer> INTCONST
%type <node_ptr> e
%left PLUS
%left ASTERISK
%left SUB
%left MOD
%left DIVIDE
%left POWER
%left OPEN_BRACKET
%left CLOSE_BRACKET
%%
e : e PLUS e
{
	$$ = (Node)malloc(sizeof(struct node_str));
	$$->elem = '+';
	$$->left = $1;
	$$->right = $3;
	ast = $$;
}
| e ASTERISK e
{
	$$ = (Node)malloc(sizeof(struct node_str));
	$$->elem = '*';
	$$->left = $1;
	$$->right = $3;
	ast = $$;
}
| e SUB e
{
	$$ = (Node)malloc(sizeof(struct node_str));
	$$->elem = '-';
	$$->left = $1;
	$$->right = $3;
	ast = $$;
}
| e DIVIDE e
{
	$$ = (Node)malloc(sizeof(struct node_str));
	$$->elem = '/';
	$$->left = $1;
	$$->right = $3;
	ast = $$;
}
| e MOD e
{
	$$ = (Node)malloc(sizeof(struct node_str));
	$$->elem = '%';
	$$->left = $1;
	$$->right = $3;
	ast = $$;
}
| e POWER e
{
	$$ = (Node)malloc(sizeof(struct node_str));
	$$->elem = '^';
	$$->left = $1;
	$$->right = $3;
	ast = $$;
}
| OPEN_BRACKET e CLOSE_BRACKET
{
	$$ = $2;
}
| INTCONST
{
	$$ = (Node)malloc(sizeof(struct node_str));
	$$->elem = $1;
	$$->left = NULL;
	$$->right = NULL;
	ast = $$;
}
;
%%

yyerror(const char *s) {
	fprintf( stderr, "%s\n", s );
}

void main() {
	yyparse();

	printf("%d\n", evaluate(ast));
}

int evaluate(Node l) {
	if( l == NULL )
		return 0;
	if( l->left == NULL && l->right == NULL )
		return l->elem;
	if( l->elem == '+' )
		return evaluate(l->left) + evaluate(l->right);
	if( l->elem == '*' )
		return evaluate(l->left) * evaluate(l->right);
	if( l->elem == '-' )
		return evaluate(l->left) - evaluate(l->right);
	if( l->elem == '/' )
		return evaluate(l->left) / evaluate(l->right);
	if( l->elem == '%' )
		return evaluate(l->left) % evaluate(l->right);
	if( l->elem == '^' )
		return powFun(evaluate(l->left), evaluate(l->right));
}

int powFun(int b, int p)
{
	int rez = 1;
	int i = 0;
	for(i = 0; i < p; i++)
		rez *= b;
	return rez;
}
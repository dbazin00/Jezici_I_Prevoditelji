/* file: kalk.c */

#include <math.h>
#include "kalk.h"
#include "kalk.tab.h"

NodeT* Opr3(int oper, NodeT* n1, NodeT* n2, NodeT* n3)
{
	NodeT* n = xmalloc(sizeof(NodeT));
	n->kind = kindOpr;
	n->oper = oper;
	n->left = n1;
	n->right = n2;
	n->next = n3;
	return n;
}

NodeT* Opr2(int oper, NodeT* n1, NodeT* n2) {
	return Opr3(oper, n1, n2, NULL);
}

NodeT* Opr1(int oper, NodeT* n1) {
	return Opr3(oper, n1, NULL, NULL);
}

NodeT* NumConst(double value)
{
	NodeT* n = xmalloc(sizeof(NodeT));
	n->kind = kindNum;
	n->value = value;
	return n;
}

NodeT* Var(Symbol* sp)
{
	NodeT* n = xmalloc(sizeof(NodeT));
	n->kind = kindVar;
	n->sp = sp;
	return n;
}

NodeT* MatFun(pmatFunT pmatFun, NodeT* expr)
{
	NodeT* n = Opr3(0, expr, NULL, NULL);
	n->kind = kindMatFun;
	n->pmatFun = pmatFun;
	return n;
}

NodeT* AppendStmt(NodeT* list, NodeT* stmt)
{
	NodeT* n = Opr1(STMT_LIST, stmt);
	if(!list)
		list = n;
	else {
		NodeT* p = list;
		while(p->next != NULL) p = p->next;
		p->next= n;
	}
	return list;
}

void freeNode(NodeT* n) {
	if (!n) return;
	if (n->kind == kindOpr) {
		freeNode(n->left);
		freeNode(n->right);
		freeNode(n->next);
	}
	free (n);
}

double Execute(NodeT* n)
{
	if (!n) return 0;
	if(n->kind == kindNum) return n->value;
	else if(n->kind == kindMatFun) return (*n->pmatFun)(Execute(n->left));
	else if(n->kind == kindVar) {
		if(!n->sp){
			yyerror("Variable not defined\n");
			return 0;
		}
		return n->sp->val;
	}
	else if(n->kind == kindOpr) switch(n->oper)
	{
		case WHILE: while(Execute(n->left)) Execute(n->right);
			return 0;

		case IF: if (Execute(n->left)) Execute(n->right);
			else if (n->next) Execute(n->next);
				return 0;

		case '?': if (Execute(n->left)) return Execute(n->right);
			else return Execute(n->next);

		case PRINT: printf("> %g\n", Execute(n->left) ); return 0;

		case STMT_LIST: do {Execute(n->left); n=n->next; }while(n); return 0;

		case '=': return n->left->sp->val = Execute(n->right);

		case UMINUS: return -Execute(n->left);

		case '+': return Execute(n->left) + Execute(n->right);
		case '-': return Execute(n->left) - Execute(n->right);
		case '*': return Execute(n->left) * Execute(n->right);
		case '/': { double op2 = Execute(n->right);
			if(op2 == 0){ yyerror("Zero devide\n"); op2=1;}
				return Execute(n->left) / op2;
			}
		case '^': { double op2 = Execute(n->right);
			return pow(Execute(n->left), op2);
			}
		case '<': return Execute(n->left) < Execute(n->right);
		case '>': return Execute(n->left) > Execute(n->right);
		case GE: return Execute(n->left) >= Execute(n->right);
		case LE: return Execute(n->left) <= Execute(n->right);
		case NE: return Execute(n->left) != Execute(n->right);
		case EQ: return Execute(n->left) == Execute(n->right);
		default:
			yyerror("Bad operator\n");
			return 0;
		}
		return 0; /*never reached*/
}

jmp_buf jumpdata;

int main(int argc, char* argv[]) {

	if(argc == 2) {
		yyin = fopen(argv[1], "rt");
		if (yyin == NULL) {
			printf ("Ne moze otvoriti datoteku: %s", argv[1]);
			exit(1);
		}
	}
	else
		yyin = stdin;

	setjmp(jumpdata);
	yyparse();
	return 0;
}

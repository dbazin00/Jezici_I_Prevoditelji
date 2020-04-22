/* file: kalk.h */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <setjmp.h>

typedef struct _sym {
	char* name;
	double val;
	struct _sym* next;
} Symbol;

typedef enum { kindNum, kindVar,kindMatFun, kindOpr } nodeKindT;

typedef double (*pmatFunT)(double);

typedef struct nodeTag NodeT;

struct nodeTag {
	nodeKindT kind; /* type of node */
	int oper;
	union {
		double value; /*num value*/
		Symbol* sp; /*variable */
		pmatFunT pmatFun; /*pointer to math functions*/
		NodeT* next; /* for: if then else, and statement
list */
	};
	NodeT* left; /* operators */
	NodeT* right;
};

/* prototypes in sym.c*/
Symbol* lookupSym(char* str);
Symbol* insertSym(char* s);
char* xstrdup(char* name);
void* xmalloc(size_t size);
void sys_error(char* str);

/* prototypes in kalk.c*/
NodeT* Opr3(int oper, NodeT* n1, NodeT* n2,NodeT* n3);
NodeT* Opr2(int oper, NodeT* n1, NodeT* n2) ;
NodeT* Opr1(int oper, NodeT* n1) ;
NodeT* AppendStmt(NodeT* list, NodeT* st);
NodeT* Var(Symbol *sp);
NodeT* NumConst(double value);
NodeT* MatFun(pmatFunT pmatFun, NodeT* expr) ;
void freeNode(NodeT* p);

double Execute(NodeT* n);

void yyerror(char* s);
int yyparse();
int yylex();

/*global variables*/
extern int lineno;
extern FILE* yyin;

/*jump on eror*/
extern jmp_buf jumpdata;

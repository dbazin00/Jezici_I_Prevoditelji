/* file: kalk_sym.c */

#include "kalk.h"

static Symbol* symtable = NULL;

void sys_error(char* str) /* sys error handling */
{
	printf("%s\n",str);
	exit(1);
}

char* xstrdup(char* name)
{
	char* str= xmalloc(strlen(name)+1);
	strcpy(str,name);
	return str;
}

void* xmalloc(size_t size)
{
	void* p = malloc(size);
	if (p == NULL)
		sys_error("No memory\n");
	return p;
}

Symbol* lookupSym(char* str) /* return *sym or NULL if not
found*/
{
	Symbol* sp;
	for (sp=symtable; sp !=NULL; sp = sp->next) {
		if (strcmp(sp->name, str) == 0)
			return sp;
	}
	return NULL;
}

Symbol* insertSym(char* str)
{
	Symbol* sym = xmalloc(sizeof(Symbol));
	sym->name=str;
	sym->val = 0;
	sym->next = symtable;
	symtable = sym;
	return sym;
}

void delete_table()
{
	Symbol* sym = symtable;
	while (symtable != NULL) {
		symtable = sym -> next;
		free(sym->name);
		free(sym);
	}
}

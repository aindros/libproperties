%{

#include <stdio.h>
#include <stdlib.h>
#include "utils/string.h"

char *
cpyval(size_t number,
       size_t size,
       char *value)
{
	char *dest = calloc(number, size);
	return strcat(dest, value);
}

%}

%token KEY DIV VALUE

%union
{
	char *value;
}

%%

properties: property
	| properties property
	;

property: KEY DIV value {
			printf("<%s> ---> <%s>\n", $1.value, trim($3.value));
		}
	| KEY DIV {
			printf("<%s> ---> NO VALUE\n", $1.value);
		}
	;

value: DIV {
			$$.value = cpyval(2, sizeof(char), $1.value);
		}
	| value DIV {
			char *s = strdup($$.value);
			$$.value = calloc(strlen(s) + strlen($2.value) + 1, sizeof(char));
			strcat($$.value, s);
			strcat($$.value, $2.value);
		}
	| VALUE {
			$$.value = cpyval(2, sizeof(char), $1.value);
		}
	| value VALUE {
			char *s = strdup($$.value);
			$$.value = calloc(strlen(s) + strlen($2.value) + 1, sizeof(char));
			strcat($$.value, s);
			strcat($$.value, $2.value);
		}
	;

%%

extern FILE *yyin;

void
properties_load(FILE *file)
{
	if (file == NULL) {
		fprintf(stderr, "No file to read.\n");
		exit(1);
	}

	yyin = file;

	do {
		yyparse();
	} while(!feof(yyin));
}

void
yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
}

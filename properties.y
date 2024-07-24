%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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
			printf("<%s> ---> <%s>\n", $1.value, $3.value);
		}
	| KEY DIV {
			printf("<%s> ---> NO VALUE\n", $1.value);
		}
	;

value: VALUE {
			$$.value = calloc(2, sizeof(char));
			strcat($$.value, $1.value);
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

int
main(void)
{
	do {
		yyparse();
	} while(!feof(yyin));

	return EXIT_SUCCESS;
}

void
yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
}

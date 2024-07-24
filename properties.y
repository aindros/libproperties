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

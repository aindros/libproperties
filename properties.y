%{

#include <stdio.h>
#include <stdlib.h>

%}

%token KEY DIV VALUE

%%

value: VALUE
	| VALUE value
	;

%%

void
yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
}

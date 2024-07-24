%{
#include "properties-parser.h"
%}

%%

=|:                    return DIV;
^[ \t]*[a-zA-Z0-9\.]*  yylval.value = strdup(yytext); return KEY;
.                      yylval.value = strdup(yytext); return VALUE;

%%

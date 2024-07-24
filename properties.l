%{
#include "properties-parser.h"
%}

%%

=|:                    return DIV;
^[ \t]*[a-zA-Z0-9\.]*  yylval.value = strdup(yytext); return KEY;
.                      yylval.value = strdup(yytext); return VALUE;
\n*                    ;
^[ \t]*/\r?\n          ;	/* /\r?\n get the end of line, ref: https://stackoverflow.com/a/56104754 */

%%

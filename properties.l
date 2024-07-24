%{
#include "properties-parser.h"
%}

%%

=|:                    return DIV;
^[ \t]*[a-zA-Z0-9\.]*  yylval.value = strdup(yytext); return KEY;
\n                     ; /* Ignores empty lines with a single newline */
^[ \t]*#.*             ; /* Ignores comments */
^[ \t]*/\r?\n          ; /* /\r?\n get the end of line, ref: https://stackoverflow.com/a/56104754 */
.                      yylval.value = strdup(yytext); return VALUE;

%%

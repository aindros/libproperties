%{
#include "properties-parser.h"
%}

%%

=|:                    return DIV;
^[ \t]*[a-zA-Z0-9\.]*  return KEY;
[ \t]*                 ;
.                      return VALUE;

%%

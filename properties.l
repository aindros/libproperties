%{
enum {
	KEY = 1,
	DIV,
	VALUE
};
%}

%%

=|:                    return DIV;
^[ \t]*[a-zA-Z0-9\.]*  return KEY;
[ \t]*                 ;
.                      return VALUE;

%%

struct Properties {
	char *key;
	char *value;
	struct Properties *next;
};

int
main(void)
{
	int token;
	int next_token = KEY;
	struct Properties properties;
	properties.next = NULL;

	char *key;
	char *value = calloc(2048, sizeof(char));
	int v = 0;

	do {
		v = 0;
		value = calloc(2048, sizeof(char));

		token = yylex();

		if (next_token == VALUE) {
			if (token == VALUE) {
				do {
					*(value + v) = *yytext;
					v++;
				} while ((token = yylex()) == VALUE);
			}

			next_token = KEY;
			printf("%s --> %s|\n", key, value);
		}

		if (token == KEY && next_token == KEY) {
			next_token = DIV;
			key = strdup(yytext);
		} else if (token == DIV && next_token == DIV) {
			next_token = VALUE;
		}
	} while (token != 0);

	while (properties.next != NULL) {
		printf("%s ---> %s\n", properties.key, properties.value);
	}

	return EXIT_SUCCESS;
}

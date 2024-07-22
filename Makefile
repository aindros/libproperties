LEX  = lex
YACC = yacc
CC   = cc

OBJ = properties-lexer.o

LFLAGS = -ll


all: properties
#	${CC} properties-lexer.c properties-parser.c -o properties -ll -ly

properties-lexer.o: properties.l
	${LEX} properties.l
	@mv lex.yy.c properties-lexer.c
	${CC} -c properties-lexer.c

properties: ${OBJ}
	${CC} ${OBJ} -o $@ ${LFLAGS}

clean:
	@rm -f ${OBJ} *.core a.out
	@rm -f properties-lexer.c lex.*
	@rm -f properties

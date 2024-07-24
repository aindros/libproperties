VER  = 0.0.0-alpha.1
LEX  = lex
YACC = yacc
CC   = cc

OBJ = utils/string.o properties-parser.o properties-lexer.o

CFLAGS = -DVERSION=${VER}
LFLAGS = -ll -ly


all: properties
#	${CC} properties-lexer.c properties-parser.c -o properties -ll -ly

properties-lexer.o: properties.l
	${LEX} properties.l
	@mv lex.yy.c properties-lexer.c
	${CC} ${CFLAGS} -c properties-lexer.c

properties-parser.o properties-parser.h: properties.y
	${YACC} -d properties.y
	@mv y.tab.c properties-parser.c
	@mv y.tab.h properties-parser.h
	${CC} ${CFLAGS} -c properties-parser.c

utils/string.o: utils/string.c
	${CC} ${CFLAGS} -c $< -o $@

properties: ${OBJ}
	${CC} ${OBJ} -o $@ ${LFLAGS}

clean:
	@rm -f ${OBJ} *.core a.out
	@rm -f properties-lexer.c lex.*
	@rm -f properties
	@rm -f properties-parser.* y.*

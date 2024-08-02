include config.mk

OBJ = utils/string.o properties-parser.o properties-lexer.o

CFLAGS  = -DVERSION=${VER}
LFLAGS  = -ll -ly


all: lib${NAME}.a lib${NAME}.so

# Generate the lexer source
properties-lexer.c: properties.l
	${LEX} properties.l
	@mv lex.yy.c properties-lexer.c

# Generate the parser source
properties-parser.h properties-parser.c: properties.y
	${YACC} -d properties.y
	@mv y.tab.c properties-parser.c
	@mv y.tab.h properties-parser.h

.c.o:
	${CC} ${CFLAGS} -c $< -o $@

build_static:
	@make clean ${OBJ}

build_shared:
	@make CFLAGS="${CFLAGS} -fPIC" clean ${OBJ}

lib${NAME}.a: build_static
	${CC} ${OBJ} -o $@ ${LFLAGS}

lib${NAME}.so: build_shared
	${CC} ${OBJ} -o $@ ${LFLAGS}

clean:
	@rm -f ${OBJ} *.core a.out
	@rm -f properties-lexer.c lex.*
	@rm -f properties
	@rm -f properties-parser.* y.*

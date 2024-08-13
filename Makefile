include config.mk

SRC = utils/string.c properties-parser.c properties-lexer.c
STATIC_OBJ = build/static/utils/string.o build/static/properties-parser.o build/static/properties-lexer.o
SHARED_OBJ = build/shared/utils/string.o build/shared/properties-parser.o build/shared/properties-lexer.o

CFLAGS  = -DVERSION=${VER}
#LFLAGS  = -ll -ly
LFLAGS  = -l:libl.a -l:liby.a

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

lib${NAME}.a: ${STATIC_OBJ}
	mkdir -p ext
	cd ext && ar -x /usr/lib/liby.a && ar -x /usr/lib/libl.a
	ar rcs $@ ${STATIC_OBJ} ext/*

lib${NAME}.so: ${SHARED_OBJ}
	${CC} ${SHARED_OBJ} -o $@ ${LFLAGS}

clean:
	@rm -rf build ext
	@rm -f properties-lexer.c lex.*
	@rm -f properties-parser.* y.*

build/static/utils/string.o: utils/string.c
	@mkdir -p build/static/utils
	${CC} ${CFLAGS} -c utils/string.c -o $@

build/static/properties-parser.o: properties-parser.c
	@mkdir -p build/static
	${CC} ${CFLAGS} -c properties-parser.c -o $@

build/static/properties-lexer.o: properties-lexer.c
	@mkdir -p build/static
	${CC} ${CFLAGS} -c properties-lexer.c -o $@

build/shared/utils/string.o: utils/string.c
	@mkdir -p build/shared/utils
	${CC} ${CFLAGS} -fPIC -c utils/string.c -o $@

build/shared/properties-parser.o: properties-parser.c
	@mkdir -p build/shared
	${CC} ${CFLAGS} -fPIC -c properties-parser.c -o $@

build/shared/properties-lexer.o: properties-lexer.c
	@mkdir -p build/shared
	${CC} ${CFLAGS} -fPIC -c properties-lexer.c -o $@


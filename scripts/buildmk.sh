#!/bin/sh

gen_obj()
{
	dir=$1
	for i in $SRC; do
		echo -n $i | sed "s|^| $1|g" | sed 's/\.c$/.o/g'
	done
}

SRC="utils/string.c properties-parser.c properties-lexer.c"
OBJA=$(gen_obj build/static/)
OBJSO=$(gen_obj build/shared/)

cat << EOF > Makefile
include config.mk

SRC = $SRC
STATIC_OBJ =$OBJA
SHARED_OBJ =$OBJSO

CFLAGS  = -DVERSION=${VER}
#LFLAGS  = -ll -ly
LFLAGS  = -l:libl.a -l:liby.a

all: lib\${NAME}.a lib\${NAME}.so

# Generate the lexer source
properties-lexer.c: properties.l
	\${LEX} properties.l
	@mv lex.yy.c properties-lexer.c

# Generate the parser source
properties-parser.h properties-parser.c: properties.y
	\${YACC} -d properties.y
	@mv y.tab.c properties-parser.c
	@mv y.tab.h properties-parser.h

lib\${NAME}.a: \${STATIC_OBJ}
	mkdir ext
	cd ext && ar -x /usr/lib/liby.a && ar -x /usr/lib/libl.a
	ar rcs \$@ \${STATIC_OBJ} ext/*

lib\${NAME}.so: \${SHARED_OBJ}
	\${CC} \${SHARED_OBJ} -o \$@ \${LFLAGS}

clean:
	@rm -rf build
	@rm -f properties-lexer.c lex.*
	@rm -f properties-parser.* y.*

EOF


for obj in $OBJA; do
src=$(echo $obj | sed 's/.*\/static\///g' | sed 's/\.o/.c/g')
cat << EOF >> Makefile
$obj: $src
	@mkdir -p $(dirname $obj)
	\${CC} \${CFLAGS} -c $src -o \$@

EOF
done


for obj in $OBJSO; do
src=$(echo $obj | sed 's/.*\/shared\///g' | sed 's/\.o/.c/g')
cat << EOF >> Makefile
$obj: $src
	@mkdir -p $(dirname $obj)
	\${CC} \${CFLAGS} -fPIC -c $src -o \$@

EOF
done
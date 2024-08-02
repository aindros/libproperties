test:
	cc -c main.c -o main.o
	cc main.o -L.. -l:libproperties.a -o $@

clean:
	rm -rf test

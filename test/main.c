#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../properties.h"

int
main(int argc, char **argv)
{
	FILE *file;

	for (int i = 1; i < argc; i++) {
		if (strcmp(argv[i], "-f") == 0 && (i + 1) < argc) {
			file = fopen(argv[i + 1], "r");
			break;
		}
	}

	properties_load(file);

	return EXIT_SUCCESS;
}

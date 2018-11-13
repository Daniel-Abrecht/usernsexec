CC = gcc

all: bin/usernsexec

bin/usernsexec: src/usernsexec.c
	mkdir -p bin
	$(CC) -std=c99 -Wall -Wextra -Werror -pedantic $^ -o $@

clean:
	rm -rf bin

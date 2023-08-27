# Definitions

CC = gcc
CC_FLAGS = -fomit-frame-pointer -fno-asynchronous-unwind-tables -ggdb -Wall -Werror
CC_OPTIONS = -c
CC_SO_OPTIONS = -shared -fpic
CC_DL_OPTIONS = -rdynamic
OD = objdump
OD_FLAGS = -d -h -r -s -S -t 
RM = /bin/rm -f
LD = gcc
LIBS = -ldl

SRCS := ci.c handle_args.c interface.c lex.c parse.c eval.c print.c err_handler.c variable.c
OBJS := $(SRCS:%.c=%.o)

HDRS := ci.h node.h

# Generic rules

%.i: %.c
	${CC} ${CC_OPTIONS} -E ${CC_FLAGS} $<

%.s: %.c
	${CC} ${CC_OPTIONS} -S ${CC_FLAGS} $<

%.o: %.c
	${CC} ${CC_OPTIONS} ${CC_FLAGS} $<

# Targets

all: ci test_week1 test_week2 test_week3 clean

ci: ${OBJS} ${HDRS}
	${CC} ${CC_FLAGS} -o $@ ${OBJS}

test_week1: ci
	chmod +x driver.sh
	./driver.sh tests/test_week1_basic.txt
	./driver.sh tests/test_week1_easy.txt
	./driver.sh tests/test_week1_bad.txt
	./driver.sh tests/test_week1_hard.txt

test_week2: ci
	chmod +x driver.sh
	./driver.sh tests/test_week1_basic.txt
	./driver.sh tests/test_week1_easy.txt
	./driver.sh tests/test_week1_bad.txt
	./driver.sh tests/test_week1_hard.txt
	./driver.sh tests/test_week2_basic.txt
	./driver.sh tests/test_week2_easy.txt
	./driver.sh tests/test_week2_bad.txt
	./driver.sh tests/test_week2_hard.txt
	echo "Checking for memory leaks on week 1 tests..."
	valgrind --log-file=valgrind_log ./ci < tests/test_week1_basic.txt > /dev/null
	cat valgrind_log | grep -A 9 "HEAP SUMMARY"
	valgrind --log-file=valgrind_log ./ci < tests/test_week1_easy.txt > /dev/null
	cat valgrind_log | grep -A 9 "HEAP SUMMARY"
	valgrind --log-file=valgrind_log ./ci < tests/test_week1_bad.txt > /dev/null
	cat valgrind_log | grep -A 9 "HEAP SUMMARY"
	valgrind --log-file=valgrind_log ./ci < tests/test_week1_hard.txt > /dev/null
	cat valgrind_log | grep -A 9 "HEAP SUMMARY"
	echo "Checking for memory leaks on week 2 tests..."
	valgrind --log-file=valgrind_log ./ci < tests/test_week2_basic.txt > /dev/null
	cat valgrind_log | grep -A 9 "HEAP SUMMARY"
	valgrind --log-file=valgrind_log ./ci < tests/test_week2_easy.txt > /dev/null
	cat valgrind_log | grep -A 9 "HEAP SUMMARY"
	valgrind --log-file=valgrind_log ./ci < tests/test_week2_bad.txt > /dev/null
	cat valgrind_log | grep -A 9 "HEAP SUMMARY"
	valgrind --log-file=valgrind_log ./ci < tests/test_week2_hard.txt > /dev/null
	cat valgrind_log | grep -A 9 "HEAP SUMMARY"
	rm valgrind_log

test_week3: ci
	chmod +x driver.sh
	./driver.sh tests/test_week1_basic.txt
	./driver.sh tests/test_week1_easy.txt
	./driver.sh tests/test_week1_bad.txt
	./driver.sh tests/test_week1_hard.txt
	./driver.sh tests/test_week2_basic.txt
	./driver.sh tests/test_week2_easy.txt
	./driver.sh tests/test_week2_bad.txt
	./driver.sh tests/test_week2_hard.txt
	./driver.sh tests/test_week3_basic.txt
	./driver.sh tests/test_week3_easy.txt
	./driver.sh tests/test_week3_bad.txt
	./driver.sh tests/test_week3_hard.txt
	echo "Checking for memory leaks on week 1 tests..."
	valgrind --log-file=valgrind_log ./ci < tests/test_week1_basic.txt > /dev/null
	cat valgrind_log | grep -A 9 "HEAP SUMMARY"
	valgrind --log-file=valgrind_log ./ci < tests/test_week1_easy.txt > /dev/null
	cat valgrind_log | grep -A 9 "HEAP SUMMARY"
	valgrind --log-file=valgrind_log ./ci < tests/test_week1_bad.txt > /dev/null
	cat valgrind_log | grep -A 9 "HEAP SUMMARY"
	valgrind --log-file=valgrind_log ./ci < tests/test_week1_hard.txt > /dev/null
	cat valgrind_log | grep -A 9 "HEAP SUMMARY"
	echo "Checking for memory leaks on week 2 tests..."
	valgrind --log-file=valgrind_log ./ci < tests/test_week2_basic.txt > /dev/null
	cat valgrind_log | grep -A 9 "HEAP SUMMARY"
	valgrind --log-file=valgrind_log ./ci < tests/test_week2_easy.txt > /dev/null
	cat valgrind_log | grep -A 9 "HEAP SUMMARY"
	valgrind --log-file=valgrind_log ./ci < tests/test_week2_bad.txt > /dev/null
	cat valgrind_log | grep -A 9 "HEAP SUMMARY"
	valgrind --log-file=valgrind_log ./ci < tests/test_week2_hard.txt > /dev/null
	cat valgrind_log | grep -A 9 "HEAP SUMMARY"
	echo "Checking for memory leaks on week 3 tests..."
	valgrind --log-file=valgrind_log ./ci < tests/test_week3_basic.txt > /dev/null
	cat valgrind_log | grep -A 9 "HEAP SUMMARY"
	valgrind --log-file=valgrind_log ./ci < tests/test_week3_easy.txt > /dev/null
	cat valgrind_log | grep -A 9 "HEAP SUMMARY"
	valgrind --log-file=valgrind_log ./ci < tests/test_week3_bad.txt > /dev/null
	cat valgrind_log | grep -A 9 "HEAP SUMMARY"
	valgrind --log-file=valgrind_log ./ci < tests/test_week3_hard.txt > /dev/null
	cat valgrind_log | grep -A 9 "HEAP SUMMARY"
	rm valgrind_log

debug: clean ${OBJS} ${HDRS}
	${CC} ${CC_OPTIONS} ${CC_FLAGS} -o ci.o -DDEBUG ci.c
	${CC} ${CC_FLAGS} -o ci ${OBJS}
	gdb ci

clean:
	${RM} *.o *.so _output* ci

.PHONY: all clean debug

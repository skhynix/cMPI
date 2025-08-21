CC=gcc
CFLAGS=-I. -W -Wall -Wextra -Wuninitialized -Wstrict-aliasing
DEPS=util.h test.h workload.h
OBJ=util.o test.o workload.o main.o
LDLIBS=-lpthread -lnuma -lm

.PHONY: all
all: cxlMemTest memsetLatencyTest

memsetLatencyTest: memset_latency_test.o
	$(CC) -o $@ $^ $(CFLAGS) $(LDLIBS)

memset_latency_test.o: memset_latency_test.c
	$(CC) -c -o $@ $< $(CFLAGS)

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

cxlMemTest: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS) $(LDLIBS)

.PHONY: clean
clean:
	$(RM) *~ *.o cxlMemTest memsetLatencyTest

debug: CFLAGS+=-g
debug: cxlMemTest


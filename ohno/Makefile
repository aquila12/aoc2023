TARGET = aoc2023
LIBS = -lm
CC = gcc
CFLAGS = -O3 -g -Wall

.PHONY: default all clean

default: $(TARGET)
all: default

OBJECTS = $(patsubst %.c, %.o, $(wildcard *.c))
HEADERS = $(wildcard *.h)

%.o: %.c $(HEADERS) Makefile
	$(CC) $(CFLAGS) -c $< -o $@

.PRECIOUS: $(TARGET) $(OBJECTS)

$(TARGET).dbg: $(OBJECTS) Makefile
	$(CC) $(OBJECTS) -Wall $(LIBS) -o $@

$(TARGET): $(TARGET).dbg
	strip $< -o $@

clean:
	-rm -f *.o
	-rm -f $(TARGET) $(TARGET).dbg

EXEC ?= hello_world
LIB ?= libhello.a
TEST_LIB ?=libtest.so
BUILD_DIR ?= ./build

SRCS := $(wildcard *.c)
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
OBJS_LIB := $(SRCS:%=$(BUILD_DIR)/lib/%.o)

CFLAGS = -g -Wall
CC = clang

SHELL:=/bin/bash
.ONESHELL:

all: $(BUILD_DIR)/$(EXEC) $(BUILD_DIR)/lib/$(TEST_LIB)

$(BUILD_DIR)/$(EXEC): $(OBJS) $(BUILD_DIR)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)

$(BUILD_DIR)/%.c.o: %.c $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/lib/%.c.o: %.c $(BUILD_DIR)
	$(CC) $(CFLAGS) -fPIC -c $< -o $@

$(BUILD_DIR)/lib/$(LIB): $(OBJS_LIB) 
	ar rcs $@ $^ 

$(BUILD_DIR)/tests.c.o: tests/tests.c $(BUILD_DIR)
	$(CC) -c $(CFLAGS) -fpic $< -o $@

$(BUILD_DIR)/lib/$(TEST_LIB): $(BUILD_DIR) $(BUILD_DIR)/tests.c.o $(BUILD_DIR)/lib/$(LIB)
	$(CC) -fpic -shared $(BUILD_DIR)/tests.c.o $(BUILD_DIR)/lib/$(LIB) -o $@

$(BUILD_DIR):
	$(MKDIR_P) $@/lib

clean:
	rm -rf $(BUILD_DIR)

run: $(BUILD_DIR)/$(EXEC)
	$(BUILD_DIR)/$(EXEC)

MKDIR_P ?= mkdir -p

.PHONY: clean run upload

update:
	./update.sh

test: $(BUILD_DIR)/lib/$(TEST_LIB)
	./testrunner -c tests.toml
	firefox result.html

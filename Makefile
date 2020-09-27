EXEC ?= hello_world
BUILD_DIR ?= ./build

SRCS := $(wildcard *.c)
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)

CFLAGS = -g -Wall
CC = clang

SHELL:=/bin/bash
.ONESHELL:

$(BUILD_DIR)/$(EXEC): $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)

$(BUILD_DIR)/%.c.o: %.c
	$(MKDIR_P) $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(BUILD_DIR)

run: $(BUILD_DIR)/$(EXEC)
	$(BUILD_DIR)/$(EXEC)

MKDIR_P ?= mkdir -p

.PHONY: clean run upload

upload:
	@ echo "Please enter a commit message:"; \
	read cm; \
	git add .; \
	git commit -m "$$cm"; \
	git push;

update:

OBJS	= main.o
SOURCE	= main.c
HEADER	= 
OUT		= hello_world
CC	 	= clang
FLAGS	= -g -c -Wall
LFLAGS	= 

all: $(OBJS)
	$(CC) -g $(OBJS) -o $(OUT) $(LFLAGS)

main.o: main.c
	$(CC) $(FLAGS) main.c 


clean:
	rm -f $(OBJS) $(OUT)

run: $(OUT)
	./$(OUT)

upload:
	@ echo "Please enter a commit message:"; \
	read cm; \
	git add .; \
	git commit -m "$$cm"; \
	git push;

#There must be a tab at the beginning of any command, and make will not be happy if it's not there.


#Then we define a rule that applies to all files ending in the .o suffix. The rule says that the .o file depends upon the .c version of the file and the .h files included in the DEPS macro. The rule then says that to generate the .o file, make needs to compile the .c file using the compiler defined in the CC macro. The -c flag says to generate the object file, the -o $@ says to put the output of the compilation in the file named on the left side of the :, the $< is the first item in the dependencies list
%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)


#let's use the special macros $@ and $^, which are the left and right sides of the :, respectively, to make the overall compilation rule more general
hellomake: $(OBJ)
		gcc -o $@ $^ $(CFLAGS)

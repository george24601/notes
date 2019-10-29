You can also use for/in to work on a string. The string acts like a list of its chars, so for ch in s: print ch prints all the chars in a string

A module is a file containing Python definitions and statements. The file name is the module name with the suffix .py appended. Within a module, the module’s name (as a string) is available as the value of the global variable __name__

the code in the module will be executed, just as if you imported it, but with the __name__ set to "__main__". 

The directory containing the script being run is placed at the beginning of the search path, ahead of the standard library path. This means that scripts in that directory will be loaded instead of modules of the same name in the library directory.

Suppose you've got a module "binky.py" which contains a "def foo()". The fully qualified name of that foo function is "binky.foo".

we recommend the original form with the fully-qualified names because it's a lot easier to determine where a function or attribute came from.o

String literals can be enclosed by either double or single quotes, although single quotes are more commonly used

Unlike Java, the '+' does not automatically convert numbers or other types to string form. The str() function converts values to a string form so they can be combined with other strings

There is no ++ operator, but +=, -=, etc. work.

 A "raw" string literal is prefixed by an 'r' and passes all the chars through without special treatment of backslashes, so r'x\nx' evaluates to the length-4 string 'x\nx'. A 'u' prefix allows you to write a unicode string literal

 The first line of a function can be a documentation string ("docstring") that describes what the function does
It's typical to def a main() function towards the bottom of the file with the functions it calls above it.

In a standard Python program, the list sys.argv contains the command-line arguments in the standard way with sys.argv[0] being the program itself, sys.argv[1] the first argument, and so on. If you know about argc, or the number of arguments, you can simply request this value from Python with len(sys.argv),

To loop over two or more sequences at the same time, the entries can be paired with the zip() function.

can use == to compare strings

None, False, 0, "", (), [] are all False. Others are true

In Python, all input is just gotten from the input() function, which you do not need to import. As a parameter to the input function, you give the prompt for the user.

dir is a function that will not be useful in your actual code, per se. However, it’s exceptionally useful when you’re dealing with some kind of new object, and you want to find out what kind of attributes it has.

help() is a function similar to dir(), in that it’s useful for debugging and quick testing. When you pass it a function, it will show you the docstring help text for that function.

pop() is an interesting method - it returns the last item of a list, but also removes it from the list

Sort of like range, reversed takes in a list, and returns an iterator with the reverse of a list. an iterator is another kind of lazy object that you can loop over.

new_grades = [x+10 for x in grades]

even_nums = [x for x in nums if x%2==0]

You can also always convert a list to a tuple using the tuple, or a tuple to a list using the list function

Probably the most useful string function that I know of is split, which splits a string into a list, based on whatever separator you give it. If you don’t give split a parameter, it just splits on the space.

 but * also works because it's Python's "repeat" operator, meaning that '-' * 10 gives '----------', a neat way to create an onscreen "line."

Python coroutine?

__new()__ vs __int()__

list comprehension vs generator

implement a singleton via decorator

gc in python?

copy() vs deepcopy(), how do you implement deepcopy()

ternary operaote, e.g., like ?: in C++

money patching?

__doc__ is also a valid attribute, returning the docstring belonging to the class

When a class defines an __init__(self) method, class instantiation automatically invokes __init__() for the newly-created class instance. So in this example, a new, initialized instance can be obtained by:

the special thing about methods is that the instance object is passed as the first argument of the function. In our example, the call x.f() is exactly equivalent to MyClass.f(x).

Any identifier of the form __spam (at least two leading underscores, at most one trailing underscore) is textually replaced with _classname__spam, where classname is the current class name with leading underscore(s) stripped. This mangling is done without regard to the syntactic position of the identifier, as long as it occurs within the definition of a class.

Note that the mangling rules are designed mostly to avoid accidents; it still is possible to access or modify a variable that is considered private. This can even be useful in special circumstances, such as in the debugger.

Indices may also be negative numbers, to start counting from the right: -1 is the right most char

Python strings cannot be changed — they are immutable. Therefore, assigning to an indexed position in the string results in an error:

Loop statements may have an else clause; it is executed when the loop terminates through exhaustion of the list (with for) or when the condition becomes false (with while), but not when the loop is terminated by a break statement. This is exemplified by the following loop, which searches for prime numbers

Important warning: The default value is evaluated only once. This makes a difference when the default is a mutable object such as a list, dictionary, or instances of most classes.

List comprehension?

object's __dict__ dictionary

An underscore  at the beginning is used to denote private variables in Python. Please note that private variables don't exist in Python. There are simply norms to be followed. The language itself don't apply any restrictions.

We can use the @ symbol along with the name of the decorator function and place it above the definition of the function to be decorated.

In Python, this magic is done as `function(*args, **kwargs)`. In this way, args will be the tuple of positional arguments and kwargs will be the dictionary of keyword arguments.

iterator? 

yield?

which queue is thread safe?

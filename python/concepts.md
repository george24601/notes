Python coroutine?

mutable and immutable types?

__new()__ vs __int()__

list comprehension vs generator

implement a singleton via decorator

gc in python?

copy() vs deepcopy(), how do you implement deepcopy()

list vs tuple

ternary operaote, e.g., like ?: in C++

help() and dir() in python?

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



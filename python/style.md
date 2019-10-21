With Python, we use “snake_case,” which separates the words by underscores, and where all the letters are lowercase. The same convention is used for function names.

The docstring is just a string that’s listed under the function definition that explains what the function does. Use them

Use import statements for packages and modules only, not for individual classes or functions

Name your classes and functions consistently; the convention is to use CamelCase for classes and lower_case_with_underscores for functions and methods. Always use self as the name for the first method argument

Use import x for importing packages and modules.

Use from x import y where x is the package prefix and y is the module name with no prefix.

Do not use relative names in imports. Even if the module is in the same package, use the full package name. 

Container types, like dictionaries and lists, define default iterators and membership test operators ("in" and "not in").

Import each module using the full pathname location of the module.

Yes:  for key in adict: ...
      if key not in adict: ...
      if obj in alist: ...
      for line in afile: ...
      for k, v in dict.iteritems(): ...

A generator function returns an iterator that yields a value each time it executes a yield statement. After it yields a value, the runtime state of the generator function is suspended until the next value is needed.

Fine. Use "Yields:" rather than "Returns:" in the doc string for generator functions.

Often you have a function that uses lots of default values, but—rarely—you want to override the defaults. Default argument values provide an easy way to do this, without having to define lots of functions for the rare exceptions. Also, Python does not support overloaded methods/functions and default arguments are an easy way of "faking" the overloading behavior.

Use the "implicit" false if at all possible. Python evaluates certain values as false when in a boolean context. A quick "rule of thumb" is that all "empty" values are considered false so 0, None, [], {}, '' all evaluate as false in a boolean context.

Start the MAIN file of a program with #!/usr/bin/env python with an optional single digit 2 or 3 suffix.

The main functionality should be in a main() function.

In Python, pydoc as well as unit tests require modules to be importable. Your code should always check if __name__ == '__main__' before executing your main() so that the main program is not executed when the module is imported.

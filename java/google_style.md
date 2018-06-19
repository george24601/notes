When a line is broken at a non-assignment operator the break comes before the symbol. (Note that this is not the same practice used in Google style for other languages, such as C++ and JavaScript.)
This also applies to the following "operator-like" symbols:
the dot separator (.)
the two colons of a method reference (::)
an ampersand in a type bound (<T extends Foo & Bar>)
a pipe in a catch block (catch (FooException | BarException e)).

A method or constructor name stays attached to the open parenthesis (() that follows it.
A comma (,) stays attached to the token that precedes it.
A line is never broken adjacent to the arrow in a lambda, except that a break may come immediately after the arrow if the body of the lambda consists of a single unbraced expression

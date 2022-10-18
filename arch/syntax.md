### Syntax design

The usual direct representation of trees in strings is that of S-expressions—parenthesized forms such as (A B C D) where A is the root and B, C, and D are A’s (ordered) children. The children can be primitive values or even...wait for it...trees.

Here :x means just “the symbol x.” It’s just a symbol, nothing more, nothing less. On the other hand, x is an expression that means “go look up the value associated with the symbol :x an use this value.”

The use of curly braces to define subtrees is, for some reason, very popular.

Rather than marking the beginning and end of a block, as is done with the curly brace style and its equivalents, we can get away with just marking the end.

How to separate one construct from another is a really big issue in syntax design, believe it or not. We can identify two main classes of languages: those in which newlines are significant and those in which they are not.

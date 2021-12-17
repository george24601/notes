The type operator typeof converts a (JavaScript) value to its (TypeScript) type. Its operand must be an identifier or a sequence of dot-separated identifiers:

The indexed access operator T[K] returns the types of all properties of T whose keys are assignable to type K. T[K] is also called a lookup type.

The index type query operator keyof #

If a value’s type is a union that includes the types undefined or null, the non-nullish assertion operator (or non-null assertion operator) removes these types from the union. We are telling TypeScript: “This value can’t be undefined or null.” - (postfix !)

Index signatures are needed to describe Arrays or objects that are used as dictionaries.

Recall that each class C creates two entities:

A constructor function C.
An interface C that describes instances of the constructor function.
Similarly, TypeScript has two built-in interfaces:

Interface Object specifies the properties of instances of Object, including the properties inherited from Object.prototype.

Interface ObjectConstructor specifies the properties of class Object.

In JavaScript, objects can play two roles (always at least one of them, sometimes mixtures):

Records have a fixed amount of properties that are known at development time. Each property can have a different type.

Dictionaries have an arbitrary number of properties whose names are not known at development time. All property keys (strings and/or symbols) have the same type, as have property values.

You can only use types when indexing, meaning you can’t use a const to make a variable reference:

Instead of typing the array as Array<any>we can just use Array<unknown>

using unknown enforces us to check the type (or explicitly casting the value) before we do something with a value with is unknown.

any is basically saying the TypeScript compiler to not check that bit of code. Avoid using any whenever you can! It's better to use unknown instead because it enforces you to check the type of the value before using it or else it won't compile!

###

Instead of returning Sometype|undefined from a function which may or may not have a value to return (such as searchCustomer), return Sometype|null.
That forces the function to return a value that's explicitly intended rather than defaulting from a missed out if-else codepath. This is useful since JS is often imperative style code.

###

  interface Person {
      [key: AllowedKeys]: unknown
    }
This is one of annoying aspects of TypeScript. The following should work (in fact, this is how `Record<K, V>` is defined in lib.es5.d.ts after all):
    type Person = {
      [key in AllowedKeys]: unknown
    };
Note the switch from interface to type and `:` replaced with `in`. The point is that the `in` syntax (conceptually expanded into multiple fields) subsumes the `:` syntax (a generic type ascription) and is only available as a mapped type, which is distinct with an interface type. The error message does mention this, but if you don't know what is the mapped type you are left with no clues.

###
“Type aliases and interfaces are very similar, and in many cases you can choose between them freely. Almost all features of an interface are available in type, the key distinction is that a type cannot be re-opened to add new properties vs an interface which is always extendable.” …
“For the most part, you can choose based on personal preference, and TypeScript will tell you if it needs something to be the other kind of declaration. If you would like a heuristic, use interface until you need to use features from type.”

###

interface ServerResponse {
    data: unknown;
  }
... this is the most common way I see unknown used. Then when you fetch data from the server, you are reminded by the compiler that you should do some duck-type checking on it to make sure it's shaped correctly (since responses from a server can be any shape; is it a 200 with your data, or did a caching layer vend you an old version of this data structure, or is something catastrophically wrong and you're seeing a 200 where the payload is HTML saying "Set up your apache server," etc.)
BTW, TypeScript has another useful tool for tying the runtime typing and static typing together: type guards.

  function isUserRecord(x: unknown): x is UserRecord {
    return (x as UserRecord).name !== undefined;
  }
This is a boolean function but the type system understands that in codepaths where it returns true, the 'x' argument is known to have the UserRecord type. Great for codifying your type-discernment logic.

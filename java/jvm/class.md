when class laoded by JVM, it will create an instanceKlass, and leave it the method region

when new(), JVM will create instanceOopDec, which contains mark work, pointer to metadata, and instance data,

A.
String str1 = "abcd"  - in constant pool

String str2 = new String("abcd") - in heap space

B. how many objects does it create? 

String s1 = new String("abc");

How do you verify it?

C.
doube parent delegate model???
Bootstrap classloader?

### classloader

the Java virtual machine contains two kinds of class loaders: a bootstrap class loader and user-defined class loaders. The bootstrap class loader is a part of the virtual machine implementation, and user-defined class loaders are part of the running Java application. Classes loaded by different class loaders are placed into separate name spaces inside the Java virtual machine.

user-defined class loaders are regular Java objects whose class descends from java.lang.ClassLoader. The methods of class ClassLoader allow Java applications to access the virtual machine's class loading machinery. Also, for every type a Java virtual machine loads, it creates an instance of class java.lang.Class to represent that type. Like all objects, user-defined class loaders and instances of class Class reside on the heap. Data for loaded types resides in the method area.

user-defined class loader that is created automatically when the virtual machine starts up

The two overloaded defineClass() methods accept a byte array, data[], as input. Starting at position offset in the array and continuing for length bytes, class ClassLoader expects binary data conforming to the Java class file format--binary data that represents a new type for the running application -- with the fully qualified name specified in name. The type is assigned to either a default protection domain, if the first version of defineClass() is used, or to the protection domain object referenced by the protectionDomain parameter. Every Java virtual machine implementation must make sure the defineClass() method of class ClassLoader can cause a new type to be imported into the method area.

The findSystemClass() method accepts a String representing a fully qualified name of a type. When a user-defined class loader invokes this method in version 1.0 and 1.1, it is requesting that the virtual machine attempt to load the named type via its bootstrap class loader. If the bootstrap class loader has already loaded or successfully loads the type, it returns a reference to the Class object representing the type. If it can't locate the binary data for the type, it throws ClassNotFoundException. In version 1.2, the findSystemClass() method attempts to load the requested type from the system class loader. Every Java virtual machine implementation must make sure the findSystemClass() method can invoke the bootstrap (if version 1.0 or 1.1) or system (if version 1.2 or later) class loader in this way.

The resolveClass() method accepts a reference to a Class instance. This method causes the type represented by the Class instance to be linked (if it hasn't already been linked). The defineClass() method, described previous, only takes care of loading. (See the previous section, "Loading, Linking, and Initialization" for definitions of these terms.) When defineClass() returns a Class instance, the binary file for the type has definitely been located and imported into the method area, but not necessarily linked and initialized. Java virtual machine implementations make sure the resolveClass() method of class ClassLoader can cause the class loader subsystem to perform linking.

#life cycle 

A class variable initializer is an equals sign and expression next to a class variable declaration

A static initializer is a block of code introduced by the static keyword

All the class variable initializers and static initializers of a type are collected by the Java compiler and placed into one special method. For classes, this method is called the class initialization method; for interfaces, the interface initialization method.

In Java class files for both classes and interfaces, this method is named "". Regular methods of a Java application cannot invoke a method. This kind of method can only be invoked by the Java virtual machine, which invokes it to set a type's static variables to their proper initial values.

When the Java virtual machine creates a new instance of a class, either implicitly or explicitly, it first allocates memory on the heap to hold the object's instance variables.
Once the virtual machine has allocated memory for the new object and initialized the instance variables to default values, it is ready to give the instance variables their proper initial values.

If the object is being created because of a clone() invocation, the virtual machine copies the values of the instance variables of the object being cloned into the new object. If the object is being deserialized via a readObject() invocation on an ObjectInputStream, the virtual machine initializes non-transient instance variables of the object from values read from the input stream. Otherwise, the virtual machine invokes an instance initialization method on the object. The instance initialization method initializes the object's instance variables to their proper initial values.

In the Java class file, the instance initialization method is named "<init>." For each constructor in the source code of a class, the Java compiler generates one <init>() method. If the class declares no constructors explicitly, the compiler generates a default no-arg constructor that just invokes the superclass's no-arg constructor. As with any other constructor, the compiler creates an <init>() method in the class file that corresponds to this default constructor.

The code of a () method does not explicitly invoke a superclass's () method. Before a Java virtual machine invokes the () method of a class, therefore, it must make certain the () methods of superclasses have been executed.

If a class declares a method named finalize() that returns void, the garbage collector will execute that method (called a "finalizer") once on an instance of that class, before it frees the memory space occupied by that instance.

The garbage collector may invoke an object's finalizer at most once

Any exceptions thrown by the finalize() method during its automatic invocation by the garbage collector are ignored.

. If the application has no references to the type, then the type can't affect the future course of computation. The type is unreachable and can be garbage collected.

Types loaded through the bootstrap class loader will always be reachable and never be unloaded. Only types loaded through user-defined class loaders can become unreachable and be unloaded by the virtual machine. A type is unreachable if its Class instance is found to be unreachable through the normal process of garbage collecting the heap.

### object header
“KlassOOPs” are different from the Class?? 
The “Mark” field of the OOP header??
Fields that belong to different classes of the hierarchy are NEVER mixed up together. Fields of the superclass come first, obeying rule 2, followed by the fields of the subclass.??
Between the last field of the superclass and the first field of the subclass there must be padding to align to a 4 bytes boundary.

When the first field of a subclass is a double or long and the superclass doesn’t align to an 8 bytes boundary, JVM will break rule 2 and try to put an int, then shorts, then bytes, and then references at the beginning of the space reserved to the subclass until it fills the gap.



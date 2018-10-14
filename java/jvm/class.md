when class laoded by JVM, it will create an instanceKlass, and leave it the method region

when new(), JVM will create instanceOopDec, which contains mark work, pointer to metadata, and instance data,

# creation

1. class loader check - check in the constant pool if params are valid, check if the type has been loaded

2. allocate memory
	1. CAS + retry for thread safety

	2. TLAB: allocate a small amount of memory in Eden region for EACH thread

3. init defaults - that is why default constructor works

4. set object header - type, where to find type metadata (pointer to the type's metadata, this is how type checking is done by JVM), object's hash, object's gc gen info

5. run init method 

#visit 

1. handle: in heap has a handle pool, that has pointer to the object type data and pointer to object instance data.

2. direct pointer, to the object instance data already AND pointer to the object type data

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

These activities are performed in a strict order:

Loading: finding and importing the binary data for a type
Linking: performing verification, preparation, and (optionally) resolution
Verification: ensuring the correctness of the imported type
Preparation: allocating memory for class variables and initializing the memory to default values
Resolution: transforming symbolic references from the type into direct references.
Initialization: invoking Java code that initializes class variables to their proper starting values.

This implementation searches a user-defined directory path stored in an environment variable named CLASSPATH. The bootstrap loader looks in each directory, in the order the directories appear in the CLASSPATH, until it finds a file with the appropriate name: the type's simple name plus ".class". Unless the type is part of the unnamed package, the bootstrap loader expects the file to be in a subdirectory of one the directories in the CLASSPATH. The path name of the subdirectory is built from the package name of the type.

searching the class path is the job of the system class loader, a user-defined class loader that is created automatically when the virtual machine starts up


The two overloaded defineClass() methods accept a byte array, data[], as input. Starting at position offset in the array and continuing for length bytes, class ClassLoader expects binary data conforming to the Java class file format--binary data that represents a new type for the running application -- with the fully qualified name specified in name. The type is assigned to either a default protection domain, if the first version of defineClass() is used, or to the protection domain object referenced by the protectionDomain parameter. Every Java virtual machine implementation must make sure the defineClass() method of class ClassLoader can cause a new type to be imported into the method area.

The findSystemClass() method accepts a String representing a fully qualified name of a type. When a user-defined class loader invokes this method in version 1.0 and 1.1, it is requesting that the virtual machine attempt to load the named type via its bootstrap class loader. If the bootstrap class loader has already loaded or successfully loads the type, it returns a reference to the Class object representing the type. If it can't locate the binary data for the type, it throws ClassNotFoundException. In version 1.2, the findSystemClass() method attempts to load the requested type from the system class loader. Every Java virtual machine implementation must make sure the findSystemClass() method can invoke the bootstrap (if version 1.0 or 1.1) or system (if version 1.2 or later) class loader in this way.

The resolveClass() method accepts a reference to a Class instance. This method causes the type represented by the Class instance to be linked (if it hasn't already been linked). The defineClass() method, described previous, only takes care of loading. (See the previous section, "Loading, Linking, and Initialization" for definitions of these terms.) When defineClass() returns a Class instance, the binary file for the type has definitely been located and imported into the method area, but not necessarily linked and initialized. Java virtual machine implementations make sure the resolveClass() method of class ClassLoader can cause the class loader subsystem to perform linking.

#life cycle 

Loading is the process of bringing a binary form for a type into the Java virtual machine. Linking is the process of incorporating the binary type data into the runtime state of the virtual machine. Linking is divided into three sub-steps: verification, preparation, and resolution. Verification ensures the type is properly formed and fit for use by the Java virtual machine. Preparation involves allocating memory needed by the type, such as memory for any class variables. Resolution is the process of transforming symbolic references in the constant pool into direct references.

(1) loading, (2) linking, and (3) initialization must take place in that order. The only exception to this required ordering is the third phase of linking, resolution, which may optionally take place after initialization.

To load a type, the Java virtual machine must:

given the type's fully qualified name, produce a stream of binary data that represents the type
parse the stream of binary data into internal data structures in the method area
create an instance of class java.lang.Class that represents the type

The Class instance, the end product of the loading step, serves as an interface between the program and the internal data structures. To access information about a type that is stored in the internal data structures, the program invokes methods on the Class instance for that type. Together, the processes of parsing the binary data for a type into internal data structures in the method area and instantiating a Class object on heap are called creating the type.

After a type has been through the first two phases of linking: verification and preparation, it is ready for the third and final phase of linking: resolution. Resolution is the process of locating classes, interfaces, fields, and methods referenced symbolically from a type's constant pool, and replacing those symbolic references with direct references. As mentioned above, this phase of linking is optional until (and unless) each symbolic reference is first used by the program.

A class variable initializer is an equals sign and expression next to a class variable declaration

A static initializer is a block of code introduced by the static keyword

All the class variable initializers and static initializers of a type are collected by the Java compiler and placed into one special method. For classes, this method is called the class initialization method; for interfaces, the interface initialization method.

The code of a () method does not explicitly invoke a superclass's () method. Before a Java virtual machine invokes the () method of a class, therefore, it must make certain the () methods of superclasses have been executed.

Once a class has been loaded, linked, and initialized, it is ready for use. The program can access its static fields, invoke its static methods, or create instances of it.

The four ways a class can be instantiated explicitly are with the new operator, by invoking newInstance()on a Class or java.lang.reflect.Constructor object, by invoking clone() on any existing object, or by deserializing an object via the getObject() method of classjava.io.ObjectInputStream.

In the Java class file, the instance initialization method is named "<init>." For each constructor in the source code of a class, the Java compiler generates one <init>() method. If the class declares no constructors explicitly, the compiler generates a default no-arg constructor that just invokes the superclass's no-arg constructor. As with any other constructor, the compiler creates an <init>() method in the class file that corresponds to this default constructor.
o

If a class declares a method named finalize() that returns void, the garbage collector will execute that method (called a "finalizer") once on an instance of that class, before it frees the memory space occupied by that instance.

The garbage collector may invoke an object's finalizer at most once

Any exceptions thrown by the finalize() method during its automatic invocation by the garbage collector are ignored.

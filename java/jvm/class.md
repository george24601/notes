when class laoded by JVM, it will create an instanceKlass, and leave it the method region

when new(), JVM will create instanceOopDec, which contains mark work, pointer to metadata, and instance data,

# Inside class file

* Magic Number: 0xCAFEBABE

* Version of Class File Format: the minor and major versions of the class file. This includes values such as numbers of all sorts, strings, identifier names, references to classes and methods, and type descriptors. All indexes, or references, to specific constants in the constant pool table are given by 16-bit (type u2) numbers, where index value 1 refers to the first constant in the table (index value 0 is invalid).

* Constant Pool: Pool of constants for the class


For each type it loads, a Java virtual machine must store a constant pool. A constant pool is an ordered set of constants used by the type, including literals (string, integer, and floating point constants) and symbolic references to types, fields, and methods. Entries in the constant pool are referenced by index, much like the elements of an array. 

* Access Flags: for example whether the class is abstract, static, etc.

* This Class: The name of the current class

* Super Class: The name of the super class

* Interfaces: Any interfaces in the class

* Fields: Any fields in the class

The field's name
The field's type
The field's modifiers (some subset of public, private, protected, static, final, volatile, transient)

* Methods: Any methods in the class

The method's name
The method's return type (or void)
The number and types (in order) of the method's parameters
The method's modifiers (some subset of public, private, protected, static, final, synchronized, native, abstract)

The method's bytecodes
The sizes of the operand stack and local variables sections of the method's stack frame (these are described in a later section of this chapter)
An exception table


* Attributes: Any attributes of the class (for example the name of the sourcefile, etc.)


For each type it loads, a Java virtual machine must store the following kinds of information in the method area:

* The fully qualified name of the type

* The fully qualified name of the type's direct superclass (unless the type is an interface or class java.lang.Object, neither of which have a superclass)

* Whether or not the type is a class or an interface

* The type's modifiers ( some subset of` public, abstract, final)

* An ordered list of the fully qualified names of any direct superinterfaces


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

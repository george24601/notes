when class laoded by JVM, it will create an instanceKlass, and leave it the method region

The basic contract of loadClass() is this: Given the fully qualified name of the type to find, the loadClass() method should in some way attempt to locate or produce an array of bytes, purportedly in the Java class file format, that define the type. If loadClass() is unable to locate or produce the bytes, it should throw ClassNotFoundException. Otherwise, loadClass() should pass the array of bytes to one of the defineClass() methods declared in class ClassLoader. By passing the byte array to defineClass(), loadClass() asks the virtual machine to import the type represented by the passed byte array into the namespace of this user-defined class loader. 


* See if the requested type has already been loaded into this class loader's namespace (via findLoadedClass()). If so, return the Class instance for that already-loaded type.
* Otherwise, delegate to this class loader's parent loader. If the parent returns a Class instance, return that same Class instance.
* Otherwise, invoke findClass(), which should attempt to locate or produce an array of bytes, purportedly in the Java class file format, that define the desired type. If successful, findClass() should pass those bytes to defineClass(), which will attempt to import the type and return a Class instance. If findClass() returns a Classinstance, loadClass() returns that same Class instance.
* Otherwise, findClass() completes abruptly with some exception, and loadClass() completes abruptly with the same exception.
* When the loadClass() method of a class loader successfully loads a type, it returns a java.lang.Class object to represent the newly loaded type.

The basic contract of the findClass() method is this: findClass() accepts the fully qualified name of a desired type as its only parameter. findClass() first attempts to locate or produce an array of bytes, purportedly in the Java class file format, that define the type of the requested name. If findClass() is unable to locate or produce the array of bytes, it completes abruptly with ClassNotFoundException. Otherwise, findClass() invokes defineClass(), passing in the requested name, the array of bytes and, optionally, a ProtectionDomain object with which the type should be associated. If defineClass() returns a Class instance for the type, findClass() simply returns that same Class instance to its caller. Otherwise, defineClass() completes abruptly with some exception, and findClass() completes abruptly with the same exception.

### Type Safety with classloaders

If a classloader loads a class, if there is a parent classloader, ask the parent class loader load first, all the wait until bootstrap CL, if bootstrap CL gives ClassNotFoundException, CL task will be pushed down 

If one class loader delegates to another class loader, and the delegated-to class loader defines the type, both class loaders are marked as initiating loaders for that type. The type defined by the delegated-to class loader is shared among all the namespaces of the initiating loaders of the type.

Thus, to uniquely identify a type loaded into a Java virtual machine requires the fully qualified name and the defining class loader.

### classloader

Types:
* Bootstrap ClassLoader: load JAVA_HOMElib and bootclasspath
* Extension ClassLoader: load JAVA_HOMElibext and java.ext.dirs
* Application ClassLoader: classpath in the normal sense 
* User ClassLoader: inherits form Application ClassLoader

the Java virtual machine contains two kinds of class loaders: a bootstrap class loader and user-defined class loaders. The bootstrap class loader is a part of the virtual machine implementation, and user-defined class loaders are part of the running Java application. Classes loaded by different class loaders are placed into separate name spaces inside the Java virtual machine.

Like all objects, user-defined class loaders and instances of class Class reside on the heap. Data for loaded types resides in the method area.

user-defined class loader that is created automatically when the virtual machine starts up

The two overloaded defineClass() methods accept a byte array, data[], as input. Starting at position offset in the array and continuing for length bytes, class ClassLoader expects binary data conforming to the Java class file format--binary data that represents a new type for the running application -- with the fully qualified name specified in name. The type is assigned to either a default protection domain, if the first version of defineClass() is used, or to the protection domain object referenced by the protectionDomain parameter. Every Java virtual machine implementation must make sure the defineClass() method of class ClassLoader can cause a new type to be imported into the method area.

 the findSystemClass() method attempts to load the requested type from the system class loader. Every Java virtual machine implementation must make sure the findSystemClass() method can invoke the system class loader in this way.

The resolveClass() method accepts a reference to a Class instance. This method causes the type represented by the Class instance to be linked (if it hasn't already been linked). The defineClass() method only takes care of loading. When defineClass() returns a Class instance, the binary file for the type has definitely been located and imported into the method area, but not necessarily linked and initialized. Java virtual machine implementations make sure the resolveClass() method of class ClassLoader can cause the class loader subsystem to perform linking.

A class + classloader combination uniquely defines a class
when new(), JVM will create instanceOopDec, which contains mark work, pointer to metadata, and instance data,

### life cycle 

* load - done by the class loader
  * get byte stream via FQTN
  * transform byte stream to method area's runtime data structure
  * create java.lang.Class for this type
* Linking - Verification
  * file format, meta data, byte code, symbol reference
* Linking - Prep
  * allocate memories for class variable and assign init values
  * However for final value, at this same it will be that value already
* Linking - Analyze/Resolution. Note this step can be delayed after init
  * Replace symbolic refrence with direct reference
* Init 
  * execute type constructor () method, 
  * () is to construct types: which ahs static code block or static assign value
  * () method is to execute instances, which runs () first
* Using and finally unloading



Sequence of actions:
* parent's staic block
* child's static block
* parent's non-stack block
* parent's ctor
* child's non-static block
* child's ctor
  

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

### class file

Field ref:
* 1
  * 2
* 16
  * 5
  * 6


Bytecode:
new #24 -- create Account instance
invokespecial #26  --call Account()
invokevirutal #27 -- acall Account.check()

LineNumberTalbe: stores bytecode -> source code line #
LocalVariableTable: stores method's arg NAMES, otherwise, IDE will have to use arg0, arg1...etc

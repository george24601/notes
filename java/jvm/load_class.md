when class laoded by JVM, it will create an instanceKlass, and leave it the method region

If one class loader delegates to another class loader, and the delegated-to class loader defines the type, both class loaders are marked as initiating loaders for that type. The type defined by the delegated-to class loader is shared among all the namespaces of the initiating loaders of the type. 

Like all objects, user-defined class loaders and instances of class Class reside on the heap. Data for loaded types resides in the method area.

The resolveClass() method accepts a reference to a Class instance. This method causes the type represented by the Class instance to be linked (if it hasn't already been linked). The defineClass() method only takes care of loading. When defineClass() returns a Class instance, the binary file for the type has definitely been located and imported into the method area, but not necessarily linked and initialized. Java virtual machine implementations make sure the resolveClass() method of class ClassLoader can cause the class loader subsystem to perform linking.

when new(), JVM will create instanceOopDec, which contains mark work, pointer to metadata, and instance data,


Sequence of actions:
* parent's staic block
* child's static block
* parent's non-static block
* parent's ctor
* child's non-static block
* child's ctor
  
A class variable initializer is an equals sign and expression next to a class variable declaration

A static initializer is a block of code introduced by the static keyword

All the class variable initializers and static initializers of a type are collected by the Java compiler and placed into one special method. For classes, this method is called the class initialization method; for interfaces, the interface initialization method.

If the object is being created because of a clone() invocation, the virtual machine copies the values of the instance variables of the object being cloned into the new object. If the object is being deserialized via a readObject() invocation on an ObjectInputStream, the virtual machine initializes non-transient instance variables of the object from values read from the input stream. Otherwise, the virtual machine invokes an instance initialization method on the object. The instance initialization method initializes the object's instance variables to their proper initial values.

In the Java class file, the instance initialization method is named "<init>." For each constructor in the source code of a class, the Java compiler generates one <init>() method. If the class declares no constructors explicitly, the compiler generates a default no-arg constructor that just invokes the superclass's no-arg constructor. As with any other constructor, the compiler creates an <init>() method in the class file that corresponds to this default constructor.

The code of a () method does not explicitly invoke a superclass's () method. Before a Java virtual machine invokes the () method of a class, therefore, it must make certain the () methods of superclasses have been executed.

If a class declares a method named finalize() that returns void, the garbage collector will execute that method (called a "finalizer") once on an instance of that class, before it frees the memory space occupied by that instance.

The garbage collector may invoke an object's finalizer at most once

Any exceptions thrown by the finalize() method during its automatic invocation by the garbage collector are ignored.


### object header
“KlassOOPs” are different from the Class?? 
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

every Class object has a ClassLoader ref to mark which Classloader loads it
Can use ClassLoader to partially solve diamond dependency problem -> different versions use different classloader 

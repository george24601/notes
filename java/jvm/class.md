when class laoded by JVM, it will create an instanceKlass, and leave it the method region

when new(), JVM will create instanceOopDec, which contains mark work, pointer to metadata, and instance data,

### life cycle 

* load - done by the class loader
  * get byte stream via FQTN
  * transform byte stream to method area's runtime data structure
  * create java.lang.Class for this type
* Verification
  * file format, meta data, byte code, symbol reference
* Prep
  * allocate memories for class variable and assign init values
  * However for final value, at this same it will be that value already
* Analyze
  * Replace symbolic refrence with direct reference
* Init 
  * execute type constructor () method, 
  * () is to construct types: which ahs static code block or static assign value
  * () method is to execute instances, which runs () first

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

```bash
#show bytecode
java -p Employee.class
```

Bytecode:
new #24 -- create Account instance
invokespecial #26  --call Account()
invokevirutal #27 -- acall Account.check()

LineNumberTalbe: stores bytecode -> source code line #
LocalVariableTable: stores method's arg NAMES, otherwise, IDE will have to use arg0, arg1...etc


when class laoded by JVM, it will create an instanceKlass, and leave it the method region

when new(), JVM will create instanceOopDec, which contains mark work, pointer to metadata, and instance data,

# Inside class file

* Magic Number: 0xCAFEBABE

* Version of Class File Format: the minor and major versions of the class file. This includes values such as numbers of all sorts, strings, identifier names, references to classes and methods, and type descriptors. All indexes, or references, to specific constants in the constant pool table are given by 16-bit (type u2) numbers, where index value 1 refers to the first constant in the table (index value 0 is invalid).

* Constant Pool: Pool of constants for the class

* Access Flags: for example whether the class is abstract, static, etc.

* This Class: The name of the current class

* Super Class: The name of the super class

* Interfaces: Any interfaces in the class

* Fields: Any fields in the class

* Methods: Any methods in the class

* Attributes: Any attributes of the class (for example the name of the sourcefile, etc.)

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

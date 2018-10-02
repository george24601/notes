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

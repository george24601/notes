the memory of the method area need not be contiguous. It could be allocated on a heap--even on the virtual machine's own heap.

The method area can also be garbage collected. Because Java programs can be dynamically extended via user-defined class loaders, classes can become "unreferenced" by the application. If a class becomes unreferenced, a Java virtual machine can unload the class (garbage collect it) to keep the memory occupied by the method area at a minimum.

Constants (class variables declared final) are not treated in the same way as non-final class variables. Every type that uses a final class variable gets a copy of the constant value in its own constant pool. 

An instance of class java.lang.Class is created by the Java virtual machine for every type it loads. The virtual machine must in some way associate a reference to the Class instance for a type with the type's data in the method area.

If the virtual machine is unable to load the requested type into the current name space, forName() will throw ClassNotFoundException.

An alternative way to get a Class reference is to invoke getClass() on any object reference. This method is inherited by every object from class Object itself:

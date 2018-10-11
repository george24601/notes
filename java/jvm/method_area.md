the Method area is a part of the Permanent Generation:

Memory for class (static) variables declared in the class is also taken from the method area.

If two threads are attempting to find a class named Lava, for example, and Lava has not yet been loaded, only one thread should be allowed to load it while the other one waits.

1.  runtime constant pool in NO LONGER in method area

2.  The class loader reads in the class file--a linear stream of binary data--and passes it to the virtual machine. The virtual machine extracts information about the type from the binary data and stores the information in the method area. Memory for class (static) variables declared in the class is also taken from the method area.

3. the memory of the method area need not be contiguous. It could be allocated on a heap--even on the virtual machine's own heap.

4. The method area can also be garbage collected. Because Java programs can be dynamically extended via user-defined class loaders, classes can become "unreferenced" by the application. If a class becomes unreferenced, a Java virtual machine can unload the class (garbage collect it) to keep the memory occupied by the method area at a minimum.

The constant pool for the type
Field information
Method information
All class (static) variables declared in the type, except constants
A reference to class ClassLoader
A reference to class Class

For each type it loads, a Java virtual machine must store the following kinds of information in the method area:

The fully qualified name of the type
The fully qualified name of the type's direct superclass (unless the type is an interface or class java.lang.Object, neither of which have a superclass)
Whether or not the type is a class or an interface
The type's modifiers ( some subset of` public, abstract, final)
An ordered list of the fully qualified names of any direct superinterfaces


Field Information
For each field declared in the type, the following information must be stored in the method area. In addition to the information for each field, the order in which the fields are declared by the class or interface must also be recorded. Here's the list for fields:

The field's name
The field's type
The field's modifiers (some subset of public, private, protected, static, final, volatile, transient)

Method Information
For each method declared in the type, the following information must be stored in the method area. As with fields, the order in which the methods are declared by the class or interface must be recorded as well as the data. Here's the list:

The method's name
The method's return type (or void)
The number and types (in order) of the method's parameters
The method's modifiers (some subset of public, private, protected, static, final, synchronized, native, abstract)

the following information must also be stored with each method that is not abstract or native:
The method's bytecodes
The sizes of the operand stack and local variables sections of the method's stack frame (these are described in a later section of this chapter)
An exception table

Class variables are shared among all instances of a class and can be accessed even in the absence of any instance. These variables are associated with the class--not with instances of the class--so they are logically part of the class data in the method area. Before a Java virtual machine uses a class, it must allocate memory from the method area for each non-final class variable declared in the class

Constants (class variables declared final) are not treated in the same way as non-final class variables. Every type that uses a final class variable gets a copy of the constant value in its own constant pool. As part of the constant pool, final class variables are stored in the method area--just like non-final class variables. But whereas non-final class variables are stored as part of the data for the type that declares them, final class variables are stored as part of the data for any type that uses them.

An instance of class java.lang.Class is created by the Java virtual machine for every type it loads. The virtual machine must in some way associate a reference to the Class instance for a type with the type's data in the method area.

For each type it loads, a Java virtual machine must keep track of whether or not the type was loaded via the bootstrap class loader or a user-defined class loader. For those types loaded via a user-defined class loader, the virtual machine must store a reference to the user-defined class loader that loaded the type. This information is stored as part of the type's data in the method area.

When one type refers to another type, the virtual machine requests the referenced type from the same class loader that loaded the referencing type. This process of dynamic linking is also central to the way the virtual machine forms separate name spaces. To be able to properly perform dynamic linking and maintain multiple name spaces, the virtual machine needs to know what class loader loaded each type in its method area.

An instance of class java.lang.Class is created by the Java virtual machine for every type it loads. The virtual machine must in some way associate a reference to the Class instance for a type with the type's data in the method area.

If the virtual machine is unable to load the requested type into the current name space, forName() will throw ClassNotFoundException.

An alternative way to get a Class reference is to invoke getClass() on any object reference. This method is inherited by every object from class Object itself:

For each non-abstract class a Java virtual machine loads, it could generate a method table and include it as part of the class information it stores in the method area. A method table is an array of direct references to all the instance methods that may be invoked on a class instance, including instance methods inherited from superclasses. (A method table isn't helpful in the case of abstract classes or interfaces, because the program will never instantiate these.) A method table allows a virtual machine to quickly locate an instance method invoked on an object.

Method Area: 

	every type's struct info: RCP, String ,and method data, constructor,and normal method's string content
	
	type , instance,interface's special method required on init

#Consider the main class

To run the Volcano application, you give the name "Volcano" to a Java virtual machine in an implementation-dependent manner. Given the name Volcano, the virtual machine finds and reads in file Volcano.class. It extracts the definition of class Volcano from the binary data in the imported class file and places the information into the method area. The virtual machine then invokes the main() method, by interpreting the bytecodes stored in the method area. As the virtual machine executes main(), it maintains a pointer to the constant pool (a data structure in the method area) for the current class (class Volcano).

main()'s first instruction tells the Java virtual machine to allocate enough memory for the class listed in constant pool entry one. The virtual machine uses its pointer into Volcano's constant pool to look up entry one and finds a symbolic reference to class Lava. It checks the method area to see if Lava has already been loaded.

When the virtual machine discovers that it hasn't yet loaded a class named "Lava," it proceeds to find and read in file Lava.class. It extracts the definition of class Lava from the imported binary data and places the information into the method area.

The Java virtual machine then replaces the symbolic reference in Volcano's constant pool entry one, which is just the string "Lava", with a pointer to the class data for Lava. If the virtual machine ever has to use Volcano's constant pool entry one again, it won't have to go through the relatively slow process of searching through the method area for class Lava given only a symbolic reference, the string "Lava". It can just use the pointer to more quickly access the class data for Lava. This process of replacing symbolic references with direct references (in this case, a native pointer) is called constant pool resolution.

Finally, the virtual machine is ready to actually allocate memory for a new Lava object. Once again, the virtual machine consults the information stored in the method area. It uses the pointer (which was just put into Volcano's constant pool entry one) to the Lava data (which was just imported into the method area) to find out how much heap space is required by a Lava object.

Once the Java virtual machine has determined the amount of heap space required by a Lava object, it allocates that space on the heap and initializes the instance variable speed to zero, its default initial value. If class Lava's superclass, Object, has any instance variables, those are also initialized to default initial values.

The first instruction of main() completes by pushing a reference to the new Lava object onto the stack. A later instruction will use the reference to invoke Java code that initializes the speed variable to its proper initial value, five. Another instruction will use the reference to invoke the flow() method on the referenced Lava object

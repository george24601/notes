From the programmer's perspective, one of the most important aspects of Java's architecture to understand is the linking model.

Through user-defined class loaders, your application can load and dynamically link to classes and interfaces that were unknown or did not even exist when your application was compiled.

A class file keeps all its symbolic references in one place, the constant pool. Each class file has a constant pool, and each class or interface loaded by the Java virtual machine has an internal version of its constant pool called the runtime constant pool. The runtime constant pool is an implementation-specific data structure that maps to the constant pool in the class file. Thus, after a type is initially loaded, all the symbolic references from the type reside in the type's runtime constant pool.

Resolution is the process of finding the entity identified by the symbolic reference and replacing the symbolic reference with a direct reference. Because all symbolic references reside in the constant pool, this process is often called constant pool resolution.

Keep in mind that the Java virtual machine contains a separate runtime constant pool for each class and interface it loads. When an instruction refers to the fifth item in the constant pool, it is referring to the fifth item in the constant pool for the current class, the class that defined the method the Java virtual machine is currently executing.

the checking of symbolic references for existence and access permission (one aspect of the full verification phase) is performed during resolution.

No matter when a particular Java virtual machine performs its resolution, it will always throw any error that results from attempting to resolve a symbolic reference at the point in the execution of the program where the symbolic reference was actually used for the first time. In this way, it will always appear to the user as if the resolution were late.

### Resolution and dynamic extension

You can dynamically extend a Java application by passing the name of a type to load to either the forName() method of class java.lang.Class or the loadClass() method of an instance of a user-defined class loader, which can be created from any subclass of java.lang.ClassLoader. Either of these approaches enable your running application to load types whose names are not mentioned in the source code of your application, but rather, are determined by your application as it runs.

The most straightforward way to dynamically extend a Java application is with the forName() method of class java.lang.Class

The other way to dynamically extend a Java application is to load classes via the loadClass() method of a user-defined class loader. To request a type from a user- defined class loader, you invoke loadClass() on that class loader.

The boolean resolve parameter of the two-parameter version of loadClass() indicates whether or not the type should be linked as well as loaded. As mentioned in previous chapters, the process of linking involves three steps: verification of the loaded type, preparation, which involves allocating memory for the type, and optionally, resolution of symbolic references contained in the type. If resolve is true, the loadClass() method should ensure that the type has been linked as well as loaded before it returns the Class instance for that type. If resolve is false, the loadClass() method will merely attempt to load the requested type and not concern itself with whether or not the type is linked.

Whether you should use forName() or invoke loadClass() on a user-defined class loader instance depends on your needs. If you have no special needs that require a class loader, you should probably use forName(), because forName() is the most straightforward approach to dynamic extension. In addition, if you need the requested type to be initialized as well as loaded (and linked), you'll have to use forName(). When the loadClass() method returns a type, that type may or may not be linked. When you invoke the single parameter version of forName(), or invoke the three-parameter version and pass true in the initialize parameter, the returned type will definitely have been already linked and initialized.

Initialization is the reason, for example, that JDBC drivers are usually loaded with a call to forName(). Because the static initializers of each JDBC driver class registers the driver with a DriverManager, thereby making the driver available to the application, the driver class must be initialized, not just loaded. Were a driver class loaded but not initialized, the static initializers of the class would not be executed, the driver would not become registered with the DriverManager, and the driver would therefore not be available to the application. Loading a driver with forName() ensures that the class will be initialized, which ensures the driver will be available for use by the application after forName() returns.

Class loaders, on the other hand, can help you meet needs that forName() can't. If you have some custom way of loading types, such as by downloading them across a network, retrieving them from a database, extracting them from encrypted files, or even generating them on the fly, you'll need a class loader. One of the primary reasons to create a user-defined class loader is to customize the way in which a fully qualified type name is transformed into an array of bytes in the Java class file format that define the named type. Other reasons you may want to use a class loader rather than forName() involve security.

When the resolution of a constant pool entry requires loading a type, the virtual machine uses the same class loader that loaded the referencing type to load the referenced type. For example, imagine a Cat class refers via a symbolic reference in its constant pool to a type named Mouse. Assume Cat was loaded by a user-defined class loader. When the virtual machine resolves the reference to Mouse, it checks to see if Mouse has been loaded into the namespace to which Cat belongs. (It checks to see if the class loader that loaded Cat has previously loaded a type named Mouse.) If not, the virtual machine requests Mouse from the same class loader that loaded Cat. This is true even if a class named Mouse had previously been loaded into a different namespace. When a symbolic reference from a type loaded by the bootstrap class loader is resolved, the Java virtual machine uses the bootstrap class loader to load the referenced type. When a symbolic reference from a type loaded by a user- defined class loader is resolved, the Java virtual machine uses the same user-defined class loader to load the referenced type.

### parent-delegation model

Each user-defined class loader created in 1.2 is assigned a "parent" class loader when it is created. If the parent class loader is not passed explicitly to the constructor of the user-defined class loader, the system class loader is assigned to be the parent by default.

When a class that follows the parent delegation model loads a type, it first delegates to its parent -- it asks its parent to try and load the type. Its parent, in turn, asks its parent, which first asks its parent, and so on. The delegation continues all the way up to the end-point of the parent-delegation chain, which is usually the bootstrap class loader.

a class loader that is asked to load a type, but returns a type loaded by some other class loader, is called an initiating class loader of that type. The class loader that actually defines the type is called the defining class loader for the type.

Any class loader that is asked to load a type and is able to return a reference to the Class instance representing the type is an initiating loader of that type.

### loading constraints

If the referenced and referencing types do not have the same initiating loader, the virtual machine must make sure the types mentioned in the field and method descriptors are consistent across the namespaces. For example, imagine class Cat contains symbolic references to fields and methods declared in class Mouse, and that two different class loaders initiated the loading of Cat and Mouse. To preserve type safety in the presence of multiple class loaders, it is essential that the fully qualified type names mentioned in field and method descriptors contained in Cat refer to the same type data (in the method area) as those same names in class Mouse.

ach Java virtual machine must maintain an internal list of these constraints, each of which basically states that a name in one namespace must refer to the same type data in the method area as the same name in another namespace. As a Java virtual machine encounters symbolic references to fields and methods of referenced types whose loading wasn't initiated by the same class loader that initiated loading of the referencing type, the virtual machine may add constraints to the list. The virtual machine must check that all current loading constraints are met when it resolves symbolic references.

static final variables initialized to a compile-time constant are resolved at compile-time to a local copy of the constant value. This is true for constants of all the primitive types and of type java.lang.String.

### Direct References

Direct references to types, class variables, and class methods are likely native pointers into the method area.

Direct references to instance variables and instance methods are offsets. A direct reference to an instance variable is likely the offset from the start of the object's image to the location of the instance variable. A direct reference to an instance method is likely an offset into a method table.

The instance variable for Dog, the superclass, appears before the instance variables for CockerSpaniel, the subclass. The instance variables of CockerSpaniel appear in order of declaration: woofCount first, then wimperCount.

Assume that the particular Java virtual machine implementation that loads these types organizes its method tables by placing methods for superclasses into the method table before those for subclasses, and by placing pointers for each class in the order the methods appear in the class file. The exception to the ordering is that methods overridden by a subclass appear in the slot where the overridden method first appears in a superclass.

Note that only non-private instance methods appear in this method table. Class methods, which are invoked via the invokestatic instruction, need not appear here, because they are statically bound and don't need the extra indirection of a method table. Private methods and instance initialization methods need not appear here because they are invoked via the invokespecial instruction and are therefore statically bound. Only methods that are invoked with invokevirtual or invokeinterface appear in this method table.

Thus, whenever the Java virtual machine invokes a method from an interface reference, it must search the method table of the object's class until it finds the appropriate method. This is why invoking instance methods on interface references can be significantly slower than invoking instance methods on class references.

### Example

When the virtual machine starts, it attempts to invoke the main() method of Salutation. It quickly realizes, however, that it can't invoke main(). The invocation of a method declared in a class is an active use of that class, which is not allowed until the class is initialized. Thus, before the virtual machine can invoke main(), it must initialize Salutation. And before it can initialize Salutation, it must load and link Salutation. So, the virtual machine hands the fully qualified name of Salutation to the bootstrap class loader, which retrieves the binary form of the class, parses the binary data into internal data structures, and creates an instance of java.lang.Class.

. To start this process, the virtual machine looks into Salutation's type data at the super_class item, which is a seven. The virtual machine looks up entry seven in the constant pool, and finds a CONSTANT_Class_info entry that serves as a symbolic reference to class java.lang.Object.

Now that the Java virtual machine has loaded the Salutation class and loaded, linked and initialized all its superclasses, the virtual machine is ready to link Salutation. As the first step in the linking process, the virtual machine verifies the integrity of the binary representation of class Salutation.

The three literal Strings--hello, greeting, and salutation--are constants, not class variables. They do not occupy memory space as class variables in the method area. They don't receive default initial values. Because they are declared static and final, they appear as CONSTANT_String_info entries in Salutation's constant pool.

After the processes of verification and preparation have successfully completed, the class is ready for resolution.

The first instruction of the <clinit>() method, invokestatic #13, refers to constant pool entry 13, a CONSTANT_Methodref_info that represents a symbolic reference to the random() method of class java.lang.Math. You can see a graphical depiction of this symbolic reference in Figure 8-6. The Java virtual machine resolves this symbolic reference, which causes it to load, link, and initialize class java.lang.Math. It places a direct reference to the random() method into constant pool entry 13, marks the entry as resolved, and replaces the invokestatic opcode with invokestatic_quick.

When the virtual machine actually invokes the random() method, it will load, link, and initialize any types referenced symbolically from Math's constant pool and random()'s code. When this method returns, the virtual machine will push the returned double value onto the main() method's operand stack.

entries of type CONSTANT_Double_info and CONSTANT_Long_info occupy two slots in the constant pool. Thus, the CONSTANT_Double_info at index 14 is considered to occupy both indices 14 and 15.

Lastly, the virtual machine executes the return instruction, which signals to the virtual machine that the <clinit>() method, and hence the initialization of class Salutation, is complete. Now that class Salutation has been initialized, it is finally ready for use. The Java virtual machine invokes main(), and the program begins.

The virtual machine loads, links, and initializes java.io.PrintStream, and makes sure it has a println() method that is public, returns void, and takes a String argument. It marks the entry as resolved and puts a direct reference (an index into PrintStream's method table) into the data for the resolved constant pool entry. Lastly, the virtual machine replaces the invokevirtual opcode with invokevirtual_quick, and places the method table index and the number of arguments accepted by the method as operands to the invokevirtual_quick opcode.


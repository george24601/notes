```java

GreeterClassLoader gcl = new GreeterClassLoader(args[0]);

        for (int i = 1; i < args.length; ++i) {
            try {

                // Load the greeter specified on the command line
                Class c = gcl.loadClass(args[i]);

                // Instantiate it into a greeter object
                Object o = c.newInstance();

                // Cast the Object ref to the Greeter interface type
                // so greet() can be invoked on it
                Greeter greeter = (Greeter) o;

                // Greet the world in this greeter's special way
                greeter.greet();
            }
            catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

```

The basic contract of loadClass() is this: Given the fully qualified name of the type to find, the loadClass() method should in some way attempt to locate or produce an array of bytes, purportedly in the Java class file format, that define the type. If loadClass() is unable to locate or produce the bytes, it should throw ClassNotFoundException. Otherwise, loadClass() should pass the array of bytes to one of the defineClass() methods declared in class ClassLoader. By passing the byte array to defineClass(), loadClass() asks the virtual machine to import the type represented by the passed byte array into the namespace of this user-defined class loader. When loadClass() calls defineClass() in 1.2, it can also specify a protection domain with which the type data should be associated. When the loadClass() method of a class loader successfully loads a type, it returns a java.lang.Class object to represent the newly loaded type.

The concrete implementation of loadClass() from class java.lang.ClassLoader fullfills the loadClass() method's contract using these four basic steps:

(

If a classloader loads a class, if there is a parent classloader, ask the parent class loader load first, all the wait until bootstrap CL, if bootstrap CL gives ClassNotFoundException, CL task will be pushed down 


)

See if the requested type has already been loaded into this class loader's namespace (via findLoadedClass()). If so, return the Class instance for that already-loaded type.
Otherwise, delegate to this class loader's parent loader. If the parent returns a Class instance, return that same Class instance.
Otherwise, invoke findClass(), which should attempt to locate or produce an array of bytes, purportedly in the Java class file format, that define the desired type. If successful, findClass() should pass those bytes to defineClass(), which will attempt to import the type and return a Class instance. If findClass() returns a Classinstance, loadClass() returns that same Class instance.
Otherwise, findClass() completes abruptly with some exception, and loadClass() completes abruptly with the same exception.

The basic contract of the findClass() method is this: findClass() accepts the fully qualified name of a desired type as its only parameter. findClass() first attempts to locate or produce an array of bytes, purportedly in the Java class file format, that define the type of the requested name. If findClass() is unable to locate or produce the array of bytes, it completes abruptly with ClassNotFoundException. Otherwise, findClass() invokes defineClass(), passing in the requested name, the array of bytes and, optionally, a ProtectionDomain object with which the type should be associated. If defineClass() returns a Class instance for the type, findClass() simply returns that same Class instance to its caller. Otherwise, defineClass() completes abruptly with some exception, and findClass() completes abruptly with the same exception.

### Type Safety with classloaders

If one class loader delegates to another class loader, and the delegated-to class loader defines the type, both class loaders are marked as initiating loaders for that type. The type defined by the delegated-to class loader is shared among all the namespaces of the initiating loaders of the type.

Thus, to uniquely identify a type loaded into a Java virtual machine requires the fully qualified name and the defining class loader.

### classloader

Types:
* Bootstrap ClassLoader: load JAVA_HOMElib and bootclasspath
* Extension ClassLoader: load JAVA_HOMElibext and java.ext.dirs
* Application ClassLoader: classpath in the normal sense 
* User ClassLoader: inherits form Application ClassLoader

the Java virtual machine contains two kinds of class loaders: a bootstrap class loader and user-defined class loaders. The bootstrap class loader is a part of the virtual machine implementation, and user-defined class loaders are part of the running Java application. Classes loaded by different class loaders are placed into separate name spaces inside the Java virtual machine.

user-defined class loaders are regular Java objects whose class descends from java.lang.ClassLoader. The methods of class ClassLoader allow Java applications to access the virtual machine's class loading machinery. Also, for every type a Java virtual machine loads, it creates an instance of class java.lang.Class to represent that type. Like all objects, user-defined class loaders and instances of class Class reside on the heap. Data for loaded types resides in the method area.

user-defined class loader that is created automatically when the virtual machine starts up

The two overloaded defineClass() methods accept a byte array, data[], as input. Starting at position offset in the array and continuing for length bytes, class ClassLoader expects binary data conforming to the Java class file format--binary data that represents a new type for the running application -- with the fully qualified name specified in name. The type is assigned to either a default protection domain, if the first version of defineClass() is used, or to the protection domain object referenced by the protectionDomain parameter. Every Java virtual machine implementation must make sure the defineClass() method of class ClassLoader can cause a new type to be imported into the method area.

The findSystemClass() method accepts a String representing a fully qualified name of a type. When a user-defined class loader invokes this method in version 1.0 and 1.1, it is requesting that the virtual machine attempt to load the named type via its bootstrap class loader. If the bootstrap class loader has already loaded or successfully loads the type, it returns a reference to the Class object representing the type. If it can't locate the binary data for the type, it throws ClassNotFoundException. In version 1.2, the findSystemClass() method attempts to load the requested type from the system class loader. Every Java virtual machine implementation must make sure the findSystemClass() method can invoke the bootstrap (if version 1.0 or 1.1) or system (if version 1.2 or later) class loader in this way.

The resolveClass() method accepts a reference to a Class instance. This method causes the type represented by the Class instance to be linked (if it hasn't already been linked). The defineClass() method, described previous, only takes care of loading. (See the previous section, "Loading, Linking, and Initialization" for definitions of these terms.) When defineClass() returns a Class instance, the binary file for the type has definitely been located and imported into the method area, but not necessarily linked and initialized. Java virtual machine implementations make sure the resolveClass() method of class ClassLoader can cause the class loader subsystem to perform linking.



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

See if the requested type has already been loaded into this class loader's namespace (via findLoadedClass()). If so, return the Class instance for that already-loaded type.
Otherwise, delegate to this class loader's parent loader. If the parent returns a Class instance, return that same Class instance.
Otherwise, invoke findClass(), which should attempt to locate or produce an array of bytes, purportedly in the Java class file format, that define the desired type. If successful, findClass() should pass those bytes to defineClass(), which will attempt to import the type and return a Class instance. If findClass() returns a Classinstance, loadClass() returns that same Class instance.
Otherwise, findClass() completes abruptly with some exception, and loadClass() completes abruptly with the same exception.

The basic contract of the findClass() method is this: findClass() accepts the fully qualified name of a desired type as its only parameter. findClass() first attempts to locate or produce an array of bytes, purportedly in the Java class file format, that define the type of the requested name. If findClass() is unable to locate or produce the array of bytes, it completes abruptly with ClassNotFoundException. Otherwise, findClass() invokes defineClass(), passing in the requested name, the array of bytes and, optionally, a ProtectionDomain object with which the type should be associated. If defineClass() returns a Class instance for the type, findClass() simply returns that same Class instance to its caller. Otherwise, defineClass() completes abruptly with some exception, and findClass() completes abruptly with the same exception.

### Type Safety with classloaders

If one class loader delegates to another class loader, and the delegated-to class loader defines the type, both class loaders are marked as initiating loaders for that type. The type defined by the delegated-to class loader is shared among all the namespaces of the initiating loaders of the type.

Thus, to uniquely identify a type loaded into a Java virtual machine requires the fully qualified name and the defining class loader.

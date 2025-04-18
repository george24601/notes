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



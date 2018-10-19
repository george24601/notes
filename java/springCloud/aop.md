The Java compiler conditionally stores annotation metadata in the class files, if the annotation has a RetentionPolicy of CLASS or RUNTIME. Later, the JVM or other programs can look for the metadata to determine how to interact with the program elements or change their behavior.

The AnnotatedElement interface provides access to annotations having RUNTIME retention. This access is provided by the getAnnotation, getAnnotations, and isAnnotationPresent methods. Because annotation types are compiled and stored in byte code files just like classes, the annotations returned by these methods can be queried just like any regular Java object.

* Aspect: advice + introduction.  Transaction management is a good example of a crosscutting concern. In Spring AOP, aspects are implemented using regular classes (the schema-based approach) or regular classes annotated with the @Aspect annotation (@AspectJ style).
* Join point: A point during the execution of a program, such as the execution of a method or the handling of an exception. In Spring AOP, a join point always represents a method execution. Join point information is available in advice bodies by declaring a parameter of type org.aspectj.lang.JoinPoint.
* Advice: Action taken by an aspect at a particular join point,i.e., the actual code, think it as the method of an apsect. Different types of advice include "around," "before" and "after" advice. Many AOP frameworks, including Spring, model an advice as an interceptor, maintaining a chain of interceptors "around" the join point.
* Pointcut: Mapping of advice to join point. Advice is associated with a pointcut expression and runs at any join point matched by the pointcut (for example, the execution of a method with a certain name). The concept of join points as matched by pointcut expressions is central to AOP: Spring uses the AspectJ pointcut language by default. Pick out join points and values at those points
* Introduction: (Also known as an inter-type declaration). Declaring additional methods or fields on behalf of a type. Spring AOP allows us to introduce new interfaces (and a corresponding implementation) to any proxied object. For example, you could use an introduction to make a bean implement an IsModified interface, to simplify caching.
* Target object: Object being advised by one or more aspects. Also referred to as the advised object. Since Spring AOP is implemented using runtime proxies, this object will always be a proxied object.
* Weaving: Linking aspects with other application types or objects to create an advised object. This can be done at compile time (using the AspectJ compiler, for example), load time, or at runtime. Spring AOP, like other pure Java AOP frameworks, performs weaving at runtime.

Runtime weaving: class ->(via bean reference) Proxy class (advice injected here to the proxy class)  ->(via reference) class

Spring’s AOP: Offers @AspectJ declarations: proxy classes, annotations for advice and pointcut declaration

In section 3.3, we showed that Spring AOP is based on proxy patterns. Because of this, it needs to subclass the targeted Java class and apply cross-cutting concerns accordingly.

But it comes with a limitation. We cannot apply cross-cutting concerns (or aspects) across classes that are “final” because they cannot be overridden and thus it would result in a runtime exception.

The same applies for static and final methods. Spring aspects cannot be applied to them because they cannot be overridden. Hence Spring AOP because of these limitations, only supports method execution join points.

It’s also worth noting that in Spring AOP, aspects aren’t applied to the method called within the same class.

That’s obviously because when we call a method within the same class, then we aren’t calling the method of the proxy that Spring AOP supplies. If we need this functionality, then we do have to define a separate method in different beans, or use AspectJ.

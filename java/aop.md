@Override annotation. It instructs the compiler to check parent classes for matching methods. In this case, an error is generated because the gettype() method of class Cat doesn't in fact override getType() of class Animal like is desired. If the @Override annotation was absent, a new method of name gettype() would be created in class Cat.

Rather, the class object is passed to the JPA implementation at run-time, which then extracts the annotations to generate an object-relational mapping.

The Java compiler conditionally stores annotation metadata in the class files, if the annotation has a RetentionPolicy of CLASS or RUNTIME. Later, the JVM or other programs can look for the metadata to determine how to interact with the program elements or change their behavior.

In addition to processing an annotation using an annotation processor, a Java programmer can write their own code that uses reflections to process the annotation.

The AnnotatedElement interface provides access to annotations having RUNTIME retention. This access is provided by the getAnnotation, getAnnotations, and isAnnotationPresent methods. Because annotation types are compiled and stored in byte code files just like classes, the annotations returned by these methods can be queried just like any regular Java object.

AOP defines aspects (classes/methods) that abstract these cross-cutting concerns with the use of join points, advice, and pointcuts.

a. Advice - The actual code (method of an aspect, perhaps?) implementing the cross-cutting concern (i.e. doing the actual logging, validating, authenticating, etc.)

b. Join Point - An event that is triggered in non-AOP code that causes a particular aspect's advice to be executed ("woven" into the non-AOP code)

c. Pointcut - Essentially, a mapping of join points (triggering events) to advice execution

As Spring AOP implementation is non-intrusive and uses the Spring mechanisms you need to add the @Component annotation and create the object using Spring context rather than plain new.

@Deprecated @Deprecated annotation indicates that the marked element is deprecated and should no longer be used. The compiler generates a warning whenever a program uses a method, class, or field with the @Deprecated annotation. When an element is deprecated, it should also be documented using the Javadoc @deprecated tag, as shown in the following example.


You can specify which Java elements your custom annotation can be used to annotate. You do so by annotating your annotation definition with the @Target annotation.

The ElementType class contains the following possible targets:

```
ElementType.CONSTRUCTOR  
ElementType.FIELD  
ElementType.LOCAL_VARIABLE  
ElementType.METHOD  
ElementType.PACKAGE  
ElementType.PARAMETER  
ElementType.TYPE
```

Aspect: A modularization of a concern that cuts across multiple objects. Transaction management is a good example of a crosscutting concern. In Spring AOP, aspects are implemented using regular classes (the schema-based approach) or regular classes annotated with the @Aspect annotation (@AspectJ style).

Join point: A point during the execution of a program, such as the execution of a method or the handling of an exception. In Spring AOP, a join point always represents a method execution. Join point information is available in advice bodies by declaring a parameter of type org.aspectj.lang.JoinPoint.

Advice: Action taken by an aspect at a particular join point. Different types of advice include "around," "before" and "after" advice. Many AOP frameworks, including Spring, model an advice as an interceptor, maintaining a chain of interceptors "around" the join point.

Pointcut: A predicate that matches join points. Advice is associated with a pointcut expression and runs at any join point matched by the pointcut (for example, the execution of a method with a certain name). The concept of join points as matched by pointcut expressions is central to AOP: Spring uses the AspectJ pointcut language by default.

Introduction: (Also known as an inter-type declaration). Declaring additional methods or fields on behalf of a type. Spring AOP allows us to introduce new interfaces (and a corresponding implementation) to any proxied object. For example, you could use an introduction to make a bean implement an IsModified interface, to simplify caching.

Target object: Object being advised by one or more aspects. Also referred to as the advised object. Since Spring AOP is implemented using runtime proxies, this object will always be a proxied object.

Weaving: Linking aspects with other application types or objects to create an advised object. This can be done at compile time (using the AspectJ compiler, for example), load time, or at runtime. Spring AOP, like other pure Java AOP frameworks, performs weaving at runtime.

#Types of advice

Before: Advice that executes before a join point, but which does not have the ability to prevent execution flow proceeding to the join point (unless it throws an exception).

AfterReturning: Advice to be executed after a join point completes normally: for example, if a method returns without throwing an exception. AfterThrowing: Advice to be executed if a method exits by throwing an exception.

After (finally): Advice to be executed regardless of the means by which a join point exits (normal or exceptional return).

Around: Advice that surrounds a join point such as a method invocation. This is the most powerful kind of advice. Around advice can perform custom behavior before and after the method invocation. It is also responsible for choosing whether to proceed to the join point or to shortcut the advised method execution by returning its own return value or throwing an exception.

#Spring AOP

Import annotation?

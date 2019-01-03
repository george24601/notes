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

Hence Spring AOP because of these limitations, only supports method execution join points.It’s also worth noting that in Spring AOP, aspects aren’t applied to the method called within the same class.

### Dynamic proxy

Spring AOP will create an aop object in memmory. Two ways: JDK and CGLib

* JDK dynamic proxy based on reflection, requires InvocationHandler and Proxy type
* CGLib, will create a subclass on run time

CGLib- no concrete class implementation, just define important concept interface

MethodInterceptor < Interceptor < Advice, has a invoke(MethodInvocation) => MethodInvocation.proceed=> Method.invoke

Proxy is done by PostProcessor calssed by postProcessBefore(After)Initialization

* Find all pointcut bean
* construct AdvisorSupport
* Get proxy via proxyFactory


### Async

The @EnableAsync annotation switches on Spring’s ability to run @Async methods in a background thread pool. This class also customizes the used Executor. By default, a SimpleAsyncTaskExecutor is used.

Because of the dynamic proxy nature: 
* it must be applied to public methods only
* self-invocation – calling the async method from within the same class – won’t work

@Async can also be applied to a method with return type – by wrapping the actual return in the Future

Unlike methods annotated with @Scheduled, the methods annotated with @Async can take arguments. They will be invoked in the normal way by callers at runtime rather than by a scheduled task.

### Component

This annotation is used on classes to indicate a Spring component. The @Component annotation marks the Java class as a bean or component so that the component-scanning mechanism of Spring can add it into the application context.

### Service

This annotation is used on a class. @Service marks a Java class that performs some service, such as executing business logic, performing calculations, and calling external APIs. This annotation is a specialized form of the@Component annotation intended to be used in the service layer. better meaning, more specific than component

### Repository
This annotation is used on Java classes that directly access the database. The @Repository annotation works as a marker for any class that fulfills the role of repository or Data Access Object.

This annotation has an automatic translation feature. For example, when an exception occurs in the @Repository, there is a handler for that exception and there is no need to add a try-catch block.

### EnableAutoConfiguration

This annotation is usually placed on the main application class. The @EnableAutoConfiguration annotation implicitly defines a base “search package”. This annotation tells Spring Boot to start adding beans based on classpath settings, other beans, and various property settings.

### SpringBootApplication

. The one thing that the@SpringBootApplication does is a component scan. But it will scan only its sub-packages. As an example, if you put the class annotated with @SpringBootApplication in com.example, then @SpringBootApplication will scan all its sub-packages, such as com.example.a, com.example.b, and com.example.a.x.

The @SpringBootApplication is a convenient annotation that adds all the following:

@Configuration
@EnableAutoConfiguration
@ComponentScan

### EnableCircuitBreaker

The circuit breaker pattern can allow a microservice continue working when a related service fails, preventing the failure from cascading. This also gives the failed service a time to recover.

The class annotated with @EnableCircuitBreaker will monitor, open, and close the circuit breaker.

### HystrixCommand

This annotation is used at the method level. Netflix’s Hystrix library provides the implementation of a Circuit Breaker pattern. When you apply the circuit breaker to a method, Hystrix watches for the failures of the method. Once failures build up to a threshold, Hystrix opens the circuit so that the subsequent calls also fail. Now Hystrix redirects calls to the method, and they are passed to the specified fallback methods.

Hystrix looks for any method annotated with the @HystrixCommand annotation and wraps it into a proxy connected to a circuit breaker so that Hystrix can monitor it.

### Transactional
This annotation is placed before an interface definition, a method on an interface, a class definition, or a public method on a class. The mere presence of @Transactional is not enough to activate the transactional behavior. The @Transactional is simply metadata that can be consumed by some runtime infrastructure. This infrastructure uses the metadata to configure the appropriate beans with transactional behavior.

Cache-Based Annotations???

### Scheduled

This annotation is a method-level annotation. The @Scheduled annotation is used on methods along with the trigger metadata. A method with @Scheduled should have a void return type and should not accept any parameters.

### Override 

It instructs the compiler to check parent classes for matching methods. In this case, an error is generated because the gettype() method of class Cat doesn't in fact override getType() of class Animal like is desired. If the @Override annotation was absent, a new method of name gettype() would be created in class Cat.

### Deprecated

indicates that the marked element is deprecated and should no longer be used. The compiler generates a warning whenever a program uses a method, class, or field with the @Deprecated annotation. When an element is deprecated, it should also be documented using the Javadoc @deprecated tag, as shown in the following example.



Try to avoid field injection and setter injection, prefer constructor injection

How do you go about testing classes using field injection? Chances are you’re somewhere along the path of memorizing the unintuitive Mockito idiom for doing this

```
@RunWith(MockitoJUnitRunner.class)
public class MyBeanTest {
    @Mock
    private AnotherBean anotherBean;
    @InjectMocks
    private MyBean target;
    //Tests...
}
```

Classes Using Field Injection Are Non-Final, but Are Prone to Circular Dependencies. This problem can be resolved by either making one of the dependencies not required (allow the field to be null with @Autowired(required = false)) or lazy (set the field after resolving beans that depend on this bean with @Lazy).

since final fields can be initialized in the constructor, our dependencies can be immutabl

```
public class MyBeanTest {
    private AnotherBean anotherBean = Mockito.mock(AnotherBean.class);
    private MyBean target = new MyBean(anotherBean);
    //Tests...
}
```


### Bean/Configuration

This annotation is used on classes that define beans. @Configuration is an analog for an XML configuration file – it is configuration using Java classes. A Java class annotated with @Configuration is a configuration by itself and will have methods to instantiate and configure the dependencies.

The @Bean annotation works with @Configuration to create Spring beans. As mentioned earlier, @Configuration will have methods to instantiate and configure dependencies. Such methods will be annotated with @Bean. The method annotated with this annotation works as the bean ID, and it creates and returns the actual bean.

EnableAutoConfiguration: scan ClassPath and load beans

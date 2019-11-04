The Java compiler conditionally stores annotation metadata in the class files, if the annotation has a RetentionPolicy of CLASS or RUNTIME. Later, the JVM or other programs can look for the metadata to determine how to interact with the program elements or change their behavior.

The AnnotatedElement interface provides access to annotations having RUNTIME retention. This access is provided by the getAnnotation, getAnnotations, and isAnnotationPresent methods. Because annotation types are compiled and stored in byte code files just like classes, the annotations returned by these methods can be queried just like any regular Java object.

* Pointcut: Mapping of advice to join point. Advice is associated with a pointcut expression and runs at any join point matched by the pointcut (for example, the execution of a method with a certain name). The concept of join points as matched by pointcut expressions is central to AOP: Spring uses the AspectJ pointcut language by default. Pick out join points and values at those points
* Target object: Object being advised by one or more aspects. Also referred to as the advised object. Since Spring AOP is implemented using runtime proxies, this object will always be a proxied object.
* Weaving: Linking aspects with other application types or objects to create an advised object. This can be done at compile time (using the AspectJ compiler, for example), load time, or at runtime. Spring AOP, like other pure Java AOP frameworks, performs weaving at runtime.

Runtime weaving: class ->(via bean reference) Proxy class (advice injected here to the proxy class)  ->(via reference) class

MethodInterceptor < Interceptor < Advice, has a invoke(MethodInvocation) => MethodInvocation.proceed=> Method.invoke

Proxy is done by PostProcessor calssed by postProcessBefore(After)Initialization

* Find all pointcut bean
* construct AdvisorSupport
* Get proxy via proxyFactory


@Async can also be applied to a method with return type – by wrapping the actual return in the Future

### Component

This annotation is used on classes to indicate a Spring component. The @Component annotation marks the Java class as a bean or component so that the component-scanning mechanism of Spring can add it into the application context.

### Repository
This annotation has an automatic translation feature. For example, when an exception occurs in the @Repository, there is a handler for that exception and there is no need to add a try-catch block.

### EnableAutoConfiguration

This annotation is usually placed on the main application class. The @EnableAutoConfiguration annotation implicitly defines a base “search package”. This annotation tells Spring Boot to start adding beans based on classpath settings, other beans, and various property settings.

### SpringBootApplication

. The one thing that the@SpringBootApplication does is a component scan. But it will scan only its sub-packages. As an example, if you put the class annotated with @SpringBootApplication in com.example, then @SpringBootApplication will scan all its sub-packages, such as com.example.a, com.example.b, and com.example.a.x.

The @SpringBootApplication is a convenient annotation that adds all the following:

@Configuration
@EnableAutoConfiguration
@ComponentScan


### Override 

It instructs the compiler to check parent classes for matching methods. In this case, an error is generated because the gettype() method of class Cat doesn't in fact override getType() of class Animal like is desired. If the @Override annotation was absent, a new method of name gettype() would be created in class Cat.

### Deprecated

indicates that the marked element is deprecated and should no longer be used. The compiler generates a warning whenever a program uses a method, class, or field with the @Deprecated annotation. When an element is deprecated, it should also be documented using the Javadoc @deprecated tag, as shown in the following example.


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


@Request: every http req will create a ne bean, alive during the rquest
@Session: every http req will create a new bean, alive usirng th ession

Excepiton handling: @ControllerAdvice + @ExceptionHandler, and use MockMvc to simulate Http requests + ResponseStatusException

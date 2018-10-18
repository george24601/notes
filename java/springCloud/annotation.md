### Configuration

This annotation is used on classes that define beans. @Configuration is an analog for an XML configuration file – it is configuration using Java classes. A Java class annotated with @Configuration is a configuration by itself and will have methods to instantiate and configure the dependencies.

Spring Configuration annotation indicates that the class has @Bean definition methods. So Spring container can process the class and generate Spring Beans to be used in the application.

### Async

The @EnableAsync annotation switches on Spring’s ability to run @Async methods in a background thread pool. This class also customizes the used Executor.

By default, a SimpleAsyncTaskExecutor is used.

@Async has two limitations:

it must be applied to public methods only
self-invocation – calling the async method from within the same class – won’t work

@Async can also be applied to a method with return type – by wrapping the actual return in the Future

Unlike methods annotated with @Scheduled, the methods annotated with @Async can take arguments. They will be invoked in the normal way by callers at runtime rather than by a scheduled task.

### Bean

The @Bean annotation works with @Configuration to create Spring beans. As mentioned earlier, @Configuration will have methods to instantiate and configure dependencies. Such methods will be annotated with @Bean. The method annotated with this annotation works as the bean ID, and it creates and returns the actual bean.

### Component

This annotation is used on classes to indicate a Spring component. The @Component annotation marks the Java class as a bean or component so that the component-scanning mechanism of Spring can add it into the application context.

### Service

This annotation is used on a class. @Service marks a Java class that performs some service, such as executing business logic, performing calculations, and calling external APIs. This annotation is a specialized form of the@Component annotation intended to be used in the service layer.

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

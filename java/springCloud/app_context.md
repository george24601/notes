The ApplicationContext is the central interface within a Spring application for providing configuration information to the application. It is read-only at run time, but can be reloaded if necessary and supported by the application.

The ApplicationContext provides:

Bean factory methods for accessing application components.
The ability to load file resources in a generic fashion.
The ability to publish events to registered listeners.
The ability to resolve messages to support internationalization.
Inheritance from a parent context.

In the code above, there are two arguments to the bean definition: RedisConnectionFactory and MessageListenerAdapter. The method expresses its needs and Spring's DI container will supply them assuming they are available. While it's possible to fetch these beans directly the an instance of ApplicationContext, such a solution leans too heavily on container APIs and is not necessary.

```java
@Configuration
@EnableAutoConfiguration
@ComponentScan
public class Application extends SpringBootServletInitializer {

    @SuppressWarnings("resource")
    public static void main(final String[] args) {
        ConfigurableApplicationContext context = SpringApplication.run(Application.class, args);

        context.getBean(Table.class).fillWithTestdata(); // <-- here
    }
}

//alternatively
@EventListener(ApplicationReadyEvent.class)
public void doSomethingAfterStartup() {
    System.out.println("hello world, I have just started up");
}

//yet another option


@Component
public class ApplicationStartup 
implements ApplicationListener<ApplicationReadyEvent> {

  /**
   * This event is executed as late as conceivably possible to indicate that 
   * the application is ready to service requests.
   */
  @Override
  public void onApplicationEvent(final ApplicationReadyEvent event) {

    // here your code ...

    return;
  }
}
//As an alternative, you can do this using @EventListenerannotation on a Bean method, passing as argument the class event you want to hook to
```

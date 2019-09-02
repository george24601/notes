ApplicationContext:
* Central interface to provide configuration for an application. This is read-only while the application is running, but may be reloaded if the implementation supports this.
* The root interface for accessing a Spring bean container. This is the basic client view of a bean container.

By container they refer to the core spring Inversion of Control container. The container provides a way to initialize/bootstrap your application (loading the configuration in xml files or annotations), through use of reflection, and to manage the lifecycle of Java objects, which are called beans or managed objects.

ApplicationContext (as an interface, and by the direct implementation flavours) is the mean of implementing this IoC container, as opposed to the BeanFactory, which is now (a sparsely used and) more direct way of managing beans, which by the way provides the base implementation features for the ApplicationContext.

A container manages the life cycle of an object. Tomcat is a an example of a container. Just like Spring container manages the app via ApplicationContext a J2EE container Tomcat manages the app via web.xml


### How BeanFactory works

1. getBean in beanDefinitionMap
2. createBeanInstance. 
  * By reflection, create new instance object by BeanDefinition's class object, and get a new bean object
  * doCreatBean - assign the new bean object to Bean definition, and inject properties in BeanDefinition to Bean  
3. initializeBean - postProcessBeforeINitialiization, and postProcessAfterInitialization
4. uses lazy loading


### ApplicationContext

1. Inherits from BeanFactory, but no methods
2. AbstractAC. First accepts BeanFactory
  * loadBeanDefintions. Read BeanDefinition and write to AC's BeanFactory
  * registerBeanPostProcessors. Find BeanPostProcessor from BF, and put them in beganPostProcessors 
  * onRefresh - init all beans

The ApplicationContext is the central interface within a Spring application for providing configuration information to the application. It is read-only at run time, but can be reloaded if necessary and supported by the application. AC targetes at Spring user, whereas BeanFactory(BF) targets more toward Spring developer, which defines how Bean is inited.

* Bean factory methods for accessing application components.
* The ability to load file resources in a generic fashion.
* The ability to publish events to registered listeners.
* The ability to resolve messages to support internationalization.
* Inheritance from a parent context.

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

  @Override
  public void onApplicationEvent(final ApplicationReadyEvent event) {

    // here your code ...

    return;
  }
}
//As an alternative, you can do this using @EventListenerannotation on a Bean method, passing as argument the class event you want to hook to
```

In a Spring-based application, your application objects will live within the Spring container. As illustrated in figure 2.1, the container will create the objects, wire them together, configure them, and manage their complete lifecycle from cradle to grave (or new to finalize() as the case may be).

Spring comes with several container implementations that can be categorized into two distinct types. Bean factories (defined by the org.springframework.beans.factory.BeanFactory interface) are the simplest of containers, providing basic support for DI. Application contexts (defined by the org.springframework.context.ApplicationContext interface) build on the notion of a bean factory by providing application framework services, such as the ability to resolve textual messages from a properties file and the ability to publish application events to interested event listeners.

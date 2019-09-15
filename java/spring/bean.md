How is spring singleton implemented?

This annotation is used on classes that define beans. @Configuration is an analog for an XML configuration file – it is configuration using Java classes. A Java class annotated with @Configuration is a configuration by itself and will have methods to instantiate and configure the dependencies.

The @Bean annotation works with @Configuration to create Spring beans. As mentioned earlier, @Configuration will have methods to instantiate and configure dependencies. Such methods will be annotated with @Bean. The method annotated with this annotation works as the bean ID, and it creates and returns the actual bean.

EnableAutoConfiguration: scan ClassPath and load beans

all spring beans are singleton by default, so consider using ThreadLocal

Spring bean lifecycle?

@Component vs @Bean: on class vs on method. Note @C is the default annotation if @Repo or @Service is not a good fit
@C uses classpath to scan and assemble into the conainer (can also use COmponoentScan).

### @Configuration
bean scan piroary:
1. bean inside configuration
2. ComponentScan
3. ImportSelector
4. Import
5. Bean inside class
Get all unprocessed configs -> find all types needs to be registered -> register beans -> repeat until the # of beans in the container remains constant

Check configurationClassPostProcessor

BeanFactoryPostProcessor vs BeanDefinitionPostProcessor

spring decides to init all singleton bean on start to discovery problem early, instead of at the first run time

@PostConstrauct and @PreDesotry for bean init and destroy

### How is circular dependency avoided?

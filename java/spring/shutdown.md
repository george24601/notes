SpringApplication implicitly registers a shutdown hook with the JVM to ensure that ApplicationContext is closed gracefully on exit. That will also call all bean methods annotated with @PreDestroy. That means we don't have to explicitly use the  registerShutdownHook() method of a ConfigurableApplicationContext in a boot application, like we have to do in spring core application.



when we apply a circuit breaker to a method, Hystrix watches for failing calls to that method, and if failures build up to a threshold, Hystrix opens the circuit so that subsequent calls automatically fail. While the circuit is open, Hystrix redirects calls to the method, and they’re passed on to our specified fallback method.

Spring Cloud Netflix Hystrix looks for any method annotated with the @HystrixCommand annotation, and wraps that method in a proxy connected to a circuit breaker so that Hystrix can monitor it. This currently only works in a class marked with @Component or @Service

Circuit breakers are a valuable place for monitoring. Any change in breaker state should be logged and breakers should reveal details of their state for deeper monitoring. Breaker behavior is often a good source of warnings about deeper troubles in the environment. Operations staff should be able to trip or reset breakers.

The state of the connected circuit breakers are also exposed in the /health endpoint of the calling application

To enable the Hystrix metrics stream, include a dependency on spring-boot-starter-actuator and set management.endpoints.web.exposure.include: hystrix.stream. Doing so exposes the /actuator/hystrix.stream as a management endpoint

Wrap your method in a Cmd type, note that HystrixCommand maintains a threadpool, which will run Cmd's run()



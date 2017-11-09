The Spring Boot gradle plugin provides many convenient features:

It collects all the jars on the classpath and builds a single, runnable "über-jar", which makes it more convenient to execute and transport your service.
It searches for the public static void main() method to flag as a runnable class.
It provides a built-in dependency resolver that sets the version number to match Spring Boot dependencies. You can override any version you wish, but it will default to Boot’s chosen set of versions.

We specify routes using properties under zuul.routes. Each of our microservices can have an entry under zuul.routes.NAME, where NAME is the application name (as stored in the spring.application.name property).

In this sample because we set zuul.routes.books.url, so Zuul will proxy requests to /books to this URL.

Spring Cloud Netflix Zuul uses Netflix’s Ribbon to perform client-side load balancing, and by default, Ribbon would use Netflix Eureka for service discovery. For this simple example, we’re skipping service discovery, so we’ve set ribbon.eureka.enabled to false. Since Ribbon now can’t use Eureka to look up services, we must specify a url for the Book service.

 Spring Cloud Netflix picks up, as a filter, any @Bean which extends com.netflix.zuul.ZuulFilter and is available in the application context. Create a new directory, 

The default application name (service ID), virtual host and non-secure port, taken from the Environment, are ${spring.application.name}, ${spring.application.name} and ${server.port} respectively.

The configuration property zuul.max.host.connections has been replaced by two new properties, zuul.host.maxTotalConnections and zuul.host.maxPerRouteConnections which default to 200 and 20 respectively.

To enable it, annotate a Spring Boot main class with @EnableZuulProxy, and this forwards local calls to the appropriate service. By convention, a service with the ID "users", will receive requests from the proxy located at /users (with the prefix stripped). The proxy uses Ribbon to locate an instance to forward to via discovery, and all requests are executed in a hystrix command, so failures will show up in Hystrix metrics, and once the circuit is open the proxy will not try to contact the service.

the Zuul starter does not include a discovery client, so for routes based on service IDs you need to provide one of those on the classpath as well (e.g. Eureka is one choice).

”
default mapping rule for zuul?

It’s OK to share headers between services in the same system, but you probably don’t want sensitive headers leaking downstream into external servers. You can specify a list of ignored headers as part of the route configuration. Cookies play a special role because they have well-defined semantics in browsers, and they are always to be treated as sensitive. If the consumer of your proxy is a browser, then cookies for downstream services also cause problems for the user because they all get jumbled up 


Strangulation Patterns and Local Forwards
---------

Q: 
1. what to do when I add a new service? - rolling restart?
2. ELB on zuul instances?

```
zuul:
  routes:
    users: /myusers/**
```

This means that http calls to "/myusers" get forwarded to the "users" service (for example "/myusers/101" is forwarded to "/101").

```
zuul:
  routes:
    users:
      path: /myusers/**
      serviceId: users_service
```
This means that http calls to "/myusers" get forwarded to the "users_service" service. The route has to have a "path" which can be specified as an ant-style pattern, so "/myusers/*" only matches one level, but "/myusers/**" matches hierarchically.


```
eureka:
  client:
    serviceUrl:
      defaultZone: http://localhost:8761/eureka/
server:
  port: 8769
spring:
  application:
    name: service-zuul
zuul:
  routes:
    api-a:
      path: /api-a/**
      serviceId: service-ribbon
    api-b:
      path: /api-b/**
      serviceId: service-feign
```

The Spring Boot gradle plugin provides many convenient features:

It collects all the jars on the classpath and builds a single, runnable "über-jar", which makes it more convenient to execute and transport your service.
It searches for the public static void main() method to flag as a runnable class.
It provides a built-in dependency resolver that sets the version number to match Spring Boot dependencies. You can override any version you wish, but it will default to Boot’s chosen set of versions.

We specify routes using properties under zuul.routes. Each of our microservices can have an entry under zuul.routes.NAME, where NAME is the application name (as stored in the spring.application.name property).

In this sample because we set zuul.routes.books.url, so Zuul will proxy requests to /books to this URL.

 Spring Cloud Netflix picks up, as a filter, any @Bean which extends com.netflix.zuul.ZuulFilter and is available in the application context. Create a new directory, 

The default application name (service ID), virtual host and non-secure port, taken from the Environment, are ${spring.application.name}, ${spring.application.name} and ${server.port} respectively.

Auth
----------
It’s OK to share headers between services in the same system, but you probably don’t want sensitive headers leaking downstream into external servers. You can specify a list of ignored headers as part of the route configuration. Cookies play a special role because they have well-defined semantics in browsers, and they are always to be treated as sensitive. If the consumer of your proxy is a browser, then cookies for downstream services also cause problems for the user because they all get jumbled up 

Other than that, any cookies that get set by downstream services are likely to be not very useful to the caller, so it is recommended that you make (at least) "Set-Cookie" and "Cookie" into sensitive headers for routes that are not part of your domain. Even for routes that are part of your domain, try to think carefully about what it means before allowing cookies to flow between them and the proxy.

If Zuul is fronting a web application then there may be a need to re-write the Location header when the web application redirects through a http status code of 3XX, otherwise the browser will end up redirecting to the web application’s url instead of the Zuul url.

Zuul is implemented as a Servlet.

To pass information between filters, Zuul uses a RequestContext. Its data is held in a ThreadLocal specific to each request. Information about where to route requests, errors and the actual HttpServletRequest and HttpServletResponse are stored there
The RequestContext extends ConcurrentHashMap, so anything can be stored in the context. FilterConstants contains the keys that are used by the filters installed by Spring Cloud Netflix

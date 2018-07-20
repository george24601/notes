We specify routes using properties under zuul.routes. Each of our microservices can have an entry under zuul.routes.NAME, where NAME is the application name (as stored in the spring.application.name property).

In this sample because we set zuul.routes.books.url, so Zuul will proxy requests to /books to this URL.

 Spring Cloud Netflix picks up, as a filter, any @Bean which extends com.netflix.zuul.ZuulFilter and is available in the application context.

It’s OK to share headers between services in the same system, but you probably don’t want sensitive headers leaking downstream into external servers. You can specify a list of ignored headers as part of the route configuration. Cookies play a special role because they have well-defined semantics in browsers, and they are always to be treated as sensitive. If the consumer of your proxy is a browser, then cookies for downstream services also cause problems for the user because they all get jumbled up 

Other than that, any cookies that get set by downstream services are likely to be not very useful to the caller, so it is recommended that you make (at least) "Set-Cookie" and "Cookie" into sensitive headers for routes that are not part of your domain. Even for routes that are part of your domain, try to think carefully about what it means before allowing cookies to flow between them and the proxy.

If Zuul is fronting a web application then there may be a need to re-write the Location header when the web application redirects through a http status code of 3XX, otherwise the browser will end up redirecting to the web application’s url instead of the Zuul url.

To pass information between filters, Zuul uses a RequestContext. Its data is held in a ThreadLocal specific to each request. Information about where to route requests, errors and the actual HttpServletRequest and HttpServletResponse are stored there
The RequestContext extends ConcurrentHashMap, so anything can be stored in the context. FilterConstants contains the keys that are used by the filters installed by Spring Cloud Netflix

Zuul secures your sensitive headers by blocking these headers downstream (microservice). Since the default settings for sensitive headers blocks the Authorization header, we have to open this setting and send these headers downstream. You can choose to set the sensitive header per route or globally.


1. add-host-header=true

2. ignored-patterns to block access the backend endpoints 

3. RequestContext.addZuulRequestHeader to add custom header 


Don't forget Zuul is using Hystric underneath - so you may well have a Hystrix timeout instead (1000ms by default). You can either disable the timeout feature of Hystrix or increase its value:

```
# Disable Hystrix timeout globally (for all services)
hystrix.command.default.execution.timeout.enabled: false

# Increase the Hystrix timeout to 60s (globally)
hystrix.command.default.execution.isolation.thread.timeoutInMilliseconds: 60000
```

Be careful however with the last two properties as they apply to the THREAD isolation strategy. Although the Netflix documentation says it is the default, I noticed SpringCloud version of Zuul defaults to SEMAPHORE.

The ReadTimeout is targeted at the the underlying RestClient that makes the actual call to the service. So, when does it take effect? Don't forget Ribbon is there to perform routing, failover and load balancing - so a single client request may lead to multiple attempts to contact a service. Stated differently, if you have two instances of a service and one is not reachable, you end up with two RestClient calls within a single Hystrix command.

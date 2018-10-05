If spring-cloud-sleuth-zipkin is available then the app will generate and collect Zipkin-compatible traces via HTTP. By default it sends them to a Zipkin collector service on localhost (port 9411). Configure the location of the service using spring.zipkin.baseUrl

you can see the correlation data being collected in logs, as long as you are logging request

You will see traceId and spanId populated in the logs. If this app calls out to another one (e.g. with RestTemplate) it will send the trace data in headers and if the receiver is another Sleuth app you will see the trace continue there.

NOTE: instead of logging the request in the handler explicitly, you could set logging.level.org.springframework.web.servlet.DispatcherServlet=DEBUG

NOTE: If you use Zipkin, configure the probability of spans exported by setting (for 2.0.x) spring.sleuth.sampler.probability or (up till 2.0.x)spring.sleuth.sampler.percentage (default: 0.1, which is 10 percent). Otherwise, you might think that Sleuth is not working be cause it omits some spans.

Spans can be started and stopped, and they keep track of their timing information. Once you create a span, you must stop it at some point in the future.

With Brave instrumentation, we no longer need to set special events for Zipkin to understand who the client and server are, where the request started, and where it ended

The SLF4J MDC is always set and logback users immediately see the trace and span IDs in logs per the example shown earlier. Other logging systems have to configure their own formatter to get the same result. The default is as follows: logging.pattern.level set to %5p [${spring.zipkin.service.name:${spring.application.name:-}},%X{X-B3-TraceId:-},%X{X-B3-SpanId:-},%X{X-Span-Export:-}] (this is a Spring Boot feature for logback users). If you do not use SLF4J, this pattern is NOT automatically applied.

####Baggage versus Span Tags####

If you want to use only Spring Cloud Sleuth without the Zipkin integration, add the spring-cloud-starter-sleuth module to your project.

If you want both Sleuth and Zipkin, add the spring-cloud-starter-zipkin dependency.

[appname,traceId,spanId,exportable] entries from the MDC

By default, if you add spring-cloud-starter-zipkin as a dependency to your project, when the span is closed, it is sent to Zipkin over HTTP. The communication is asynchronous. Y

spring.zipkin.baseUrl: http://192.168.99.100:9411/

If you want to find Zipkin through service discovery, you can pass the Zipkin’s service ID inside the URL, as shown in the following example for zipkinserver service ID:
spring.zipkin.baseUrl: http://zipkinserver/
To disable this feature just set spring.zipkin.discoveryClientEnabled to `false.

Starting with Sleuth 2.0.0, we no longer register a bean of AsyncRestTemplate type. It is up to you to create such a bean. Then we instrument it.

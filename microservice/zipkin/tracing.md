Span context: Trace information that accompanies the distributed transaction, including when it passes from service to service over the network or through a message bus. The span context contains the trace identifier, span identifier, and any other data that the tracing system needs to propagate to the downstream service.

Many of the logging components we get now will output JSON documents for each log instead of outputting flat rows in a text file?

Return Your Identifier Back to Your Client?

If you’re getting problems, you should be able to make this change to logging levels on the fly while your systems are running, diagnose the issue, then return the logging back to normal afterward.?

Other than that you can mark custom events inside a span and you can calculate how long it takes to your application to end a specific task like generating a pdf, decompress a request, process a message queue and so on.

Every span has it’s id and it also have a parent span id. It is useful to aggregate all the spans to get the three of your spans.

Some spans have one or more dots, that white dots are logs. They are useful to understand when a specific event happen in time. You can use this feature to identify when you send an email or when a customer clicked a specific button tracking it’s UI experience.

We can implement this solution using MDC feature of Logging frameworks. Typically we will have a WebRequest Interceptor where you can check whether there is a CORRELATION_ID header. If there is no CORRELATION_ID in the header then create a new one and set it in MDC. The logging frameworks include the information set in MDC with all log statements.

The false in [inventory-service,0335da07260d3d6f,1af68249ac3a6902,false] indicates that this trace is not exported to any Tracing Server like Zipkin. Let us see how we can export the tracing information to Zipkin.

Internal tracing: Talking to an external database? Spawn a child-span to keep track of the amount of time used for that action? Performing a CPU-intensive operation on some data? Track this using a child-span as well. There are many occurrences where it makes sense to keep track of what’s going on using tracing even within services.

A cool thing about opentracing and zipkin is that you can attach both arbitrary key-value pairs as well as “log events” to spans that ends up in Zipkin. Here we see Zuul providing some extra info for us:
inbound and outbound requests are in different spans
spans that include cs can log an sa annotation of where they are going
This helps when the destination protocol isn’t Zipkin instrumented, such as MySQL.

Our JAVA microservices create JSON formatted log lines using the logback LogStash encoder. They are picked up by Fluentd, put in Elasticsearch and accessed via Kibana. In this post, we want to show how to add the Zipkin traceId and spanId to the JSON formatted log lines via the Mapped Diagnostic Context (MDC). When this is done, one can select a trace from Zipkin, put the traceId in Kibana for search, and pull up all the logging associated to that particular trace.

```
span = get_current_span()
span.log(event='cache-miss')
```

The OpenTracing API standardizes around some useful tags, and one of them is the so-called "sampling priority": exact semantics are implementation-specific, but any value greater than zero (the default) indicates a trace of elevated importance.




zipkin-server is a Spring Boot application, packaged as an executable jar. You need JRE 8+ to start zipkin-server.
Span storage and collectors are configurable. By default, storage is in-memory

/ - UI
/config.json - Configuration for the UI
/api/v2 - Api
/health - Returns 200 status if OK
/info - Provides the version of the running instance
/metrics - Includes collector metrics broken down by transport type

Zipkin even supports a Spring Boot-based implementation of this REST API. Using that is as simple as using Zipkin’s @EnableZipkinServer directly. The Zipkin Server delegates writes to the persistence tier via a SpanStore. Presently, there is support for using MySQL or an in-memory SpanStore out-of-the-box.

To make it possible for Spring Cloud Sleuth to add tracing headers to the outgoing requests it is important that the RestTemplate is injected and not created directly in the code, e.g. not using new RestTemplate().

```
private final ServiceUtils util;
private final RestOperations restTemplate;

@Inject
public ProductCompositeIntegration(ServiceUtils util, RestOperations restTemplate) {
    this.util = util;
    this.restTemplate = restTemplate;
}
```

Add @EnableZipkinServer annotation to main entry-point class.

Part of the Span Context is the Baggage. The trace and span IDs are a required part of the span context. Baggage is an optional part

Spring Cloud Sleuth understands that a header is baggage-related if the HTTP header is prefixed with baggage- and, for messaging, it starts with "baggage".

```
Span initialSpan = this.tracer.nextSpan().name("span").start();
ExtraFieldPropagation.set(initialSpan.context(), "foo", "bar");
ExtraFieldPropagation.set(initialSpan.context(),"UPPER_CASE", "someValue");
}
initialSpan.tag("foo",
		ExtraFieldPropagation.get(initialSpan.context(), "foo"));
initialSpan.tag("UPPER_CASE",
		ExtraFieldPropagation.get(initialSpan.context(), "UPPER_CASE"));
```

Tags, on the contrary, are normally used for spans to tag them and are passed to Zipkin.

Starting from Sleuth 2.0.0 you have to pass the baggage key names explicitly in your project configuration. Read more about that setup here

you can tell also by hitting the /metrics endpoint and look at stats named collector

As you may notice, some of the fields included in the trace data are not mapped correctly. You could make do with the existing mapping but if you want to analyze and visualize all available data properly, you will need to do some Elasticsearch mapping adjustments.

Tags are attached to a specific span. In other words, they are presented only for that particular span. However, you can search by tag to find the trace, assuming a span having the searched tag value exists.

#zipkin-docker

Those using ES_AWS_DOMAIN or Amazon endpoints in ES_HOSTS need to use a "zipkin-aws" distribution. If you are using Docker, you just switch your image from openzipkin/zipkin to openzipkin/zipkin-aws

STORAGE_PORT_9200_TCP_ADDR -- An Elasticsearch node listening on port 9200. This environment variable is typically set by linking a container running zipkin-elasticsearch as "storage" when you start the container. This is ignored when ES_HOSTS or ES_AWS_DOMAIN are set.

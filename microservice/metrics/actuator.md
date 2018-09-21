Spring Boot Actuator provides dependency management and auto-configuration for Micrometer

Spring Boot auto-configures a composite MeterRegistry and adds a registry to the composite for each of the supported implementations that it finds on the classpath. Having a dependency on micrometer-registry-{system} in your runtime classpath is enough for Spring Boot to configure the registry.

Most registries share common features. For instance, you can disable a particular registry even if the Micrometer registry implementation is on the classpath.

management.metrics.export.datadog.enabled=false

Through, MeterRegistryCustomizer, you can customize the whole set of registries at once or individual implementations in particular. For example, a commonly requested setup is to (1) export metrics to both Prometheus and CloudWatch, (2) add a set of common tags to metrics flowing to both (for example, host and application identifying tags) and (3) whitelist only a small subset of metrics to CloudWatch.

JVM metrics, report utilization of:

Various memory and buffer pools
Statistics related to garbage collection
Threads utilization
Number of classes loaded/unloaded
CPU metrics
File descriptor metrics
Logback metrics: record the number of events logged to Logback at each level
Uptime metrics: report a gauge for uptime and a fixed gauge representing the application’s absolute start time
Tomcat metrics

Auto-configuration enables the instrumentation of requests handled by Spring MVC. When management.metrics.web.server.auto-time-requests is true, this instrumentation occurs for all requests.

By default, metrics are generated with the name, http.server.requests. The name can be customized by setting the management.metrics.web.server.requests-metric-name property.

By default, Spring MVC-related metrics are tagged with the following information:

method, the request’s method (for example, GET or POST).
uri, the request’s URI template prior to variable substitution, if possible (for example, /api/person/{id}).
status, the response’s HTTP status code (for example, 200 or 500).
exception, the simple class name of any exception that was thrown while handling the request.

The instrumentation of any RestTemplate created using the auto-configured RestTemplateBuilder is enabled. It is also possible to apply MetricsRestTemplateCustomizer manually.

By default, metrics are generated with the name, http.client.requests. The name can be customized by setting the management.metrics.web.client.requests-metric-name property.

By default, metrics are generated with the name, http.server.requests. The name can be customized by setting the management.metrics.web.server.requests-metric-name property.

By default, Spring MVC-related metrics are tagged with the following information:

method, the request’s method (for example, GET or POST).
uri, the request’s URI template prior to variable substitution, if possible (for example, /api/person/{id}).
status, the response’s HTTP status code (for example, 200 or 500).
exception, the simple class name of any exception that was thrown while handling the request.
To customize the tags, provide a @Bean that implements WebMvcTagsProvider.





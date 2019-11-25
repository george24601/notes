
Auto-configuration enables the instrumentation of requests handled by Spring MVC. When management.metrics.web.server.auto-time-requests is true, this instrumentation occurs for all requests.

The instrumentation of any RestTemplate created using the auto-configured RestTemplateBuilder is enabled. It is also possible to apply MetricsRestTemplateCustomizer manually.

By default, metrics are generated with the name, http.client.requests. The name can be customized by setting the management.metrics.web.client.requests-metric-name property.

If you find that you repeatedly instrument a suite of metrics across components or applications, you may encapsulate this suite in a MeterBinder implementation. By default, metrics from all MeterBinder beans will be automatically bound to the Spring-managed MeterRegistry.

Navigating to /actuator/metrics displays a list of available meter names. You can drill down to view information about a particular meter by providing its name as a selector, e.g. /actuator/metrics/jvm.memory.max.

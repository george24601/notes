Your plan should include logging methods and tools, data hosting locations, and most importantly, an idea of the specific information you’re looking for.

Two common log structuring formats are JSON and KVP (Key Value Pair).

what is our current log size per month, unzipped?

fluentd -> s3 -> logstash -> es?

Use a standard and easily configurable logging framework.log4j, log4net, etc. allow faster config changes than hard-coded or proprietary frameworks.

Use a logging framework with flexible output options. View console logs in development and centralize prod logs without extra plugins or agents.

Use a standard structured format like JSON. Custom formats and raw text logs need custom parsing rules to extract data for analysis.

Create a standard schema for your fields. Adding fields ad hoc can create a rat’s nest. A standard lets everyone know where to look.

Don’t let logging block your application. Write logs asynchronously with a buffer or queue so the application can keep running.

Configure local storage for network outages and server back pressure. Good agents and libraries offer disk-assisted queues, but you must set them up.

Don’t let local storage use all your memory or disk space. If you don’t configure a limit or rotation policy, logs can crash your server.

Check your IT department’s security requirements up front. IT often gets veto power on deals, so clarify requirements before evaluating options.

Compare the TCO of self-hosting, cloud-hosting, and SaaS. Open source is not free. Consider storage, compute, bandwidth, operational, and hidden costs.

Get input from users of the system before making a decision. Let end users try out the options instead of making a top-down purchase decision.
If end users find a tool hard to use, they will avoid it, offload to experts, or force a switch.

Automatically parse your logs at ingestion. Parsing logs at search time is slower, and automatic rules save time over custom ones.

One common solution for container logs is dedicated logging containers. As the name implies, dedicated logging containers are created specifically to gather and forward log messages to a destination such as a syslog server. Dedicated containers automatically collect messages from other containers running on the node, making setup as simple as running the container. but application containers need to be aware of the logging container, and vice versa. Alternatively, can pair each applicatin with a sidecar container, e.g., sharing logs by mounted volumes

Logging via the Docker Logging Driver seems recommended for most cases

The MDC class contains only static methods. It lets the developer place information in a diagnostic context that can be subsequently retrieved by certain logback components. The MDC manages contextual information on a per thread basis. Typically, while starting to service a new client request, the developer will insert pertinent contextual information, such as the client id, client's IP address, request parameters etc. into the MDC. Logback components, if appropriately configured, will automatically include this information in each log entry.

Note the usage of the %X specifier within the PatternLayout conversion pattern. The %X conversion specifier is employed twice, once for the key named first and once for the key named last. After obtaining a logger corresponding to SimpleMDC.class, the code associates the value Parker with the key named last. It then invokes the logger twice with different messages. The code finishes by setting the MDC to different values and issuing several logging requests. Running SimpleMDC yields:
```
<appender name="CONSOLE" class="ch.qos.logback.core.ConsoleAppender"> 
  <layout>
    <Pattern>%X{first} %X{last} - %m%n</Pattern>
  </layout> 
</appender>
```

To allow the information contained in the MDC to be correct at all times when a request is processed, a possible approach would be to store the username at the beginning of the process, and remove it at the end of said process. A servlet Filter comes in handy in this case.

A copy of the mapped diagnostic context can not always be inherited by worker threads from the initiating thread. This is the case when java.util.concurrent.Executors is used for thread management. For instance, newCachedThreadPool method creates a ThreadPoolExecutor and like other thread pooling code, it has intricate thread creation logic.

In such cases, it is recommended that MDC.getCopyOfContextMap() is invoked on the original (master) thread before submitting a task to the executor. When the task runs, as its first action, it should invoke MDC.setContextMapValues() to associate the stored copy of the original MDC values with the new Executor managed thread.

 MDCInsertingServletFilter inserts such data into the MDC under the following keys.



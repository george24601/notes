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

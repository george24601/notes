/env for updating Environment and rebinding @ConfigurationProperties and log levels

/{application}/{profile}[/{label}]

Possible to use webhook, follow up => spring cloud message bus

This repository implementation maps the {label} parameter of the HTTP resource to a git label (commit id, branch name or tag). If the git branch or tag name contains a slash ("/") then the label in the HTTP URL should be specified with the special string "(_)" instead (to avoid ambiguity with other URL paths). For example, if the label is foo/bar, replacing the slash would result in a label that looks like foo(_)bar.

TODO: Placeholders in Git URI

If you don’t use HTTPS and user credentials, SSH should also work out of the box when you store keys in the default directories (~/.ssh) and the uri points to an SSH location, e.g. "git@github.com:configuration/cloud-configuration"

It is important that an entry for the Git server be present in the ~/.ssh/known_hosts file and that it is in ssh-rsa format

To avoid surprises, you should ensure that only one entry is present in the known_hosts file for the Git server and that it is matching with the URL you provided to the config server. If you used a hostname in the URL, you want to have exactly that in the known_hosts file, not the IP. The repository is accessed using JGit, so any documentation you find on that should be applicable. HTTPS proxy settings can be set in ~/.git/config or in the same way as for any other JVM process via system properties (-Dhttps.proxyHost and -Dhttps.proxyPort).

1. AWS CodeCommit URIs always look like https://git-codecommit.${AWS_REGION}.amazonaws.com/${repopath}.
2. If your Git URI matches the CodeCommit URI pattern (above) then you must provide valid AWS credentials in the username and password, or in one of the locations supported by the default credential provider chain. AWS EC2 instances may use IAM Roles for EC2 Instances.
3. The aws-java-sdk-core jar is an optional dependency. If the aws-java-sdk-core jar is not on your classpath, then the AWS Code Commit credential provider will not be created regardless of the git server URI.
By default, the JGit library used by Spring Cloud Config Server uses SSH configuration files such as ~/.ssh/known_hosts and /etc/ssh/ssh_config when connecting to Git repositories using an SSH URI.

Retry
----------
1. ConfigServerInstanceProvider
2. ConfigServicePropertySourceLocator

No cache and no polling. It reads from the filesystem each time. If you are using the -monitor starter, it will use facilities to "watch" for filesystem changes.

every time it tries to fullfil a GET request for a GIT repository, it calls refresh method of JGitEnvironmentRepository, that results in a PULL to GIT repo, what takes a lot of time and can generate issues in case of many concurrent requests.

Nowadays the average response time is more than 1 second. And considering that health check of each Config Client do a GET to print the list of resources, it is an eternity. I disabled this health check in my clients and the response time of /health now is less than 20ms.

 If we could add caching to config server then the constant Git pull could be reduced. 

monitor eliminates the pull totally but at the cost of an added dependency on a queue

The Config Client supplies a Spring Boot Health Indicator that attempts to load configuration from Config Server. The response is also cached for performance reasons. The default cache time to live is 5 minutes.

When reading config files from sub-directories, if more than one directory has files with identical names, the last one wins. I haven’t checked but would assume similar behavior for multiple Git repos as well.

a HTTP POST to each one on the /refresh endpoint provided by Spring Boot Actuator.

Config server is not the only choice though: Netflix Archaius, Apache ZooKeeper and Kubernetes ConfigMap also provide configuration management, although none is aware of Spring PropertySource and Environment abstractions out of the box

By default, the configuration values are read on the client’s startup, and not again. You can force a bean to refresh its configuration - to pull updated values from the Config Server - by annotating the MessageRestController with the Spring Cloud Config @RefreshScope and then by triggering a refresh event.

In order to use it you must add org.springframework.boot:spring-boot-starter-actuator to the client app’s CLASSPATH. You can invoke the refresh Actuator endpoint by sending an empty HTTP POST to the client’s refresh endpoint, http://localhost:8080/refresh, and then confirm it worked by reviewing the http://localhost:8080/message endpoint.

There is no way to broadcast refresh requests without /monitor or by triggering a manual refresh using /bus/refresh unless you code something by hand.

spring.cloud.config.discovery.enabled=true is currently built on a one time eureka lookup. It is not built with ribbon (ie a client-side load balancer).

@RefreshScope shouldn't be needed if you are using @ConfigurationProperties

Only refresh scope beans. But if you're just using @Value, move it to a @ConfigurationProperties

@Scheduled doesn't work in @RefreshScope (never has done). The @Scheduled annotation is processed on startup, and never re-processed.
don't use @Scheduled on beans that are @RefreshScope.

I thought that calling RefreshEndpoint.refresh (on the client) would force the client to reload the properties from the server but I have the impression it does not work (I can provide a very simple example if it helps

You could use @Scheduled from spring-framework to implement polling.

your load could lead to 75 concurrent requests to the config server for the updated properties, and you won't have 75 threads able to process them on the server, so they will have to wait for each other.





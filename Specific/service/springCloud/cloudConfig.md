/env for updating Environment and rebinding @ConfigurationProperties and log levels

/{application}/{profile}[/{label}]

```
spring.application.name=didispace
server.port=7002
eureka.client.serviceUrl.defaultZone=http://localhost:1111/eureka/
spring.cloud.config.discovery.enabled=true
spring.cloud.config.discovery.serviceId=config-server
spring.cloud.config.profile=dev
```

Possible to use webhook
follow up => spring cloud message bus


To scale the Config Server up and make it highly available, you would need to have all instances of the server pointing to the same repository, so only a shared file system would work. Even in that case it is better to use the ssh: protocol for a shared filesystem repository, so that the server can clone it and use a local working copy as a cache.

This repository implementation maps the {label} parameter of the HTTP resource to a git label (commit id, branch name or tag). If the git branch or tag name contains a slash ("/") then the label in the HTTP URL should be specified with the special string "(_)" instead (to avoid ambiguity with other URL paths). For example, if the label is foo/bar, replacing the slash would result in a label that looks like foo(_)bar.

TODO: Placeholders in Git URI

If you don’t use HTTPS and user credentials, SSH should also work out of the box when you store keys in the default directories (~/.ssh) and the uri points to an SSH location, e.g. "git@github.com:configuration/cloud-configuration"

It is important that an entry for the Git server be present in the ~/.ssh/known_hosts file and that it is in ssh-rsa format

To avoid surprises, you should ensure that only one entry is present in the known_hosts file for the Git server and that it is matching with the URL you provided to the config server. If you used a hostname in the URL, you want to have exactly that in the known_hosts file, not the IP. The repository is accessed using JGit, so any documentation you find on that should be applicable. HTTPS proxy settings can be set in ~/.git/config or in the same way as for any other JVM process via system properties (-Dhttps.proxyHost and -Dhttps.proxyPort).

By default, the JGit library used by Spring Cloud Config Server uses SSH configuration files such as ~/.ssh/known_hosts and /etc/ssh/ssh_config when connecting to Git repositories using an SSH URI.


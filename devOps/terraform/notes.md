Over time, as you apply more and more updates, each server builds up a unique history of changes. This often leads to a phenomenon known as configuration drift, where each server becomes slightly different than all the others, leading to subtle configuration bugs that are difficult to diagnose and nearly impossible to reproduce

If you’re using an orchestration tool such as Terraform to deploy machine images created by Docker or Packer, then every “change” is actually a deployment of a new server (just like every “change” to a variable in functional programming actually returns a new variable). For example, to deploy a new version of OpenSSL, you would create a new image using Packer or Docker with the new version of OpenSSL already installed, deploy that image across a set of totally new servers, and then undeploy the old servers. This approach reduces the likelihood of configuration drift bugs, makes it easier to know exactly what software is running on a server, and allows you to trivially deploy any previous version of the software at any time. Of course, it’s possible to force configuration management tools to do immutable deployments too, but it’s not the idiomatic approach for those tools, whereas it’s a natural way to use orchestration tools.

State is stored by default in a local file named "terraform.tfstate". Prior to any operation, Terraform does a refresh to update the state with the real infrastructure.

Terraform typically uses the configuration to determine dependency order. However, when you delete a resource from a Terraform configuration, Terraform must know how to delete that resource. Terraform can see that a mapping exists for a resource not in your configuration and plan to destroy. However, since the configuration no longer exists, it no longer knows the proper destruction order.

To work around this, Terraform stores the creation-time dependencies within the state. Now, when you delete one or more items from the configuration, Terraform can still build the correct destruction ordering based only on the state.

One idea to avoid this is for Terraform to understand the proper ordering of resources. For example, Terraform could know that servers must be deleted before the subnets they are a part of. The complexity for this approach quickly explodes, however: in addition to Terraform having to understand the ordering semantics of every resource for every cloud, Terraform must also understand the ordering across providers.



However, if your cluster is exposed to a larger network or if you share your cluster with others – production clusters fall into this category – you must take extra steps to secure your installation to prevent careless or malicious actors from damaging the cluster or its data. To apply configurations that secure Helm for use in production environments and other multi-tenant scenarios, see Securing a Helm installation

If your cluster has Role-Based Access Control (RBAC) enabled, you may want to configure a service account and rules before proceeding.

Most cloud providers enable a feature called Role-Based Access Control - RBAC for short. If your cloud provider enables this feature, you will need to create a service account for Tiller with the right roles and permissions to access resources.

For historical reasons, Tiller stores its release information in ConfigMaps. We suggest changing the default to Secrets.

Charts are created as files laid out in a particular directory tree, then they can be packaged into versioned archives to be deployed.

Charts at a higher level have access to all of the variables defined beneath. So the WordPress chart can access the MySQL password as .Values.mysql.password. But lower level charts cannot access things in parent charts, so MySQL will not be able to access the title property. Nor, for that matter, can it access apache.port.

Helm provides a hook mechanism to allow chart developers to intervene at certain points in a release’s life cycle

Practically speaking, this means that if you create resources in a hook, you cannot rely upon helm delete to remove the resources. To destroy such resources, you need to either write code to perform this operation in a pre-delete or post-delete hook or add "helm.sh/hook-delete-policy" annotation to the hook template file.

Each chart installation creates a new release

`helm init` will install tiller in the kube-system namespace of current kubectl context. By default release information are in config maps

`helm inspect values` to see what options are available

`helm status` to check release state or re-read configuration

Helm has two parts: a client (helm) and a server (tiller)
Tiller runs inside of your Kubernetes cluster, and manages releases (installations) of your charts.
Helm runs on your laptop, CI/CD, or wherever you want it to run.

Charts are Helm packages that contain at least two things:
* A description of the package (Chart.yaml) - one for tidb-cluster, one for tidb-operator
* One or more templates, which contain Kubernetes manifest files

Helm will figure out where to install Tiller by reading your Kubernetes configuration file (usually $HOME/.kube/config). This is the same file that kubectl uses.

The easiest way to install tiller into the cluster is simply to run helm init. Once it connects, it will install tiller into the kube-system namespace.  By default, tiller stores release information in ConfigMaps in the namespace where it is running. 

To keep track of a release’s state, or to re-read configuration information, you can use helm status

To see what options are configurable on a chart, use helm inspect values

You can then override any of these settings in a YAML formatted file, and then pass that file during installation.

inside a chart dir, 
Chart.yaml          # A YAML file containing information about the chart
values.yaml         # The default configuration values for this chart
charts/             # A directory containing any charts upon which this chart depends.
templates/          # A directory of templates that, when combined with values, will generate valid Kubernetes manifest files.

However, if your cluster is exposed to a larger network or if you share your cluster with others – production clusters fall into this category – you must take extra steps to secure your installation to prevent careless or malicious actors from damaging the cluster or its data. To apply configurations that secure Helm for use in production environments and other multi-tenant scenarios, see Securing a Helm installation

If your cluster has Role-Based Access Control (RBAC) enabled, you may want to configure a service account and rules before proceeding.

Whenever you install a chart, a new release is created. So one chart can be installed multiple times into the same cluster. And each can be independently managed and upgraded.

Most cloud providers enable a feature called Role-Based Access Control - RBAC for short. If your cloud provider enables this feature, you will need to create a service account for Tiller with the right roles and permissions to access resources.

A Release is an instance of a chart running in a Kubernetes cluster. One chart can often be installed many times into the same cluster. And each time it is installed, a new release is created. Consider a MySQL chart. If you want two databases running in your cluster, you can install that chart twice. Each one will have its own release, which will in turn have its own release name.

Helm does not wait until all of the resources are running before it exits.

To keep track of a release’s state, or to re-read configuration information, you can use helm status

For historical reasons, Tiller stores its release information in ConfigMaps. We suggest changing the default to Secrets.

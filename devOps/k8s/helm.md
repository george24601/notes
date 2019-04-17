Helm has two parts: a client (helm) and a server (tiller)
Tiller runs inside of your Kubernetes cluster, and manages releases (installations) of your charts.
Helm runs on your laptop, CI/CD, or wherever you want it to run.
Charts are Helm packages that contain at least two things:
A description of the package (Chart.yaml)
One or more templates, which contain Kubernetes manifest files

Helm will figure out where to install Tiller by reading your Kubernetes configuration file (usually $HOME/.kube/config). This is the same file that kubectl uses.

To find out which cluster Tiller would install to, you can run kubectl config current-context or kubectl cluster-info


However, if your cluster is exposed to a larger network or if you share your cluster with others – production clusters fall into this category – you must take extra steps to secure your installation to prevent careless or malicious actors from damaging the cluster or its data. To apply configurations that secure Helm for use in production environments and other multi-tenant scenarios, see Securing a Helm installation

Tiller, the server portion of Helm, typically runs inside of your Kubernetes cluster. But for development, it can also be run locally, and configured to talk to a remote Kubernetes cluster.

The easiest way to install tiller into the cluster is simply to run helm init. This will validate that helm’s local environment is set up correctly (and set it up if necessary). Then it will connect to whatever cluster kubectl connects to by default (kubectl config view). Once it connects, it will install tiller into the kube-system namespace.

After helm init, you should be able to run kubectl get pods --namespace kube-system and see Tiller running.

By default, tiller stores release information in ConfigMaps in the namespace where it is running. As of Helm 2.7.0, there is now a beta storage backend that uses Secrets for storing release information. This was added for additional security in protecting charts in conjunction with the release of Secret encryption in Kubernetes.

To keep track of a release’s state, or to re-read configuration information, you can use helm status

To see what options are configurable on a chart, use helm inspect values

You can then override any of these settings in a YAML formatted file, and then pass that file during installation.

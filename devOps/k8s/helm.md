Helm has two parts: a client (helm) and a server (tiller)
Tiller runs inside of your Kubernetes cluster, and manages releases (installations) of your charts.
Helm runs on your laptop, CI/CD, or wherever you want it to run.

Charts are Helm packages that contain at least two things:
* A description of the package (Chart.yaml) - one for tidb-cluster, one for tidb-operator
* One or more templates, which contain Kubernetes manifest files

Helm will figure out where to install Tiller by reading your Kubernetes configuration file (usually $HOME/.kube/config). This is the same file that kubectl uses.

The easiest way to install tiller into the cluster is simply to run helm init. This will validate that helm’s local environment is set up correctly (and set it up if necessary). Then it will connect to whatever cluster kubectl connects to by default (kubectl config view). Once it connects, it will install tiller into the kube-system namespace.

By default, tiller stores release information in ConfigMaps in the namespace where it is running. 

To keep track of a release’s state, or to re-read configuration information, you can use helm status

To see what options are configurable on a chart, use helm inspect values

You can then override any of these settings in a YAML formatted file, and then pass that file during installation.

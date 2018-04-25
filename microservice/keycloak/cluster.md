In the standalone operation mode, this file lives in .../standalone/configuration/standalone.xml. This file is also used to configure non-infrastructure level things that are specific to Keycloak components.

------
This mode can be very easy to deploy initially, but can become quite cumbersome. To make a configuration change you’ll have to modify each distribution on each machine. For a large cluster this can become time consuming and error pron

This file resides in .../standalone/configuration/standalone-ha.xml. There’s a few things missing from this configuration. You can’t run Keycloak in a cluster without a configuring a shared database connection. You also need to deploy some type of load balancer in front of the cluster

You use the same boot scripts to start Keycloak as you do in standalone mode. The difference is that you pass in an additional flag to point to the HA config file.



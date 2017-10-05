appID is the name of the application and instanceID is the unique id associated with the instance. In AWS cloud, instanceID is the instance id of the instance and in other data centers, it is the hostname of the instance.

Register new application instance
POST /eureka/v2/apps/appID

Send application instance heartbeat
PUT /eureka/v2/apps/appID/instanceID

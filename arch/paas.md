Cache service:
1. ConfigService + Client
2. SDK to ftech the end points directly. Or use Proxy to forward request to backend
3. cluster manager to manage the config service

A well-documented and reproducible Kubernetes deployment for FoundationDB is officially still a work-in-progress. One of the key blockers for such a deployment is the inability to specify hosts using hostname as opposed to IP. Kubernetes StatefulSets create ordinal and stable network IDs for their pods making the IDs similar to hostnames in the traditional world. Using IPs to identify such pods would be impossible since those IPs would change frequently. The latest thread on the design challenges involved can be tracked in this forum post.

Running Snowflake as a data warehouse-as-a-service requires high availability even during software upgrades. As a result, multiple versions of the service can be deployed at the same time. And services accessing metadata must be able to handle multiple version of metadata objects.

While selecting a metadata store, we prefer key-value stores for the simplicity and flexibility they bring to schema evolution. Also, our cloud services expect the underlying store to be ACID compliant.

To make it easy to add new metadata objects, we built an object-mapping layer on top of key-values. Schema definition, evolution and metadata versioning are done by this layer as well. User-visible objects, such as catalog definitions, users, sessions, access control, copy history and others all have metadata backing them. Every statement executed has a metadata entry, along with statistics of its execution. Transaction state and lock queues are also persisted in FoundationDB. In fact, lock queues are implemented using the watch feature mentioned earlier. A data manipulation statement is enqueued on a resource’s lock queue, and a FoundationDB watch notifies the statement when the statement reached the front of the resource’s queue. There is also user-invisible metadata such as data distribution information, servers and encryption keys.

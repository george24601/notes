#cookie
set a cookie: 
set-cookie header in response, may have may set-cookie headers, e.g., session cookie in its own set-cookie header
Later on when browser will put the content of the cookie in Cookie header in request
auto-fill: encodes preferences in acooke and sends the cookie back tot he browser

reverse proxy layer: nginx keepalived + virtual ip

web server layer: configs web servers behind nginx

write db: mater + shadow master with keepalived + virtual IP


### Lamport lock and vector lock

lamport lock: provides parital order
1.Whenever process does work, increase counter
2.whenever process sends a message, include the counter
3.when a message is recieved, set the counter to max(local, received) + 1

if counter(a) LT  count(b), either a happens before b, or a, b are not comparable

vector lock: maintains array of N logical clocks. each node increment its own clock by 1 for each internal event
similar to lamport clock, upon recieving a message, update local to max, AND THEN increase its own clock by 1 more

* token-based idempotent API:
 * generate token
 * call buy(token, commodity_id)
 * add requests to MQs to avoid reordering of same token requests

A change event looks like:

1. PK
2. Op
3. state after the change
4. state before the change
5. metadata about the source: location in log, db, table, transaction id, source timestamp
6. capture timestamp

#yelp
So, for our application, we developed the following auditing algorithm which uses binary search to find missing documents:

Get the upstream topic’s low and high watermarks
Get all message keys in the upstream topic between the low and high watermark
De-duplicate and sort the keys into an in-memory array
Sleep for Elasticpipe’s max bulk-write time interval, to allow for documents to be flushed
Query Elasticsearch to find possibly-missing keys, which are those that don’t exist in the index under the restriction that we only query for records whose offset (which is part of the metadata we include with each document) is between the low and high watermarks from step 1. (More on this below)
Without the high watermark offset limit, query to find which of the possibly-missing documents are actually missing. This is the final result.

For example, if the low and high watermarks are L and H, the list of keys has n documents, with the first and last (in lexicographic order) documents having keys k1 and k2, respectively, we can query Elasticsearch for the number of documents between k1 and k2 with an offset between L and H. If the result is equal to n, we’re done. If it’s less than n, we can split the list into a left and right half and binary search recursively until either the number of documents in the range matches what we expected, or all the documents in the range are missing (typically when the range reaches size 1).

The difficulty stems from the lag of 10-20 seconds between a change being committed in a master database and that change being visible in Elasticsearch queries. The lag is primarily driven by the bulk writes to Kafka of the data pipeline MySQL binary log parser. These bulk writes ensure max throughput when processing hundreds of thousands of writes per second, but it means that data pipeline table streams, and therefore the order search pipeline, is always behind the truth of what has been committed in MySQL.

One-off admin processes should be run in an identiacl environment as the regular processes against a release, same codebase and config. admin code must be shipped with application code

In local deploy, developers invoke one-off admin processes by direct shell command inside the app's checkout dir.
In production depoy, ssh into the shell to do similar thing

graceful shutdown by SIGTERM:
1. cease to listen on service port
2. finish current request and then exit
3. client should seamlessly reconnect when connection is lsot
4. worker should return its current job back to queue. meaning the job is
reentrant,i.e., either operation's execution/writing is an all or nothing
transaction, or it is idempotent

#### Dockers

Dev container:
More likely built from docker file than from image
Simulate production run so should have all production dependency and no dev tool installed
Code is shared via mounted volume on host system, so we can have load-on-change enabled

Dev tools container:
Do we want to do development inside docker?
If no, we can install dev tools on host, and edit the mounted volume in dev container
If yes, we need a separate container for these tools, and these tools will edit the shared volumn as well
Use it or not depending on if you need an IDE

Build container:
Dev container + build dependencies
Source can be from mounted volume or directly read into docker as container builting process
Builder container will create the final service container,i.e., init the service container and inject the built code.
Notice that build process will NOT handle different environment varaibles between deployment environment. That is part of release process

Service container: what goes to production - environment variables. most likely from an image
Little difference from dev container. Should bulit code be inside container or mounted? No clear disadvantage of inside container 

Test container:
service container + testing dependencies + environment variables for testing.

Installation container:
package service container with env vars, builds a container image that goes to production


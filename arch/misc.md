### Active record
A database table or view is wrapped into a class. An object that wraps a row in a database table or view, encapsulates the database access, and adds domain logic on that data

An object carries both data and behavior. Much of this data is persistent and needs to be stored in a database. Active Record uses the most obvious approach, putting data access logic in the domain object. 

The interface of an object conforming to this pattern would include functions such as Insert, Update, and Delete, plus properties that correspond more or less directly to the columns in the underlying database table.

For bi-directional a-b  maapings, for sharding, data replication is still needed. so that we hit only 1 db for different queries

### Async payment
3rd party payment api shows only the payment is accepted, but not if itself is successful or not  
* Add it to another in progess table - we choose not to reuse the main table so we can easily purge it
* Can solve this by pulling, but latency may be a concern. If it is latency sensitive, add it to the delayed queue, use delayed queue consumer to update the state

### API gateway

* Two different departments on two seperate apps. The communcations between them should be done via api gateway, and should not share the service discovery/registration center
  * Otherwise, team's internal APIs will be exposed too 
* For canary, gateway can listen to rules pub/subed by redis. The gateway will parse colored headers from user request and forward to corresponding environment
  * App knows what header to send and when to send headers, by loading the rule sepearately
  * Rule must be versioned so it can be backward compatible. Note reponse should notify app that its header/rule is outdated
  * Canary one piece at a time, front end and BE together is very tricky

### How Kafka handles many connections
* connection -> acceptor
* acceptor -> processor, each processer handles many connections
* proesssor communiats with worker threads by request and reponse qs


Notificaton:
long-live http keep alive conntion to mark if there is data or not. Even if there is no data, we still push a no-op to keep alive
client does poll once see there is data coming

Use redis to help reduce duplicate requests with different ids, i.e., repeated payment problem

### Connection draining
For rpc server, send draining request to server
server notifies client that it is drainer, so that client will not try connection in the future
wait until server traffic is over. We can deploy to the server

### local delivery
shard by zones, make sure all write happens inside the same zone
API router routes to the current sharding zones, front end will have the traffic tag that translates to shard
each zone has complete data
lock orders in process with failover happens, waait until traffic swtiching is done

global coordinator for routing, caching on the client side to reduce traffic. coordinator has pushing mechanism to push updated routing info too

### c4 model

Context diagrams (level 1): 
 * they show the system in scope and its relationship with users and other systems; - System design
 * People that are using the software are also included in the diagram.
 * Colour coding in the diagram indicates which software systems already exist (the grey boxes) and those to be built (blue).
Container diagrams (level 2):  they decompose a system into interrelated containers.  A container is an executable and deployable sub-system; - application design
Component diagrams (level 3): 
 * they decompose containers into interrelated components, and relate the components to other containers or other systems;
 * zooms into an individual container to show the components inside it. These components should map to real abstractions (e.g., a grouping of code) in your codebase
Code diagrams (level 4):  they provide additional details about the design of the architectural elements that can be mapped to code.  



#cookie
set a cookie: 
set-cookie header in response, may have may set-cookie headers, e.g., session cookie in its own set-cookie header
Later on when browser will put the content of the cookie in Cookie header in request
auto-fill: encodes preferences in acooke and sends the cookie back tot he browser

### 2PL

"Two-phase locking" is one way to implement serializability
  each database record has a lock
  the lock is stored at the server that stores the record
  transaction must wait for and acquire a record's lock before using it
    thus add() handler implicitly acquires lock when it uses record x or y
  transaction holds its locks until *after* commit or abort 

Why hold locks until after commit/abort?
  why not release as soon as done with the record?
  e.g. why not have T2 release x's lock after first get()?
    T1 could then execute between T2's get()s
    T2 would print 10,9
    but that is not a serializable execution: neither T1;T2 nor T2;T1

How does locking interact with two-phase commit?
  Server must aquire and remember locks as it executes client requests.
    So client->server RPCS have two effects: acquire lock, use data.
  If server says "yes" to TC's prepare:
    Must remember locks and values across crash+restart!
    So must write locks+values to disk (in log), before replying "yes".
    If reboot, then COMMIT from TC, read locks+values from disk.
  If server has not said "yes" to a prepare:
    If crash+restart, server can release locks and discard new values.
      (or just forget about them during the crash)
    And then say "no" to TC's prepare message.

invariant rules across your domain model - model the invariants and assocaited entity/values as aggregates - aggregates focus on transactional boundaries - individual aggregates are transactional consistent 

### multi-tenant
service identify verification: tenant id + BizCode, under it multiple extension point

abostract extension point

Use annotation to mark extension, Bootstrap type will scan the class and register the extension 

At run time, use TenantContext to choose the extension, TC is initialized before the business logic, via interceptor

metadata to support extension?

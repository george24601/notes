### feature flag

Feature toggles can be categorized across two major dimensions: how long the feature toggle will live and how dynamic the toggling decision must be


#### Release Toggles

* Normally lives for a few weeks
* Hides half-complete features from the end user
* Mostly changes with release versions

#### Experiment Toggles
* Lives for a few weeks
* By their nature Experiment Toggles are highly dynamic - each incoming request is likely on behalf of a different user and thus might be routed differently than the last.

#### Ops Toggles
* We might introduce an Ops Toggle when rolling out a new feature which has unclear performance implications so that system operators can disable or degrade that feature quickly in production if needed.
* can live for months

#### Permissioning Toggles
* For example we may have a set of "premium" features which we only toggle on for our paying customers. Or perhaps we have a set of "alpha" features which are only available to internal users and another set of "beta" features which are only available to internal users plus beta users. 
* A Champagne Brunch is similar in many ways to a Canary Release. The distinction between the two is that a Canary Released feature is exposed to a randomly selected cohort of users while a Champagne Brunch feature is exposed to a specific set of users.
* When used as a way to manage a feature which is only exposed to premium users a Permissioning Toggle may be very-long lived compared to other categories of Feature Toggles - at the scale of multiple years. Since permissions are user-specific the toggling decision for a Permissioning Toggle will always be per-request, making this a very dynamic toggle.


For example the router for an Experiment Toggle makes routing decisions dynamically for a given user, perhaps using some sort of consistent cohorting algorithm based on that user's id. Rather than reading a static toggle state from configuration this toggle router will instead need to read some sort of cohort configuration defining things like how large the experimental cohort and control cohort should be.

Anti-patterns
* De-coupling decision points from decision logic

Before

```javascript
  const features = fetchFeatureTogglesFromSomewhere();

  function generateInvoiceEmail(){
    const baseEmail = buildEmailForInvoice(this.invoice);
    if( features.isEnabled("next-gen-ecomm") ){ 
      return addOrderCancellationContentToEmail(baseEmail);
    }else{
      return baseEmail;
    }
  }
```

The decision on whether to include order cancellation functionality in our invoice emails is wired directly to that rather broad next-gen-ecomm feature - using a magic string, no less. Why should the invoice emailling code need to know that the order cancellation content is part of the next-gen feature set? What happens if we'd like to turn on some parts of the next-gen functionality without exposing order cancellation? Or vice versa? What if we decide we'd like to only roll out order cancellation to certain users? It is quite common for these sort of "toggle scope" changes to occur as features are developed.

After

```
  const features = fetchFeatureTogglesFromSomewhere();
  const featureDecisions = createFeatureDecisions(features);

  function generateInvoiceEmail(){
    const baseEmail = buildEmailForInvoice(this.invoice);
    if( featureDecisions.includeOrderCancellationInEmail() ){
      return addOrderCancellationContentToEmail(baseEmail);
    }else{
      return baseEmail;
    }
  }
```

* Inversion of Decision 
``` javascript
  function createInvoiceEmailler(config){
    return {
      generateInvoiceEmail(){
        const baseEmail = buildEmailForInvoice(this.invoice);
        if( config.includeOrderCancellationInEmail ){
          return addOrderCancellationContentToEmail(email);
        }else{
          return baseEmail;
        }
      },
  
      // ... other invoice emailer methods ...
    };
  }

  function createFeatureAwareFactoryBasedOn(featureDecisions){
    return {
      invoiceEmailler(){
        return createInvoiceEmailler({
          includeOrderCancellationInEmail: featureDecisions.includeOrderCancellationInEmail()
        });
      },
  
      // ... other factory methods ...
    };
  }
```


* Avoiding conditionals

if ldclient.toggle('temp-awesome-xyz', user, False):
    do_the_new_thing()
else:
    do_the_old_thing()


### column-oriented db
Benefits include more efficient access to data when only querying a subset of columns (by eliminating the need to read columns that are not relevant), and more options for data compression. However, they are typically less efficient to insert new data.

001, 002..etc being the internal rowid

10:001,12:002,11:003,22:004;
Smith:001,Jones:002,Johnson:003,Jones:004;
Joe:001,Mary:002,Cathy:003,Bob:004;
60000:001,80000:002,94000:003,55000:004;

n a row-oriented system, indices map column values to rowids, whereas in a column-oriented system, columns map rowids to column values.
 A row-oriented system can retrieve the row in a single disk read, whereas numerous disk operations to collect data from multiple columns are required from a columnar database.  This is even more true for writing data into the database, especially if the data tends to be "sparse" with many optional columns. For this reason, column stores have demonstrated excellent real-world performance in spite of many theoretical disadvantages

online transaction processing (OLTP)-focused RDBMS systems are more row-oriented, while online analytical processing (OLAP)-focused systems are a balance of row-oriented and column-oriented.

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

### When OS context switches
* multi tasking
* hardware interruption
* between user mode and kernel mode, e.g., system calls

### What if a hot cache key expires
* Protect all the concurrent DB read with a distributed lock



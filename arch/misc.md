### Leaky abstraction

The law of leaky abstractions means that whenever somebody comes up with a wizzy new code-generation tool that is supposed to make us all ever-so-efficient, you hear a lot of people saying “learn how to do it manually first, then use the wizzy tool to save time.” Code generation tools which pretend to abstract out something, like all abstractions, leak, and the only way to deal with the leaks competently is to learn about how the abstractions work and what they are abstracting. So the abstractions save us time working, but they don’t save us time learning.

And all this means that paradoxically, even as we have higher and higher level programming tools with better and better abstractions, becoming a proficient programmer is getting harder and harder.

And while these great tools, like modern OO forms-based languages, let us get a lot of work done incredibly quickly, suddenly one day we need to figure out a problem where the abstraction leaked, and it takes 2 weeks. And when you need to hire a programmer to do mostly VB programming, it’s not good enough to hire a VB programmer, because they will get completely stuck in tar every time the VB abstraction leaks.

two major things that cause abstractions to fall apart: performance and bugs (or debugging).

### Testing time dependency


* Approach 3, the clock factory
 In this case, whenever the program needs to know what time it is, it calls clock_factory::get_clock(), which in production code returns some encapsulation of std::chrono::<some_clock>.

This is better. Now the only code that differs between a unit test build and a production build is what clock_factory::get_clock() returns.

Unfortunately these factories tends to be singletons, with all the problems that they bring.

If you want to model your test clock as a mock, you have the additional problem of how to ensure that the test code and the unit under test sees the same clock. It's also really difficult to correctly provide all the right expectations for the mock without over constraining the tests (exactly how many times should the time be asked for, and what time should be reported on each call?)

* Approach 4, clocks from above
Instead of having code ask for clocks from factories, you can model your program so that every class that needs to know the time has a constructor that accepts a clock and stores it as a member variable.

This gets rid of the singleton (yay!!!), but it adds a lot of extra storage and all the other problems remain.

* 1. Pass in the data you need 2. Pass in a function that gives you the data you need 3a./3b. Pass in an object (or function like a factory) that gives you the function that gets you the data you need.
* We use a time provider interface and mock it, and have zero problems with this approach.
* The Ruby equivalent is Timecop
* in most dynamic languages like Python or JS, the default approach is to redefine time functions from standard libraries. 
* Don’t do something silly like take a parameter called current_time. Instead, name it what it’s actually used for or doing. This could be send_emails_on or the like. Parameters should tell the reader what not why.

### feature flag

#### De-coupling decision points from decision logic

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

```javascript
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

### Inversion of Decision 

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

### column-oriented db

they are typically less efficient to insert new data.

001, 002..etc being the internal rowid

10:001,12:002,11:003,22:004;
Smith:001,Jones:002,Johnson:003,Jones:004;
Joe:001,Mary:002,Cathy:003,Bob:004;
60000:001,80000:002,94000:003,55000:004;

In a row-oriented system, indices map column values to rowids, whereas in a column-oriented system, columns map rowids to column values.

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


##### cookie
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

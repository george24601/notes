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

A change event looks like:

1. PK
2. Op
3. state after the change
4. state before the change
5. metadata about the source: location in log, db, table, transaction id, source timestamp
6. capture timestamp


invariant rules across your domain model - model the invariants and assocaited entity/values as aggregates - aggregates focus on transactional boundaries - individual aggregates are transactional consistent 

### multi-tenant
service identify verification: tenant id + BizCode, under it multiple extension point

abostract extension point

Use annotation to mark extension, Bootstrap type will scan the class and register the extension 

At run time, use TenantContext to choose the extension, TC is initialized before the business logic, via interceptor

metadata to support extension?

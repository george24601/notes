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

What are locks really doing?
  When transactions conflict, locks delay one to force serial execution.
  When transactions don't conflict, locks allow fast parallel execution.

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


-----
Raft and two-phase commit solve different problems!
  Use Raft to get high availability by replicating
    i.e. to be able to operate when some servers are crashed
    the servers all do the *same* thing
  Use 2PC when each subordinate does something different
    And *all* of them must do their part
  2PC does not help availability
    since all servers must be up to get anything done
  Raft does not ensure that all servers do something
    since only a majority have to be alive

What if you want high availability *and* distributed commit?
  Each "server" should be a Raft-replicated service
  And the TC should be Raft-replicated
  Run two-phase commit among the replicated services
  Then you can tolerate failures and still make progress

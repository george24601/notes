Workflow 1
---------

1. Service A persist message 

2. Transaction A commits

3. Service let the message broker know that this txn can commit

4. Service B receives the message from MQ, commit, and return to MQ that it is complete

5. If txn in A fails, A needs to let MQ know that it is fail instead of commit

6. Need to expose service endpoints to message broker to confirm system's status, so that MQ middleware can defend against timeout

7. On repeated failure, need human intervention

8. On service B's failure - rollback on service A has huge cost!

Workflow 2
---------
1. service A upon completion, syncly send a message to MQ

2. MQ syncly sends message to downstream service B

3. Upon B completion, returns back to MQ, and delete the message from it

4. Upon multiple delivery failure, MQ stops delivering, and record it to the deadletter queue, downstream service B will periodically check the deadletter queue


Workflow 3
----------

1. Long live transaction needs extra pending state, and send a message to the next service 

2. Every service needs extra event table to track which step it is at

3. once the last service completes, it notifies the previous service, and record the status as done

4. This one suggests deeper coupling between services. In SAGA, such thing is coupled in SAGA system


Workflow 4
-----------

1. A sends msg to MQ, marked as pending

2. upon MQ receiving the MSG, persist locally, but do not send it

3. Based on MQ's reply, A decides if need to commit 

4. Upon txn A commit good, sends commit message to MQ. MQ will then deliver msg to downstream


Workflow 5
--------

1. A sends pending info to centralized message service (CMS), before txn commits

2. A sends cancel or sening to CMS, after txn commits

3. CMS inquires timeouted messages

4. CMS confirms that messages have been consumed by downstream

5. CMS queries consumption timeout message.

6. Need a CMS control panel




need reliable MQ broker at sender and receiver end

to recover msg to be acked over long time, need to talk to upstream service to either update the state of the message to sent, or delete the message

In practice, need human intervetion capabilities, and limit max retries, and publish it to the deadletter queue

need a delay based queue, at the serivce entrance, start, at the end of execution flow, cancel it, if execution is not done, the delay job will go trough the process

also, possible to let consumer to poll main side, useful in the case of non-time-sensitive txns, e.g., notification service



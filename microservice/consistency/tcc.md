1. main service calls try on all sub services, and log all in the activity monitor


3. if all tries are good, the main service executes local tranx, send confirm/cancel to AM, AM will cofirm on sub services, if they are good, AM tells main service to submit. Otherwise, AM will use the cancel endpoints on the subservices 

4. if any of the sub services falied to try, the main service will rollback and over. The successful tries will use a batch job to cancel good tried that timed out - roll back them.  The net result: cancel everywhere (after some time).

5. no need to execute service 2's commit immediately, can do it asynchly

6. cancel needs to be idempotent, and needs to handle various cases. note that we need to handle confirm failure case, i.e., rollback all confirms, and cancel





Can combine TCC with MQ based solution

1. try: persist message

2. confirm: send message

3. cancel: delete message

Variant: Do-compensate TCC


To minimize the occurrence of heuristics and to facilitate their resolution, smart implementations can be based on a specialized and reusable TCC coordinator that makes informed decisions about whether to proceed in Step 3 or not, keeps a recoverable progress log and performs smart retries where possible. This way, the number of anomalies may be reduced to practically zero.

The reserved state is identified by a unique URI that can be used to con rm, and an associated expiration date/time after which the participant can autonomously cancel and move back to the initial state. In the case of a flight reservation system, this corresponds to a seat reservation identified by a URI and with associated expiration date/time. As a minor but useful extension, a participant in this state can accept HTTP DELETE in case it wants to be notified of failures before it times out by itself.

When the happy path reaches Step 3, the TCC coordinator service comes into play: it accepts the set of URIs to con rm and tries to do a smart job by confirming and retrying them if needed,
or canceling when that is the better option








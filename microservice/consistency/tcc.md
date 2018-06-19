Workflow 1
----------
1. main service calls try on all sub services, and log all in the activity monitor

3. if all tries are good, the main service executes local tnx, send confirm/cancel to AM, AM will cofirm on sub services, if they are good, AM tells main service to submit. Otherwise, AM will use the cancel endpoints on the subservices 

4. if any of the sub services falied to try, the main service will rollback and over. The successful tries will use a batch job to cancel good tried that timed out - roll back them.  The net result: cancel everywhere (after some time).

5. no need to execute service 2's commit immediately, can do it asynchly

6. cancel needs to be idempotent, and needs to handle various cases. note that we need to handle confirm failure case, i.e., rollback all confirms, and cancel


TCC needs local RM support


Can combine TCC with MQ based solution

1. try: persist message

2. confirm: send message

3. cancel: delete message



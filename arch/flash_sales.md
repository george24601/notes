Most common metrics - concurrent requests/hits per seconds (not txn per sec) by setting # of workers

General workflow: check storage -> deduct storage ->  create order -> pay

Dedup multiple request form the same user => 
1. redis for consitency check, set 5 mins expire time
2. unique token for each submission request on the frontend


Cancel order: MQ based solutions



Avoid giving away too many orders: 
1. FIFO, memory queue maybe too much
2. optimistic lock => more CPU time for failure, e.g., watch in redis
3. counter to drop traffic at DAO layer

# Limit traffic: 

General principle - reduce the traffic layer by layer

1. token bucket - no need to be producer-consumer, and calcuate last token's timestamp and we can calcualte how many tokens we need to add. Good for blocking case. Good for no SUDDEN change of traffics.Constant incoming rate, stop putting into bucket when the capacity is full. If bucket is full in token Bucket , token are discard not packets. While in leaky bucket , packets are discarded, and can send large burst. The goal is to limit AVG and accept certain bursts
2. leaky bucket - unlike token bucket, need to take out token at the rate of t/n. Good for blocking case. less resource utiliation than token bucket, i.e., max output rate, goal is to limit output
3. slided time window - slide end, delete obsolete one, and then update counter - but may still have peak traffic in a REALLY small timed window with in the timed window. Good for rejecting rate limiting. Simple
4. for distributed rate limiting, may need to ignore failed rate limiting request from redis - 50k TPS for redis compare_and_swap
5. Also, may think solving it asynchly by using peristant queue


# Deployment options

1. API Gateway
2. rate-limiter as RPC service
3. within the microservice systems

When hit the rate limit, we need to circuit break 

1. direct reject
2. add to the a blocking Q
3. log + warning

Need to watch out for the combinition of time granularity, api granularity, and max rate

To test: redirect prod traffic to a small subset of service, and see if the rate limiter is in effect - i.e., the shape of the TPS graph should be more reasonable

hot renew rate limiter settings

trie tree for url-ish leveled dir with common prefixes,i.e., we can use it the organize rate limit logics

db connection is very valuable - mysql each gives 1k connection, for 50 per machine, this means at most 20 nodes

for write requests, use queue, and pass only the limited number of the request to the queue

General workflow: check storage -> deduct storage ->  create order -> pay

Dedup multiple request form the same user => 
1. redis for consitency check, set 5 mins expire time

2. unique token for each submission request on the frontend


Cancel order: 

1. MQ based solutions



Avoid giving away too many orders: 
1. FIFO, memory queue maybe too much

2. optimistic lock => more CPU time for failure, e.g., watch in redis

3. counter to drop traffic at DAO layer



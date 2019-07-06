* what is the select qps? What is its latency
QPS no more than 5k, 95 latency 14 ms 
Expensive Executor OPs, indexLookUpExecutor
KV retry duration: 99 percentile at 127 MS
* check query plan maybe?
* Compare config with the official benchmark run?
* What is the most/slowest query?
 

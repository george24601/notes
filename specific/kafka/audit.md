Msg with audit data: Producer creation ts, Producer ID

Monitoring message: count of msg, count for which topic?, tier id string, time bucket interval

audit consumer reads the M(a), and publishes M(m) back to the each cluster. In the end, an Audit app reads from the M(m) from each cluster, and can ETL it into MySQL DB

Time M(a) seen by audit consumer - make sure it is not too far from the actual time. - just need to sample this, no need to emit all. 


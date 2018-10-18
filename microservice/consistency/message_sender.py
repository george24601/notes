"""
note that i am using a very brute force algorithm. The goal is to get E2E working before optimization
This algorithm will not work for 1000 request per seconds, because
1. 1 call to broker > 0.5 ms
2. broker does majority write > 0.5ms network + 0.1 ms SSD write
3. 0.5m network + 0.1 ms SSD write for DB,i.e., this pseudo code can support 500 msg/sec max
The hard limit time alone is already 2 ms per message
"""

domain_to_last_offset = read_msgLogMeta()
domain_to_topic = read_domain_to_kafka_from_config()
for domain, last_offset in domain_to_last_offset.items():
    for offset, message in read_log_msg(last_offset).items():
        sync_send_to_kafka(domain_to_topic[domain], message)
        txn = begin_txn()
        delete_msg(txn, domain, offset)
        update_offset(txn, domain, offset)
        commit_txn(txn)
        topic_to_last_offset[topic] = offset

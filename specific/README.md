# Specific Technologies & Data Infrastructure

> Deep-dive operational notes, production cheat sheets, configuration parameters, and architectural internals for specific databases, messaging systems, security tools, and observability platforms.

---

## 📑 Technologies Index

| Technology | Directory / File | Core Topics & Content |
| :--- | :--- | :--- |
| **TiDB** | [`tidb/`](tidb/) \| [`tidb/README.md`](tidb/README.md) | Distributed SQL architecture, TiKV storage engine, Placement Driver (`pd_ctl`), RocksDB engine tuning, Binlog replication, Data Migration (`dm.md`), connection management, hot regions, lock resolution, and K8s Operator. |
| **Kafka** | [`kafka/`](kafka/) | Distributed streaming, Exactly-Once Semantics (`exactlyOnce.md`), Confluent Cloud operations (`confluent_cloud.md`), Avro schema registry (`avro.txt`), Kafka Connect (`kafkaConnect.txt`), Kafka Streams (`kafkaStream.txt`), and CLI operations (`op`). |
| **HashiCorp Vault** | [`vault/`](vault/) | PKI / Internal Certificate Authority (`ca.md`, `ca.sh`), transit encryption as a service (`transit.md`), AWS IAM authentication (`iamAuth.md`, `iam.json`), Let's Encrypt integration, REST API operations (`rest.sh`, `authRest.sh`), and production best practices (`bestPractices.md`). |
| **MySQL / Aurora** | [`mysql/`](mysql/) | InnoDB transaction isolation & locking (`txn.md`), replication topologies (`rep.md`), query profiling & Percona Toolkit (`pt`), JDBC & connection pooling (`jdbc.md`), InnoDB redo/undo logs (`log.md`), Aurora architecture (`aurora`), and DB maintenance scripts (`op.sql`, `mysqlInit.sh`). |
| **Elasticsearch** | [`es/`](es/) | Cluster profiling and tuning (`profile.md`), log aggregation architectures (`log.md`), Fluentd ingestion pipelines (`fluentd`), Kibana dashboards (`kibana.md`), and index management (`op.sh`, `0.md`). |
| **Databricks & Spark** | [`dbx/`](dbx/) | Delta Lake ACID transactions and time travel (`delta.md`), Spark optimization & execution plans (`spark`), Attribute-Based Access Control (`abac.md`), cluster sizing (`misc.md`). |
| **Redis** | [`redis/`](redis/) | Caching topologies, cache stampede & invalidation (`cache.md`), geospatial queries (`geo.md`), memory policies and CLI operations (`op`). |
| **Consul** | [`consul/`](consul/) | Multi-datacenter federation (`multiDC.md`), disaster recovery & outage handling (`outage.md`), service discovery REST API (`rest`, `op.sh`, `0.md`). |
| **Prometheus** | [`prom/`](prom/) | Alertmanager rule design (`alert.md`), client metric instrumentation (`client.md`), PromQL query patterns (`q.md`), scrape configs (`misc.md`). |
| **ClickHouse** | [`clickhouse.md`](clickhouse.md) | High-performance columnar storage, MergeTree family engines, vectorized query execution. |
| **CockroachDB** | [`cockroachdb/`](cockroachdb/) | Distributed SQL consensus (Raft), multi-region survivability, serializable transactions (`0.md`). |
| **PostgreSQL** | [`pg.md`](pg.md) | MVCC, indexing strategies (B-Tree, GIN, GiST), WAL, vacuuming, and connection pooling. |
| **Google Cloud Spanner** | [`spanner.md`](spanner.md) | TrueTime synchronization, distributed transactions, schema design, and query optimization. |
| **Nginx** | [`nginx.md`](nginx.md) | Reverse proxy configuration, load balancing algorithms, SSL termination, rate limiting, and HTTP/2. |

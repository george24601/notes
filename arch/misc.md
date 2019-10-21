### Graph model 

When relation is mostly unrelated or 1-n, document model is more suitable

but as # of n-n relationship grows, relational and then graph model becomes more appropriate

Note that for vs and edges, they don't need to be of homogenous type at all =>
vertices:
1. uid
2. k-v pairs for properties
3. set of incoming edges
4. set of out going edges

edges
1. uid
2. k-v pairs for properties
3. marks what kind of relationship this edge represets
4. both ends of the edge

This naturally means we can store vs and es into 2 different edges

### Search

spider->web -> build_data

search_data -> index -> rank

* search + build data to build index
* build index will generate the inversed index
* search index will analyze the search keywaord, and filter it roughtly by the search idnex
* rank will score and sort results, rank will return the first page result
* may parallize bucket search by partitioning by ranges
* can use bitmap and to improve the performance
* skip list to the most common appraoch for ordered LL union problem, to logn
* separate day db, hour data, month db, change only the hour db, and divide & conquer the search result

Hash vs range partition, range parititon has better extensibiilty with pre-defined block ranges (need help with incremental id)

### Time and order in distributed system
Cassandra => asumes clocks are synchronized, uses timestamps to revole conflicts between writes
alternative=> use vector clocks

Spanner: TrueTime: synch time but also estimates worst-case clock drift

Photon: rely on TrueTime heavily to generate id, and define time boundaries

partial order: anti-symmetry, transitivity, and reflexivity, but NOT totality
local clock order: partial order

time are used to determine if it high-latency or network link down: timeout

### Lamport lock and vector lock

lamport lock: provides parital order
1.Whenever process does work, increase counter
2.whenever process sends a message, include the counter
3.when a message is recieved, set the counter to max(local, received) + 1

if counter(a) LT  count(b), either a happens before b, or a, b are not comparable

vector lock: maintains array of N logical clocks. each node increment its own clock by 1 for each internal event
similar to lamport clock, upon recieving a message, update local to max, AND THEN increase its own clock by 1 more

### Time series
(UserId, TimeStamp) - naturally sharded by the UserId

Suppose we have an aggregate query on CompanyId and TS, but no userId, but our raw data has all 3 fields 

(Company, UserId, TimeStamp) - big company hotspot problem

Now we need an index on (CompanyId, TS)

(UserId, Company, TimeStamp, EntryShardId) - an EntryShardId,ie., acts as logical shard

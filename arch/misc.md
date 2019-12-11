99.9%: LT 9 hours per year 

reverse proxy layer: nginx keepalived + virtual ip

web server layer: configs web servers behind nginx

write db: mater + shadow master with keepalived + virtual IP


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



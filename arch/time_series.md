(UserId, TimeStamp) - naturally sharded by the UserId

Suppose we have an aggregate query on CompanyId and TS, but no userId, but our raw data has all 3 fields 

(Company, UserId, TimeStamp) - big company hotspot problem

Now we need an index on (CompanyId, TS)

(UserId, Company, TimeStamp, EntryShardId) - an EntryShardId,ie., acts as logical shard

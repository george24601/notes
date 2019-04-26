Note it does not support SP, View, trigger, UDF, FK 

incremental id is good, NOT good for flash sale use case. TiDB is not good case for flash sales in general

watch out for the case where index and shard data are not on the same shard : two cases where double scan won't be a problem! 

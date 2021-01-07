A profile is returned for each shard that participated in the response, and is identified by a unique ID.

the top level element in the profile response is an array of shard objects. Each shard object lists its id which uniquely identifies the shard. The ID’s format is [nodeID][indexName][shardID].

As with other statistics apis, the Profile API supports human readable outputs. This can be turned on by adding ?human=true 

The details provided by the Profile API directly expose Lucene class names and concepts, which means that complete interpretation of the results require fairly advanced knowledge of Lucene.

It should be noted that Collector times are independent from the Query times. 

`create_weight`: To get around this, Lucene asks each query to generate a Weight object which acts as a temporary context object to hold state associated with this particular (IndexSearcher, Query) tuple. The weight metric shows how long this process takes

`build_scorer`: A Scorer is the mechanism that iterates over matching documents and generates a score per-document (e.g. how well does "foo" match the document?). Note, this records the time required to generate the Scorer object, not actually score the documents. Some queries have faster or slower initialization of the Scorer, depending on optimizations, complexity, etc.

`next_doc`: This statistic shows the time it takes to determine which document is the next match, a process that varies considerably depending on the nature of the query. is a specialized form of advance() which is more convenient for many queries in Lucene. It is equivalent to advance(docId() + 1)

`advance`: advance is the "lower level" version of next_doc: it serves the same purpose of finding the next matching doc, but requires the calling query to perform extra tasks such as identifying and moving past skips, etc. However, not all queries can use next_doc, so advance is also timed for those queries.

`*_count`: Records the number of invocations of the particular method. For example, "next_doc_count": 2, means the nextDoc() method was called on two different documents. 

The time_in_nanos is similar to the time in the Query tree: a wall-clock time inclusive of all children.


The recovery process implicitly commits all outstanding Raft log entries, so it's also possible to commit data that was uncommitted before the failure.

You simply include just the remaining servers in the raft/peers.json recovery file. The cluster should be able to elect a leader once the remaining servers are all restarted with an identical raft/peers.json configuration.

In extreme cases, it should be possible to recover with just a single remaining server by starting that single server with itself as the only peer in the raft/peers.json recovery file.

the peers.json file is no longer present by default and is only used when performing recovery. This file will be deleted after Consul starts and ingests this file.

For peers.json

You must confirm that servers you do not include here have indeed failed and will not later rejoin the cluster. Ensure that this file is the same across all remaining server nodes.

Need to rejoin the cluster manually - gracefully

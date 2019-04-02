The separation of logic stems from the fact that Raft makes leader election a separate and mandatory step before the leader can get the data replicated where as a Paxos implementation would make the leader election process an implicit outcome of reaching agreement through data replication.

Finally, Raft imposes the restriction that only the servers with most up-to-date data can become leaders. These optimizations radically simplify edge cases in which a succession of leadership changes can result in data discrepancies, but the tradeoff is that leader election in Raft can be more complicated than its counterpart in Paxos.



### old notes

Leader election: Raft uses randomized timers to elect leaders. This adds only a small amount of mechanism to the heartbeats already required for any consensus algorithm, while resolving conflicts sim- ply and rapidly.

Membership changes: Raft’s mechanism for changing the set of servers in the cluster uses a new joint consensus approach where the majorities of two different configurations overlap during transi- tions. This allows the cluster to continue operating normally during configuration changes.

-------

For example, large-scale systems that have a single cluster leader, such as GFS [8], HDFS [38], and RAMCloud [33], typically use a separate replicated state machine to manage leader election and store config- uration information that must survive leader crashes. Ex- amples of replicated state machines include Chubby [2] and ZooKeeper [11].

Keeping the replicated log consistent is the job of the consensus algorithm. The consensus module on a server receives commands from clients and adds them to its log. It communicates with the consensus modules on other servers to ensure that every log eventually contains the same requests in the same order, even if some servers fail. Once commands are properly replicated, each server’s state machine processes them in log order, and the out- puts are returned to clients. As a result, the servers appear to form a single, highly reliable state machine.


------

3 major parts:
1. leader election
2. log replication
3. safety

At any given time each server is in one of three states: leader, follower, or candidate. In normal operation there is exactly one leader and all of the other servers are fol- lowers. Followers are passive: they issue no requests on their own but simply respond to requests from leaders and candidates. The leader handles all client requests (if a client contacts a follower, the follower redirects it to the leader). The third state, candidate, is used to elect a new leader

R
aft divides time into terms of arbitrary length, as shown in Figure 5. Terms are numbered with consecutive integers. Each term begins with an election, in which one or more candidates attempt to become leader as described in Section 5.2. If a candidate wins the election, then it serves as leader for the rest of the term. In some situations an election will result in a split vote. In this case the term will end with no leader; a new term (with a new election)

 Terms act as a logical clock [14] in Raft, and they allow servers to detect obsolete information such as stale leaders. Each server stores a current term number, which increases monotonically over time. Current terms are exchanged whenever servers communicate; if one server’s current term is smaller than the other’s, then it updates its current term to the larger value. If a candidate or leader discovers that its term is out of date, it immediately reverts to fol- lower state. If a server receives a request with a stale term number, it rejects the request.

the basic consensus algorithm requires only two types of RPCs. RequestVote RPCs are initiated by candidates during elections (Section 5.2), and Append- Entries RPCs are initiated by leaders to replicate log en- tries and to provide a form of heartbeat (Section 5.3). Sec- tion 7 adds a third RPC for transferring snapshots between servers. Servers retry RPCs if they do not receive a re- sponse in a timely manner, and they issue RPCs in parallel for best performance.

-------
aft uses a heartbeat mechanism to trigger leader elec- tion. When servers start up, they begin as followers. A server remains in follower state as long as it receives valid
RPCs from a leader or candidate. Leaders send periodic heartbeats (AppendEntries RPCs that carry no log entries) to all followers in order to maintain their authority. If a follower receives no communication over a period of time called the election timeout, then it assumes there is no vi- able leader and begins an election to choose a new leader.

To begin an election, a follower increments its current term and transitions to candidate state. It then votes for itself and issues RequestVote RPCs in parallel to each of the other servers in the cluster. A candidate continues in this state until one of three things happens: (a) it wins the election, (b) another server establishes itself as leader, or (c) a period of time goes by with no winner.

While waiting for votes, a candidate may receive an AppendEntries RPC from another server claiming to be leader. If the leader’s term (included in its RPC) is at least as large as the candidate’s current term, then the candidate recognizes the leader as legitimate and returns to follower state. If the term in the RPC is smaller than the candidate’s current term, then the candidate rejects the RPC and con- tinues in candidate state.

The third possible outcome is that a candidate neither wins nor loses the election: if many followers become candidates at the same time, votes could be split so that no candidate obtains a majority. When this happens, each candidate will time out and start a new election by incre- menting its term and initiating another round of Request- Vote RPCs. However, without extra measures split votes could repeat indefinitely.
-------

Once a leader has been elected, it begins servicing client requests. Each client request contains a command to be executed by the replicated state machines. The leader appends the command to its log as a new entry, then is- sues AppendEntries RPCs in parallel to each of the other servers to replicate the entry. When the entry has been safely replicated (as described below), the leader applies the entry to its state machine and returns the result of that execution to the client. If followers crash or run slowly, or if network packets are lost, the leader retries Append- Entries RPCs indefinitely (even after it has responded to the client) until all followers eventually store all log en- tries.

Each log en- try stores a state machine command along with the term number when the entry was received by the leader. The term numbers in log entries are used to detect inconsis- tencies between logs and to ensure some of the properties in Figure 3.

The leader keeps track of the highest index it knows to be committed, and it includes that index in future AppendEntries RPCs (including heartbeats) so that the other servers eventually find out. Once a follower learns that a log entry is committed, it applies the entry to its local state machine (in log order).

When send- ing an AppendEntries RPC, the leader includes the index and term of the entry in its log that immediately precedes the new entries. If the follower does not find an entry in its log with the same index and term, then it refuses the new entries.

A follower may be missing entries that are present on the leader, it may have extra entries that are not present on the leader, or both. Missing and extraneous entries in a log may span multiple terms.

the leader must find the latest log entry where the two logs agree, delete any entries in the follower’s log after that point, and send the follower all of the leader’s entries after that point. All of these actions happen in response to the consistency check performed by AppendEntries RPCs. The leader maintains a nextIndex for each follower, which is the index of the next log entry the leader will send to that follower. When a leader first comes to power, it initializes all nextIndex values to the index just after the last one in its log (11 in Figure 7). If a follower’s log is inconsistent with the leader’s, the AppendEntries consis- tency check will fail in the next AppendEntries RPC. Af- ter a rejection, the leader decrements nextIndex and retries the AppendEntries RPC. Eventually nextIndex will reach a point where the leader and follower logs match. When this happens, AppendEntries will succeed, which removes any conflicting entries in the follower’s log and appends entries from the leader’s log (if any). Once AppendEntries succeeds, the follower’s log is consistent with the leader’s, and it will remain that way for the rest of the term.

--------

Raft uses the voting process to prevent a candidate from winning an election unless its log contains all committed entries. A candidate must contact a majority of the cluster in order to be elected, which means that every committed entry must be present in at least one of those servers. If the candidate’s log is at least as up-to-date as any other log in that majority

Raft determines which of two logs is more up-to-date by comparing the index and term of the last entries in the logs. If the logs have last entries with different terms, then the log with the later term is more up-to-date. If the logs end with the same term, then whichever log is longer is more up-to-date.

-------

If a leader crashes be- fore committing an entry, future leaders will attempt to finish replicating the entry. However, a leader cannot im- mediately conclude that an entry from a previous term is committed once it is stored on a majority of servers.

Raft never commits log entries from previous terms by count- ing replicas. Only log entries from the leader’s current term are committed by counting replicas; once an entry from the current term has been committed in this way, then all prior entries are committed indirectly because of the Log Matching Property


-------

5.4.3 Safety argument!!!

--------

If a follower or candidate crashes, then fu- ture RequestVote and AppendEntries RPCs sent to it will fail. Raft handles these failures by retrying indefinitely; if the crashed server restarts, then the RPC will complete successfully. If a server crashes after completing an RPC but before responding, then it will receive the same RPC again after it restarts. Raft RPCs are idempotent,
-------
broadcastTime ≪ electionTimeout ≪ MTBF
In this inequality broadcastTime is the average time it takes a server to send RPCs in parallel to every server in the cluster and receive their responses; electionTime- out is the election timeout described in Section 5.2; and MTBF is the average time between failures for a single server. 

--------
Unfortunately, any approach where servers switch directly from the old configuration to the new configura- tion is unsafe. It isn’t possible to atomically switch all of the servers at once, so the cluster can potentially split into two independent majorities during the transition 

In Raft the cluster first switches to a transitional configuration we call joint consensus; once the joint consensus has been committed, the system then transitions to the new configuration. The joint consensus combines both the old and new configu- rations:
• Log entries are replicated to all servers in both con- figurations.
Any server from either configuration may serve as leader.
• Agreement (for elections and entry commitment) re- quires separate majorities from both the old and new configurations.


Cluster configurations are stored and communicated using special entries in the replicated log; Figure 11 illus- trates the configuration change process. When the leader receives a request to change the configuration from Cold to Cnew, it stores the configuration for joint consensus (Cold,new in the figure) as a log entry and replicates that entry using the mechanisms described previously. Once a given server adds the new configuration entry to its log, it uses that configuration for all future decisions (a server always uses the latest configuration in its log, regardless of whether the entry is committed). This means that the leader will use the rules of Cold,new to determine when the log entry for Cold,new is committed. If the leader crashes, a new leader may be chosen under either Cold or Cold,new, depending on whether the winning candidate has received Cold,new. In any case, Cnew cannot make unilateral deci- sions during this period.

Once Cold,new has been committed, neither Cold nor Cnew can make decisions without approval of the other, and the Leader Completeness Property ensures that only servers with the Cold,new log entry can be elected as leader. It is now safe for the leader to create a log entry describing Cnew and replicate it to the cluster. Again, this configura- tion will take effect on each server as soon as it is seen. When the new configuration has been committed under the rules of Cnew, the old configuration is irrelevant and servers not in the new configuration can be shut down. 

The second issue is that the cluster leader may not be part of the new configuration. In this case, the leader steps down (returns to follower state) once it has committed the Cnew log entry. This means that there will be a period of time (while it is committing Cnew ) when the leader is man- aging a cluster that does not include itself; it replicates log entries but does not count itself in majorities. The leader transition occurs when Cnew is committed because this is the first point when the new configuration can operate in- dependently (it will always be possible to choose a leader from Cnew ). Before this point, it may be the case that only a server from Cold can be elected leader.

servers disregard RequestVote RPCs when they believe a current leader exists. Specif- ically, if a server receives a RequestVote RPC within the minimum election timeout of hearing from a cur- rent leader, it does not update its term or grant its vote. This does not affect normal elections, where each server waits at least a minimum election timeout before starting an election. However, it helps avoid disruptions from re- moved servers: if a leader is able to get heartbeats to its cluster, then it will not be deposed by larger term num- bers.

--------
Each server takes snapshots independently, covering just the committed entries in its log. Most of the work con- sists of the state machine writing its current state to the snapshot. Raft also includes a small amount of metadata in the snapshot: the last included index is the index of the last entry in the log that the snapshot replaces (the last en- try the state machine had applied), and the last included term is the term of this entry. These are preserved to sup- port the AppendEntries consistency check for the first log entry following the snapshot, since that entry needs a pre- vious log index and term. To enable cluster membership changes (Section 6), the snapshot also includes the latest configuration in the log as of last included index.

Although servers normally take snapshots indepen- dently, the leader must occasionally send snapshots to followers that lag behind. This happens when the leader has already discarded the next log entry that it needs to send to a follower. 

When a follower receives a snapshot with this RPC, it must decide what to do with its existing log en- tries. Usually the snapshot will contain new information not already in the recipient’s log. In this case, the follower discards its entire log; it is all superseded by the snapshot and may possibly have uncommitted entries that conflict with the snapshot. If instead the follower receives a snap- shot that describes a prefix of its log (due to retransmis- sion or by mistake), then log entries covered by the snap- shot are deleted but entries following the snapshot are still valid and must be retained.

One simple strategy is to take a snapshot when the log reaches a fixed size in bytes. If this size is set to be significantly larger than the expected size of a snapshot, then the disk bandwidth over- head for snapshotting will be small.

------

Clients of Raft send all of their requests to the leader. When a client first starts up, it connects to a randomly- chosen server. If the client’s first choice is not the leader, that server will reject the client’s request and supply in- formation about the most recent leader it has heard from (AppendEntries requests include the network address of the leader). If the leader crashes, client requests will time out; clients then try again with randomly-chosen servers.

crashes after committing the log entry but before respond- ing to the client, the client will retry the command with a new leader, causing it to be executed a second time. The solution is for clients to assign unique serial numbers to every command. Then, the state machine tracks the latest serial number processed for each client, along with the as- sociated response. If it receives a command whose serial number has already been executed, it responds immedi- ately without re-executing the request.


However, with no additional mea- sures, this would run the risk of returning stale data, since the leader responding to the request might have been su- perseded by a newer leader of which it is unaware. Lin- earizable reads must not return stale data, and Raft needs two extra precautions to guarantee this without using the log. First, a leader must have the latest information on which entries are committed. The Leader Completeness Property guarantees that a leader has all committed en- tries, but at the start of its term, it may not know which those are. To find out, it needs to commit an entry from its term. Raft handles this by having each leader com- mit a blank no-op entry into the log at the start of its term. Second, a leader must check whether it has been de- posed before processing a read-only request (its informa- tion may be stale if a more recent leader has been elected). Raft handles this by having the leader exchange heart- beat messages with a majority of the cluster before re- sponding to read-only requests


1.leader mains heartbeat which allows the followers to detect if the leader fails or beocmes partitioned
2.when a node detects a leader has become no-responsive, go into candiate state, and increment the epoch value by 1
3. a node recieve a majority of the votes becomes the new leader: vote as in first-come first-served. candidates themselves waits a random
time before bids


Practical considerations
1. repeated leader election
2. repeated propose messages
3. followers and proposers do not lose items in stable storage/not corrupted
4. cluster membership change. Majority rule does not hold if the membership change change arbitrarility
5. bring replica up to date in a safe and efficient manner
6. snapshoting and GCing data. required to guarantee satefy after some reasonable period



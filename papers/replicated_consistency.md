Questions
---------

1. What are other systems where some of the weaker consistency guarantees are applicable?

2. What type of app-specific knowledge matters when determining the "right" consistency guarantee?

3. What is a consistency guarantee? What aspects of a system does it affect?

4. How does a system designer choose an appropriate consistency guarantee?

5. Why does the choice of consistency guarantee matter?




Eventual consistency is insufficient for most of the participants, but strong consistency is not needed either. 

While strong consistency is desirable and reasonable to provide within a datacenter, it raises concerns as systems start to offer geo-replicated services that span multiple datacenters on multiple continents

Consistency guarantees
----------

1. Strong Consistency: See all previous writes

2. Eventual Consistency: See subset of previous writes

3. Consistent Prefix: See initial sequence of writes

4. Bounded Staleness: See all “old” writes.

5. Monotonic Reads: See increasing subset of writes. 

6. Read My Writes: See all writes performed by reader


Scorekeeper
-----------
```

score = Read (“visitors”);
 Write (“visitors”, score + 1);

```

Interestingly, while the scorekeeper requires strongly consistent data, he does not need to perform strong consistency reads. Since the scorekeeper is the only person who updates the score, he can request the read my writes guarantee and receive the same effect as a strong read. Essentially, the scorekeeper uses applicationspecific knowledge to obtain the benefits of a weaker consistency read without actually giving up any consistency.

 In processing a strong consistency read the storage system must pessimistically assume that some client, anywhere in the world, may have just updated the data. The system therefore must access a majority of servers (or a fixed set of servers) in order to ensure that the most recently written data is accessed by the submitted read operation. In providing the read my writes guarantee, on the other hand, the system simply needs to record the set of writes that were previously performed by the client and find some server that has seen all of these writes. 


Umpire
--------

```
vScore = Read (“visitors”);
 hScore = Read (“home”);
 if vScore < hScore
 end game;

```

Thus, in order to receive up-to-date information, the umpire must perform strong consistency reads.

Radio reporter
------

```

do {
 vScore = Read (“visitors”);
 hScore = Read (“home”);
 report vScore and hScore;
 sleep (30 minutes);
 }

```

 Since everyone knows that baseball scores are monotonically increasing, reporting scores of 2-5 and 1-3 in subsequent news reports would make the reporter look foolish. This can be avoided if the reporter requests the monotonic reads guarantee in addition to requesting a consistent prefix

Observe that neither guarantee is sufficient by itself.
Alternatively, the reporter could obtain the same effect as a monotonic read by requesting bounded staleness with a bound of less than 30 minutes. 

Sportswriter
--------

```
While not end of game {
 drink beer;
 smoke cigar;
 }
 go out to dinner;
 vScore = Read (“visitors”);
 hScore = Read (“home”);
 write article;

```

In fact, an eventual consistency read is likely to return the correct score after an hour, but requesting bounded staleness is the only way for the sportswriter to be 100% certain that he is obtaining the final score.

Statistician
---------

```
Wait for end of game;
 score = Read (“home”);
 stat = Read (“season-runs”);
 Write (“season-runs”, stat + score);
```

When reading the team’s score from today, the statistician wants to be sure to obtain the final score. Thus, she
needs to perform a strong consistency read. If the statistician waits for some time after the game, then a
bounded staleness read may achieve the same effect (as discussed in Section 4.4 for the sportswriter).

When reading the current statistics for the season, i.e. for the second read operation in Figure 8, the statistician
also wants strong consistency. If an old statistic is returned, then the updated value written back will
undercount the team’s total runs. Since the statistician is the only person who writes statistics into the data
store, she can use the read my writes guarantee to get the latest value (as discussed in Section 4.1 for the
scorekeeper).

Stat watcher
---------
do {
 stat = Read (“season-runs”);
 discuss stats with friends;
 sleep (1 day);
 }

can perform an eventual consistency read to get a reasonable answer.


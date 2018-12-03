"Timeouts," instead, are normally used to alert the kernel to an expected event that has failed to arrive — a missing network packet or I/O completion interrupt, for example. The accuracy requirements for these timers are less stringent (it doesn't matter if an I/O timeout comes a few milliseconds late), and, importantly, these timers are usually canceled before they expire. The timer wheel is used for the latter variety of timers.

### from kafka page

How can we efficiently keep track of tens of thousands of requests that are being asynchronously satisfied by other activity in the cluster?

In the old design, it used Java DelayQueue to implement the timer.

When a request is completed, the request is not deleted from the timer or watcher lists immediately. Instead, completed requests are deleted as they were found during condition checking. When the deletion does not keep up, the server may exhaust JVM heap and cause OutOfMemoryError.

To alleviate the situation, a separate thread, called the reaper thread, purges completed requests from the purgatory when the number of requests (either pending or completed) in the purgatory exceeds the configured number. The purge operation scans the timer queue and all watcher lists to find completed requests and deletes them.

By setting this configuration parameter low, the server can virtually avoid the memory problem. However, the server must pay a significant performance penalty if it scans all lists too frequently.

A simple timing wheel is a circular list of buckets of timer tasks. Let u be the time unit. A timing wheel with size n has n buckets and can hold timer tasks in n * u time interval.

Every interval of time unit u, the timer ticks and moved to the next bucket then expire all timer tasks in it. So, the timer never inserts a task into the bucket for the current time since it is already expired. The timer immediately runs the expired task.

A timing wheel has O(1) cost for insert/delete (start-timer/stop-timer) whereas priority queue based timers, such as java.util.concurrent.DelayQueue and java.util.Timer, have O(log n) insert/delete cost. Note that neither DelayQueue or Timer supports random delete.

If a timer request is out of this interval, it is an overflow. A hierarchical timing wheel deals with such overflows.

If the resolution of a wheel at one level is u and the size is n, the resolutions should be n * u in the second level, n^2 * u in the third level, and so on.

When the wheel in the higher level ticks, it reinsert timer tasks to the lower level. An overflow wheel can be created on-demand. When a bucket in an overflow bucket expires, all tasks in it are reinserted into the timer recursively. The tasks are then moved to the finer grain wheels or be executed. The insert (start-timer) cost is O(m) where m is the number of wheels, which is usually very small compared to the number of requests in the system, and the delete (stop-timer) cost is still O(1).

It would be nice if a thread wakes up only when there is a non-empty bucket to expire. The new purgatory does so by using java.util.concurrent.DelayQueue similarly to the old implementation, but we enqueue task buckets instead of individual tasks.

A timer task instance saves a link cell in itself when enqueued to a timer queue. When a task is completed or canceled, the list is updated using the link cell saved in the task itself.

In the new design, a completed request is removed from the timer queue immediately with O(1) cost.

#### from the original paper

Hashing Wheel with Ordered Timer Lists:

If MaxInterval is comparatively large (e.g. 32-bit timers), simple timing wheels can use a lot of memory. Instead of using one slot per time unit, we could use a form of hashing instead. Construct a circular buffer with a fixed number of slots – a power of 2 for efficiency and have the current time index advance one position in the ring on a tick as before. To insert a timer that expires j time units in the future, compute a slot delta s = j % num-buckets . Insert the timer s slots around the ring with its time of expiry. Since there may be many timers in any given slot, we maintain an ordered list of timers for each slot.

This is a variant on scheme 5 where instead of storing absolute time of expiry we store a count of how many times around the ring each timer is in the future. To insert a timer that expires j time units in the future, compute a counter value c = j / num-buckets and a slot delta s = j % num-buckets . Insert the timer s slots around the ring with its counter value c. Keep the timers in an unordered list in each slot.

Starting a timer now has both worst and average case O(1), and per-tick bookkeeping is worst case O(n) , but O(1) on average.

Suppose we want to store timers with second granularity, that can be set for up to 100 days in the future. We might construct four wheels:

* A days wheel with 100 slots
* An hours wheel with 24 slots
* A minutes wheel with 60 slots
* A seconds wheel with 60 slots

This is a total of 244 slots to address a total of 8.64 million possible timer values. Every time we make one complete revolution in a wheel, we advance the next biggest wheel by one slot

For example, when the seconds wheel has rotated back to index ‘0’ we move the index pointer in the minutes wheel round by one position. We then take all the timers in that slot on the minutes wheel (which are now due to expire within the next 60 seconds) and insert them into their correct positions in the seconds wheel.

To insert a timer, find the first wheel (from largest units to smallest) for which the timer should expire 1 or more wheel-units into the future. For example, a timer due to expire 11 hours, 15 minutes and 15 seconds into the future would be inserted at slot ‘current-index + 11’ in the hours wheel , storing the remainder of 15 minutes and 15 seconds with the timer. After the hours wheel has advanced by 11 positions, this timer will be removed from that wheel and inserted at ‘current index + 15’ slots round in the minutes wheel, storing the remainder of 15 seconds. When the minutes wheel has subsequently advanced by 15 positions, this timer will be removed from the wheel and placed in the seconds wheel at ‘current index + 15’ slots round in the seconds wheel. 15 seconds later, the timer will expire!

if you just get given timers as e.g. t seconds in the future for up to a 32 bit timer value, then it would be more efficient to simply divide this into four wheels with 28 slots in each, or similar (which makes it very efficient to determine which wheel an entry should go in).

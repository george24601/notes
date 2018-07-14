long polling: set up a from brower to web-server HTTP connection - only used to receive push notificaiton. server side will hold it, until push notification received, our time out. May need to empty ping from time to time as heatbeat to avoid timeout

system push to 1 - use cache to greating speed up process

daily system notification - display notification only first time user logs in today - use polling, and keep track of the last polled time.

notification to group member - 1 copy, for each member, keep a last_ack_time. Use client to dedup in case of repeated push/lost ACK problem. Note that the read ack data is not critical - for read info, we can just delete, and archive or delete timeouted ones 

Twitter-ish system
---------

1. each user has a feed queue to record all feeds it sends, but read performance will be affect as feed needs to be generate on the fly. 

2. Need seperate table to store user-> fan, and user -> follows, for write and read broadcast

3. each user also stores feeds it received. But broadcasting a feed process is slightly harder.

4. optimization: 

	1. instead of push msgid, renew fans unprocess # of counts

	2. separate user into groups, only push for active users 

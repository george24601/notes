#It is best to run iostat specifying a time interval in seconds (for example iostat -x 30)

#Display a continuous device report at two second intervals
iostat -dc 10

<<COLUMNS
rrqm/s: The number of read requests merged per second that were queued to the device

rsec/s: The number of sectors read from the device per second.

avgrq-sz:The average size (in sectors) of the requests that were issued to the device.

await:The average time (in milliseconds) for I/O requests issued to the device to be served. This includes the time spent by the requests in queue and the time spent servicing them.

%util
Percentage of CPU time during which I/O requests were issued to the device (bandwidth utilization for the device). Device saturation occurs when this value is close to 100%.

COLUMNS

#also checkout netstat

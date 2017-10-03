# -nn host or port name not resolved
sudo tcpdump -nn

#-S changes the display of sequence nubmers to absolute
#-s $BYTES_TO_CAP , default 96
#-i any : Listen on all interfaces just to see if you’re seeing any traffic

#look for traffic based on IP address
sudo tcpdump host $HOST_IP

#look for traffic from/to with src/dst

#-X: show the packet's contents
#-w $target_fiile : dump content to a text file
sudo tcpdump -nn -w d1

sudo tcpdump -nn -XX -w d1 host 172.16.100.64

#-r $target_fiile : load the file written by -w
sudo tcpdump -nn -XX -r d1

sudo tcpdump -nn -r d1

<<SAMPLE
00:34:41.474225 IP willow.csail.mit.edu.39675 > maple.csail.mit.edu.5001: Flags [.], seq 1473:2921, ack 1, win 115, options [nop,nop,TS val 282136474 ecr 282202089], length 1448

The time stamp 00:34:41.474225 denotes the time at which the packet was transmitted by willow.
The above packet has a sequence number 1473:2921, indicating that it contains all bytes from byte #1473 to byte #2920 (= 2921 - 1) in the stream, which is a total of 1448 bytes.

00:34:41.482047 IP maple.csail.mit.edu.5001 > willow.csail.mit.edu.39675: Flags [.], ack 2921, win 159, options [nop,nop,TS val 282202095 ecr 282136474], length 0

In reality, the ACK reflects the next byte that the receiver expects. The above ACK indicates that maple has received all bytes from byte #0 to byte #2920. The next byte that maple expects is byte #2921. The time stamp 00:34:41.482047, denotes the time at which the ACK was received by willow.
SAMPLE

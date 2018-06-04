<<COMMON

-i : Select interface that the capture is to take place on, this will often be an ethernet card or wireless adapter but could also be a vlan or something more unusual. Not always required if there is only one network adapter. "any" means all interfaces

-nn : A single (n) will not resolve hostnames. A double (nn) will not resolve hostnames or ports. This is handy for not only viewing the IP / port numbers but also when capturing a large amount of data, as the name resolution will slow down the capture.
-s0 : Snap length, is the size of the packet to capture. -s0 will set the size to unlimited - use this if you want to capture all the traffic. Needed if you want to pull binaries / files from network traffic.
-v : Verbose, using (-v) or (-vv) increases the amount of detail shown in the output, often showing more protocol specific information.
port 80 : this is a common port filter to capture only traffic on port 80, that is of course usually HTTP.

COMMON
sudo tcpdump -i eth0 -nn -s0 -v port 80

sudo tcpdump -A -s0 port 80

#-S changes the display of sequence nubmers to absolute
#-s $BYTES_TO_CAP , default 96

#look for traffic FROM $IP
sudo tcpdump host $IP

#look for traffic to destination
sudo tcpdump dst $DESTINATION

#find specific $PORT traffic
sudo tcpdump dst port $PORT

#-i any for any network interface
sudo tcpdump -i any dst port 8500

sudo tcpdump -i any dst port 8083

sudo tcpdump -i any dst port 3000

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
In reality, there is one sequence number per byte of data. 
The above packet has a sequence number 1473:2921, indicating that it contains all bytes from byte #1473 to byte #2920 (= 2921 - 1) in the stream, which is a total of 1448 bytes.

00:34:41.482047 IP maple.csail.mit.edu.5001 > willow.csail.mit.edu.39675: Flags [.], ack 2921, win 159, options [nop,nop,TS val 282202095 ecr 282136474], length 0

In reality, the ACK reflects the next byte that the receiver expects. The above ACK indicates that maple has received all bytes from byte #0 to byte #2920. The next byte that maple expects is byte #2921. The time stamp 00:34:41.482047, denotes the time at which the ACK was received by willow.
SAMPLE



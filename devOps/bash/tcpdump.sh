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


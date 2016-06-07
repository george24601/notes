#find jvm thread with highest cpu usage, can use jps to get java process id
#you can also use jps if you know the process name
top -H -p 63847

#find thread 2803, 2833 high cpu usage within that thread

# find java processes
ps axu | grep java

#thread dump
sudo jstack 63847 > 1.log

#need to covert decimal pid to hex
echo "obase=16; 3747" | bc

echo "obase=16; 3777" | bc

#if you need one-off stack, kill -3 would show the dump as well
kill  -3 63847


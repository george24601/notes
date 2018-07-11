#check if port is open and accessible, -z means sending no data, just scanning the daemon
nc -z $HOST $PORT

host $FIND_IP_OF_HOST

#(TLS) Tells curl to use the specified certificate file to verify the peer. The file may contain multiple CA certificates. The certificate(s) must be in PEM format. Normally curl is built to use a default file for this, so this option is typically used to alter that default file.
curl --cacert <file>

#check domain owner info
whois example.com

#check network card, TCP/IP , IP address, subnet mask settings
ping 127.0.0.1

#check local config or installation
ping $LOCAL_IP

#arp to check corresponding IP address's MAC address - network card physical address

#check accept queue
netstat -s | egrep "listen"

#see if server ignores the ACK from client,i.e., server thinks connection is NOT up yet, server will set a reset to server
cat /proc/sys/net/ipv4/tcp_abort_on_overflow

#Recv-Q: data in cache/buffer but not in process yet, also check the ss command
netstate -t

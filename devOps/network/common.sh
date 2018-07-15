#(TLS) Tells curl to use the specified certificate file to verify the peer. The file may contain multiple CA certificates. The certificate(s) must be in PEM format. Normally curl is built to use a default file for this, so this option is typically used to alter that default file.
curl --cacert <file>

#check domain owner info
whois example.com

#check network card, TCP/IP , IP address, subnet mask settings
ping 127.0.0.1

#check local config or installation
ping $LOCAL_IP

#arp to check corresponding IP address's MAC address - network card physical address

#see if server ignores the ACK from client,i.e., server thinks connection is NOT up yet, server will set a reset to server
cat /proc/sys/net/ipv4/tcp_abort_on_overflow

###SSH###
#add cerficicate to the agent
chmod 400 ~/.ssh/id_rsa
#-l to show certs available
ssh-add -K ~/.ssh/id_rsa

#opens a connection to the gw.example.com jump server, and forwards any connection to port 80 on the local machine to port 80 on intra.example.com.
ssh -L 80:intra.example.com:80 gw.example.com

#jump via jump host, make sure ssh-add .pem first!
ssh -tt -A ec2-user@$PUBLIC_JUMP ssh -tt ec2-user@$PRIVATE_JUMP

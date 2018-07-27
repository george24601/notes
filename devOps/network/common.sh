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

#The key here is -L which says we’re doing local port forwarding. Then it says we’re forwarding our local port 9000 to imgur.com:80
ssh -L 9000:imgur.com:80 user@example.com

#An example here is when you need to connect to a database console, which only allows local connection for security reasons. Let’s say you’re running PostgreSQL on your server, which by default listens on the port 5432.
ssh -L 9000:localhost:5432 user@example.com

#First you need to specify the port on which th remote server will listen, which in this case is 9000, and next follows localhost for your local machine, and the local port, which in this case is 3000
#SSH doesn’t by default allow remote hosts to forwarded ports. To enable this open /etc/ssh/sshd_config
#You might have noticed that every time we create a tunnel you also SSH into the server and get a shell. This isn’t usually necessary, as you’re just trying to create a tunnel. To avoid this we can run SSH with the -nNT
ssh -R 9000:localhost:3000 user@example.com





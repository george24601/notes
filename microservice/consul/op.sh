sudo systemctl start consul

#DONT USE DEV MODE FOR PROD
consul agent -dev

./consul members

/bin/consul members


#Note that you have to make sure to point your DNS lookups to the Consul agent's DNS server which runs on port 8600 by default
dig @127.0.0.1 -p 8600 Armons-MacBook-Air.node.consul

#need to do that manually after bootstrap
./consul join $LOCAL_IP_TO_USE

#manually create a cluster, access one of the machines and run the following
./consul join Node-A-Addressh Node-B-Address Node_C_Address

./consul agent -server -bootstrap-expect=3 \ # cluster size, must be same for all members!
-data-dir=~/data \
	-node=agent-one  \ # acts as id, must be unique in the cluster
-bind=$LOCAL_IP_TO_USE \ #local ip you want to use, this also gives hint to which network interface to use
-retry-join "provider=aws tag_key=consul-vault tag_value=consul" \ # turn on auto joining the cluster
-enable-script-checks=true -config-dir=/home/ec2-user/consul.d

mkdir -p /consul/data 


docker run -d --restart=always -p 8300:8300 -p 8301:8301 -p 8301:8301/udp \
	-p 8302:8302 -p 8302:8302/udp -p 8500:8500 -p 8600:8600 -p 8600:8600/udp  \
	-v /consul/data:/consul/data \
	--name consul-server consul:1.0.2 \ 
        agent -server -bootstrap-expect=1 \
	-retry-join "provider=aws tag_key=consul-ecs tag_value=consul" \ 
	-client 0.0.0.0 \
	-advertise $(curl -s http://169.254.169.254/latest/meta-data/local-ipv4) 

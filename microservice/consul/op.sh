./consul agent -server -bootstrap-expect=3 \ # cluster size, must be same for all members!
-data-dir=~/data \
	-node=agent-one  \ # acts as id, must be unique in the cluster
-bind=$LOCAL_IP_TO_USE \ #local ip you want to use, this also gives hint to which network interface to use
-retry-join "provider=aws tag_key=consul-vault tag_value=consul" \ # turn on auto joining the cluster
-enable-script-checks=true -config-dir=/home/ec2-user/consul.d

#run consul docker locally, in client mode
docker run -d --restart=always -p 8300:8300 -p 8301:8301 -p 8301:8301/udp \
	-p 8302:8302 -p 8302:8302/udp -p 8500:8500 -p 8600:8600 -p 8600:8600/udp  \
	--name consul-server consul 

docker stop consul-server && docker rm consul-server && sudo rm -rf /consul

#Running Consul Agent in Client Mode
#docker run -d --net=host -e 'CONSUL_LOCAL_CONFIG={"leave_on_terminate": true}' consul agent -bind=<external ip> -retry-join=<root agent ip>


####backup and restore####
#To create a snapshot and save it as a file called "backup.snap":
export CUR_DATE=$(date +"%m_%d_%Y")
export FROM_HOST=
export TO_HOST=
consul snapshot save backup$CUR_DATE.snap

consul snapshot save backup.snap

scp ec2-user@$FROM_HOST:/home/ec2-user/backup.snap .

scp backup.snap ec2-user@$TO_HOST:/home/ec2-user/

#To restore a snapshot from a file called "backup.snap":
consul snapshot restore backup.snap

#To inspect a snapshot from the file "backup.snap":
consul snapshot inspect backup.snap

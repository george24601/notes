#start c*
docker run -d -p 9042:9042 -v $(PWD)/init.cql:/cqls/init.cql --name cas-testing cassandra:2.1.15 

#polling until container is up
n=0
LIMIT=30
until [ $n -ge $LIMIT ]
do
 	docker exec -it cas-testing bash -c "cqlsh -e exit" 2>&1 > /dev/null && break
	n=$[$n+1]
	sleep 1
	echo -n "."
done


docker exec -it cas-testing bash -c "cqlsh -f /cqls/init.cql"


<<COMMENT
docker inspect -f {{.State.Running}} cas-testing


docker exec -it cas-testing bash

cqlsh -f /cqls/init.cql

docker rm -f cas-testing
COMMENT

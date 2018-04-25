#local in-mem storage only
bin/standalone.sh

http://localhost:8080/auth/realms/$REALM/account

docker network create keycloak-network   

#start mysql
docker run --name mysql -d --net keycloak-network -e MYSQL_DATABASE=keycloak -e MYSQL_USER=keycloak -e MYSQL_PASSWORD=password -e MYSQL_ROOT_PASSWORD=root_password mysql:5.7.22

#Inside mysql container
#login as root
mysql -P 3306 -u root -p

#login as keycloak
mysql -P 3306 -u keycloak -p

docker run --name keycloak -p 8080:8080 --net keycloak-network \
-e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=admin \
	jboss/keycloak >> kk.log

#create an account on an already running container by running:
docker exec <CONTAINER> keycloak/bin/add-user-keycloak.sh -u <USERNAME> -p <PASSWORD>

#####host network mode goes here###

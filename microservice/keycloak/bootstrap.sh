#local in-mem storage only
bin/standalone.sh

http://localhost:8080/auth/realms/$REALM/account

#H2 mode
docker run -p 8080:8080 -e KEYCLOAK_USER=admin \ 
	-e  KEYCLOAK_PASSWORD=admin jboss/keycloak


#start mysql
docker run -p 3306:3306 --name mysql -e MYSQL_DATABASE=keycloak -e MYSQL_USER=keycloak -e MYSQL_PASSWORD=password \
	-e MYSQL_ROOT_PASSWORD=root_password mysql

mysql -h 0.0.0.0 -P 3306 -u keycloak keycloak

#keycloak with mysql persistance
docker run -p 8080:8080 -e KEYCLOAK_USER=admin \ 
	-e  KEYCLOAK_PASSWORD=admin  -e DB_VENDOR=mysql \
	-e MYSQL_ADDR=0.0.0.0 jboss/keycloak

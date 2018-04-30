docker run -d -p 9411:9411 openzipkin/zipkin


curl -sSL https://zipkin.io/quickstart.sh | bash -s
java -jar zipkin.jar


docker run -d -p 9411:9411 openzipkin/zipkin

STORAGE_TYPE=mysql MYSQL_USER=root java -jar zipkin.jar

<<ENVVAR
STORAGE_TYPE=mysql
STORAGE_PORT_3306_TCP_ADDR=
MYSQL_DB=
MYSQL_USER=
MYSQL_PASS=
MYSQL_HOST=
ENVVAR

mysql -uroot -Dzipkin < mysql.sql




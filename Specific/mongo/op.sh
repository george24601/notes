brew install mongodb --with-openssl

sudo mkdir -p /data/db

#start the db --dbpath <path to data directory>
sudo mongod 

#start the shell
mongo


#to get our cert signed by a CA
#1. create key
openssl genrsa -aes256 \
      -out vault.key.pem 2048
chmod 400 vault.key.pem


#Adding the Certificate on RHEL
update-ca-trust enable
cp /etc/vault/ssl/certs/vault.crt /etc/pki/ca-trust/source/anchors/
update-ca-trust extract
vault status


####add my own ca cert to openssl
#showl tls cert address
#on centos 7 OPENSSLDIR: "/etc/pki/tls"
openssl version -d

sudo cp ca.crt.pem /etc/pki/tls/certs/

sudo ln -s ca.crt.pem `openssl x509 -hash -noout -in ca.crt.pem`.0

#make sure ca cert is correctly imported
openssl verify -CApath /etc/pki/tls/certs vault.crt.pem


#####add my own ca cert to NSS, this will enable curl to my own http, because curl on centos links to NSS
sudo cp ca.crt.pem /etc/ssl/certs

#.pki/nssdb is the default location of nssdb
mkdir -p .pki/nssdb ; certutil -N -d sql:.pki/nssdb

#DEV.LOCAL is the name
certutil -d sql:.pki/nssdb -A -t "CT,c,c" -n DEV.LOCAL \
-i /etc/ssl/certs/ca.pem

###add my own ca cert to JVM
#you need to know your keystore password. If you haven't changed it since installing java, then this will be changeit
#You are looking for the directory that holds the likes of bin/java, bin/keytool, and lib/security/cacerts.
mkdir -p lib/security/cacerts

cd /usr/lib/jvm/java-8-oracle
bin/keytool -import -trustcacerts -alias CADev -file ca.crt.pem -keystore lib/security/cacerts 

--storepass changeit

###add my own ca cert to jvm trust store
openssl x509 -in ca.crt.pem -inform pem -out ca.crt.der -outform der

keytool -v -printcert -file ca.crt.der



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


#####add my own ca cert to NSS
sudo cp ca.crt.pem /etc/ssl/certs

#.pki/nssdb is the default location of nssdb
mkdir -p .pki/nssdb ; certutil -N -d sql:.pki/nssdb

#DEV.LOCAL is the name
certutil -d sql:.pki/nssdb -A -t "CT,c,c" -n DEV.LOCAL \
-i /etc/ssl/certs/ca.pem



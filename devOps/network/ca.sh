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

#Ubuntu 16.04
sudo su
mkdir /usr/share/ca-certificates/vault
cp /home/ubuntu/vault-ca.crt /usr/share/ca-certificates/vault/vault-ca.crt
echo "vault/vault-ca.crt" >> /etc/ca-certificates.conf
update-ca-certificates
vault status

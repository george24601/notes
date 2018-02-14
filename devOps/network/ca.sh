#to get our cert signed by a CA
#1. create key
openssl genrsa -aes256 \
      -out vault.key.pem 2048
chmod 400 vault.key.pem

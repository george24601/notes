######Let's encrypt/certbot, use --staging flag for dev
sudo certbot certonly --manual  --preferred-challenges dns

$INPUT_YOUR_DOMAIN_HERE

#ca.crt.pem => not required with internet access

#vault.crt.pem => public cert, use the full chain here

#vault.key.pem => private key

sudo cp /etc/letsencrypt/live/$DOMAIN_NAME/fullchain.pem tls/vault.crt.pem

sudo cp /etc/letsencrypt/live/$DOMAIN_NAME/privkey.pem tls/vault.key.pem


openssl x509 -in vault.crt.pem -text -noout

openssl rsa -in vault.key.pem -check


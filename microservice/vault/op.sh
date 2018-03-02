sudo yum install vim jq nc bind-utils

export VAULT_ADDR='https://vault.service.inner-route.com:8200'
#Note port 8500 is for consul, and 8200 is for vault!!!
#source env.sh, note that vault client essentially just sends rest calls to this address
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN=$TRY_NOT_USE_YOUR_ROOT_TOKEN

#note that with a secret backend, we still use the secret prefix instead of consul prefix!!!

vault write secret/zuul/development test.token=tokenV 

vault write secret/zuul/development nk=nv 

vault read secret/zuul/development


sudo cp /etc/letsencrypt/live/vault.service.inner-route.com/fullchain.pem tls/vault.crt.pem

sudo cp /etc/letsencrypt/live/vault.service.inner-route.com/privkey.pem tls/vault.key.pem

     "sudo /tmp/terraform-aws-vault/modules/update-certificate-store/update-certificate-store --cert-file-path /opt/vault/tls/ca.crt.pem"

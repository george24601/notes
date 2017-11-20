
#The only step you need to take is to set the following environment variables:

export VAULT_ADDR='http://127.0.0.1:8200'

<<OUT
The unseal key and root token are reproduced below in case you
want to seal/unseal the Vault or play with authentication.

Unseal Key: Xkkq3o71lq4aGj4V1f8AiDpwBpGqmlC5V8yrxU1GIWQ=
Root Token: 36ca0499-8406-7e71-ef29-0017521d2b44
OUT

vault write secret/hello value=world

vault read secret/hello

vault read -format=json secret/hello

vault delete secret/hello



sudo yum install vim jq nc bind-utils

#Note port 8500 is for consul, and 8200 is for vault!!!
#source env.sh, note that vault client essentially just sends rest calls to this address
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN=$TRY_NOT_USE_YOUR_ROOT_TOKEN

#note that with a secret backend, we still use the secret prefix instead of consul prefix!!!

#lease is the refresh_interval
vault write secret/zuul/development test.token=tokenV lease=100d

vault write secret/zuul/development nk=nv 

vault read secret/link/vault

vault read secret/zuul/development

vault read secret/fund/prod


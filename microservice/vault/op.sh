#Note port 8500 is for consul, and 8200 is for vault!!!
#source env.sh, note that vault client essentially just sends rest calls to this address
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN=$TRY_NOT_USE_YOUR_ROOT_TOKEN

#configure Vault to know how to contact Consul
vault write consul/config/access \
	    address=127.0.0.1:8500 \
	        token=$ROOT_TOKEN  \
		testk=testv

#note that with a secret backend, we still use the secret prefix instead of consul prefix!!!

vault write secret/zuul/development test.token=tokenV 

vault read secret/td

#Acquire a management token FROM Consul, using the acl_master_token from your Consul configuration file or any other management token:
curl \
	    -H "X-Consul-Token: secret" \
	        -X PUT \
		    -d '{"Name": "sample", "Type": "management"}' \
		        http://127.0.0.1:8500/v1/acl/create


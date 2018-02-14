#source env.sh
export VAULT_ADDR='http://127.0.0.1:8200'

#configure Vault to know how to contact Consul
vault write consul/config/access \
	    address=127.0.0.1:8500 \
	        token=$ROOT_TOKEN  \
		testk=testv

#note that with a secret backend, we still use the secret prefix instead of consul prefix!!!
vault write secret/hello value=world

vault write secret/td tk=tv

vault read secret/td


#The path where the secrets engine is enabled defaults to the name of the secrets engine


#Acquire a management token from Consul, using the acl_master_token from your Consul configuration file or any other management token:
curl \
	    -H "X-Consul-Token: secret" \
	        -X PUT \
		    -d '{"Name": "sample", "Type": "management"}' \
		        http://127.0.0.1:8500/v1/acl/create



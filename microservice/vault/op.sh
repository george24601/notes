#source env.sh
export VAULT_ADDR='http://127.0.0.1:8200'

vault operator unseal

#check what is the auth method
vault auth list
#provide your root token acquired during inti
vault login
#Unlike the kv backend, the consul backend is not mounted by default.
#should display "Enabled the consul secrets engine at: consul/"
vault secrets enable consul

#configure Vault to know how to contact Consul
vault write consul/config/access \
	    address=127.0.0.1:8500 \
	        token=$ROOT_TOKEN  \
		testk=testv

#can use -format=json for readability
vault read consul/config/access

vault read consul

vault read consul/hello
vault write consul/hello  \
    address=127.0.0.1:8500 \
	        token=$ROOT_TOKEN  \
		testk=testv


vault read vault/hello
vault write consul tk=tv


#The path where the secrets engine is enabled defaults to the name of the secrets engine


#Acquire a management token from Consul, using the acl_master_token from your Consul configuration file or any other management token:
curl \
	    -H "X-Consul-Token: secret" \
	        -X PUT \
		    -d '{"Name": "sample", "Type": "management"}' \
		        http://127.0.0.1:8500/v1/acl/create



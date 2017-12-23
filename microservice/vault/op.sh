vault server -dev

#The only step you need to take is to set the following environment variables:


#the consul prefix specifies which backend to use
vault write secret/hello value=world

vault read secret/hello

vault read -format=json secret/hello

vault delete secret/hello

#mount the kv backend at kv/, use vault mounts to confirm
vault mount kv

###work with consul

#Unlike the kv backend, the consul backend is not mounted by default.
vault mount consul

#Acquire a management token from Consul, using the acl_master_token from your Consul configuration file or any other management token:
curl \
	    -H "X-Consul-Token: secret" \
	        -X PUT \
		    -d '{"Name": "sample", "Type": "management"}' \
		        http://127.0.0.1:8500/v1/acl/create


#configure Vault to know how to contact Consul
vault write consul/config/access \
	    address=127.0.0.1:8500 \
	        token=adf4238a-882b-9ddc-4a9d-5b6758e4159e



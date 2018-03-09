#configure Vault to know how to contact Consul
vault write consul/config/access \
	    address=127.0.0.1:8500 \
	        token=$ROOT_TOKEN  \
		testk=testv

curl -v  http://0.0.0.0:8200/v1/sys/health

#check which ssl curl is using. On centos it is most likely
ldd /usr/bin/curl

nslookup vault.service.consul

cd /usr/lib/jvm/java-8-oracle
curl --cacert ./ca.crt.pem https://vault.service.consul:8200/v1/sys/health

dig vault.service.consul

#should not work because no CA cert supplied, unless you add cert to NSS already
curl https://vault.service.consul:8200/v1/sys/health

#should not work because it is on http!
curl --cacert ./ca.crt.pem http://vault.service.consul:8200/v1/sys/health

#read
curl -v \
    --header "X-Vault-Token: $VAULT_TOKEN"  --cacert ./ca.crt.pem  \
    https://vault.service.consul:8200/v1/secret/zuul/development | jq


#write
curl -v -X POST  -H "Content-Type: application/json" \
    --header "X-Vault-Token: $VAULT_TOKEN"  --cacert ./ca.crt.pem  \
    https://vault.service.consul:8200/v1/secret/zuul/development \
    -d '{"test.token" : "tokenV2" }' 



dig @127.0.0.1 -p 8600 vault.service.consul. ANY

dig @127.0.0.1 -p 8600 consul.service.inner-route.com. ANY

dig @127.0.0.1 -p 8600 vault.service.inner-route.com. ANY

dig @127.0.0.1 -p 8600 zuul.service.consul. ANY

dig vault.service.inner-route.com

curl -v \
    --header "X-Vault-Token: $VAULT_TOKEN"   \
    https://vault.service.inner-route.com:8200/v1/secret/zuul/development | jq


dig consul.service.inner-route.com

cp ca.crt.pem /etc/ssl/certs

curl 0.0.0.0:8500/v1/catalog/service/vault | jq

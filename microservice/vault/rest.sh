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

curl -v \
    --header "X-Vault-Token: $VAULT_TOKEN"  --cacert ./ca.crt.pem  \
    https://vault.service.consul:8200/v1/secret/zuul/development | jq

curl -v -X POST  -H "Content-Type: application/json" \
    --header "X-Vault-Token: $VAULT_TOKEN"  --cacert ./ca.crt.pem  \
    https://vault.service.consul:8200/v1/secret/zuul/development \
    -d '{"test.token" : "tokenV2" }' 



dig @127.0.0.1 -p 8600 vault.service.consul. ANY

dig vault.service.consul

cp ca.crt.pem /etc/ssl/certs


sudo yum install jq

#check nodes
curl 0.0.0.0:8500/v1/catalog/nodes | jq

#check services
curl 0.0.0.0:8500/v1/catalog/services | jq

curl 0.0.0.0:8500/v1/catalog/service/fund-dev | jq

curl 0.0.0.0:8500/v1/catalog/service/zuul-dev | jq

curl --request PUT \
	--data 'testValue' \
	0.0.0.0:8500/v1/kv/foo

curl 0.0.0.0:8500/v1/kv/foo


curl 0.0.0.0:8500/ui


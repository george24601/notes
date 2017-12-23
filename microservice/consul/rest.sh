sudo yum install jq

curl 0.0.0.0:8500/v1/catalog/nodes | jq

curl --request PUT \
	--data 'testValue' \
	0.0.0.0:8500/v1/kv/foo

curl 0.0.0.0:8500/v1/kv/foo


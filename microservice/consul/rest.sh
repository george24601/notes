sudo yum install jq

#check nodes
curl 0.0.0.0:8500/v1/catalog/nodes | jq

#check services
curl 0.0.0.0:8500/v1/catalog/services | jq

curl 0.0.0.0:8500/v1/catalog/service/service-id | jq

curl	    --request PUT \
	        0.0.0.0:8500/v1/agent/service/deregister/my-service-id

curl	    --request PUT \
	        0.0.0.0:8500/v1/agent/service/deregister/johnny5

f1ccc07f-9e2c-7846-4497-989ef04ec672



curl --request PUT \
	--data 'testValue' \
	0.0.0.0:8500/v1/kv/foo

curl 0.0.0.0:8500/v1/kv/foo


curl 0.0.0.0:8500/ui


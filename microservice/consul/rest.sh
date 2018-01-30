sudo yum install jq

#check nodes
curl 0.0.0.0:8500/v1/catalog/nodes | jq

#check services
curl 0.0.0.0:8500/v1/catalog/services | jq

curl 0.0.0.0:8500/v1/catalog/service/service-id | jq

#1. run this on the node where the service runs
#2. my-service-id is the "ServiceID" field returned in the get request, e.g., in the format of "service-environment-port"
curl	    --request PUT \
	        0.0.0.0:8500/v1/agent/service/deregister/my-service-id


curl --request PUT \
	--data 'testValue' \
	0.0.0.0:8500/v1/kv/foo

curl 0.0.0.0:8500/v1/kv/foo


curl 0.0.0.0:8500/ui


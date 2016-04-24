#The web service REST API’s go through the same security as the web UI. If your cluster adminstrators have filters enabled you must authenticate via the mechanism they specified

#check yarn app info
curl -i http://$YARN_HOST:8088/ws/v1/cluster/apps/$APP_ID

#check yarn app state
curl -i http://$YARN_HOST:8088/ws/v1/cluster/apps/$APP_ID/state

#Kill a yarn application
curl -X PUT -d '{"state":"KILLED"}' -i http://$YARN_HOST:8088/ws/v1/cluster/apps/$APP_ID/state --header "Content-Type:application/json"

#With the New Application API, you can obtain an application-id which can then be used as part of the Cluster Submit Applications API to submit applications.

#check appplicaiotn log
yarn logs -applicationId $APP_ID

yarn application -kill $APP_ID

#create index
curl -X PUT https://$ES_HOST:443/test -H 'Content-Type: application/json' -d'
{
    "settings" : {
        "index" : {
            "number_of_shards" : 3,
            "number_of_replicas" : 2
        }
    }
}
'
#list all indices via metadata
curl https://$ES_HOST/_cat/indices


curl -d @qPL.json http://localhost:9200/spark/_search?pretty 

curl -d @filter.json http://localhost:9200/spark/confluent/_search?pretty 

curl -d @filterAgg.json http://localhost:9200/spark/confluent/_search?pretty 

curl -d @dateFilterAgg.json http://localhost:9200/spark/confluent/_search?pretty 

#check field type
curl -XGET 'http://localhost:9200/spark/_mapping/confluent/field/dateInserted'

#count # of docs in the cluster
curl -XGET 'http://localhost:9200/_count?pretty' -d '
{
  "query": {
  "match_all": {}
}
                }
                '


#HEAD verb to check whether the doucment exists
curl -i -XHEAD http://localhost:9200/website/blog/123

#If you plan on using Curator with AWS ES using IAM credentials, you must also install the requests_aws4auth python module:
pip install requests_aws4auth

#There is a way to install Curator into a path for just the current user, using the --user flag.
pip install elasticsearch-curator

curator [--config CONFIG.YML] [--dry-run] ACTION_FILE.YML

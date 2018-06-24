#create index
curl -X PUT https://search-prod-ek-g2yflstdow7bkz7pz7xdxdd2ou.us-west-2.es.amazonaws.com:443/prod -H 'Content-Type: application/json' -d'
{
    "settings" : {
        "index" : {
            "number_of_shards" : 3,
            "number_of_replicas" : 2
        }
    }
}
'

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

curator [--config CONFIG.YML] [--dry-run] ACTION_FILE.YML

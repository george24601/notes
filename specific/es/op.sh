#test if ES is up
curl http://localhost:9200/?pretty

#list all indices via metadata
curl http://localhost:9200/_cat/indices

curl http://localhost:9200/_cat/indices/coupon

curl http://localhost:9200/coupon/_mapping

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

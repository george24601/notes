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





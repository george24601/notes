#install ES
wget https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/zip/elasticsearch/2.0.0/elasticsearch-2.0.0.zip

unzip elasticsearch-2.0.0.zip

cd elasticsearch-2.0.0

#install kabana
wget https://download.elastic.co/kibana/kibana/kibana-4.2.1-darwin-x64.tar.gz

tar -zxvf kibana-4.2.1-darwin-x64.tar.gz

#inside ES
bin/plugin install license
bin/plugin install marvel-agent

#inside kabana
bin/kibana plugin --install elasticsearch/marvel/latest

#start ES
bin/elasticsearch

#start kabana
bin/kibana

#Now check http://localhost:5601/app/marvel

#turn off marvel on local
echo 'marvel.agent.enabled: false' >> ./config/elasticsearch.yml

#test if ES is up
curl 'http://localhost:9200/?pretty'

#shutdown ES
curl -XPOST 'http://localhost:9200/_shutdown'

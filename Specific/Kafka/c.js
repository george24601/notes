var subTopic = 'test'; //TODO: change this
var topicPartition = 0; //TODO: changethis 
var zookeeperHandle = 'localhost:2181/';//TODO: change this

var messageAction = function(message){
    console.log(message);
}; //TODO: change this


var kafka = require('kafka-node');
var client = new kafka.Client(zookeeperHandle);
var consumer = new kafka.Consumer(
        client,
        [
            { topic: subTopic, partition: topicPartition }
        ],
        {
            autoCommit: false //maybe true?
        }
    );

consumer.on('message', messageAction);

consumer.on('offsetOutOfRange', function (err) {
	console.log('OFFSET OUT OF RANGE');
});

consumer.on('error', function (err) {
	console.log('CONSUMER ERROR');
});


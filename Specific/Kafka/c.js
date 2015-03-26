var subTopic = 'test'; //TODO:which topic are you subscribing?
var topicPartition = 0; //TODO: keep in mind each partition can be consumed by only one instance inside each consumer group 
var logOffset = 6000; //TODO: auto commit is off for now
var zookeeperHandle = 'localhost:2181/';

function messageAction(message){
    console.log(message); //TODO: your concrete function goes here
};



var kafka = require('kafka-node');
var consumer = new kafka.Consumer(
	new kafka.Client(zookeeperHandle),
        [
            { topic: subTopic, partition: topicPartition, offset: logOffset }
        ],
        {
            fromOffset: true,
            autoCommit: false 
        }
    );

consumer.on('message', messageAction);

consumer.on('offsetOutOfRange', function (err) {
	console.log('OFFSET OUT OF RANGE');
});

consumer.on('error', function (err) {
	console.log('CONSUMER ERROR');
});


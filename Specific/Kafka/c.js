var subTopic = 'test'; //TODO:which topic are you subscribing?
var topicPartition = 0; //TODO: keep in mind each partition can be consumed by only one instance inside each consumer group 
var useOffset = false;
var logOffset = 6000; //TODO: auto commit is off for now
var zookeeperHandle = 'localhost:2181/';

var kafka = require('kafka-node');
var consumer = new kafka.Consumer(
		new kafka.Client(zookeeperHandle),
		[
		{ topic: subTopic, partition: topicPartition, offset: logOffset }
		],
		{autoCommit: false, fromOffset: useOffset}
		);


consumer.on('offsetOutOfRange', function (err) {
		console.log('OFFSET OUT OF RANGE');
		});

consumer.on('error', function (err) {
		console.log('CONSUMER ERROR');
		});

///TODO: replace this with your logic goes here,  
function messageAction(message){
	var offset = message['offset'];
	console.log(message['offset']); 

	if (false){

		consumer.commit(function (err, data) { //TODO: you need to explicitly commit your current consumer's offset, so that next time it picks up from where it is left off
				if (err) throw err;

				console.log(data);
				});
	}
};

consumer.on('message', messageAction);

var subTopic = 'test'; //TODO:which topic are you publishing to?
var topicPartition = 0;//keep in mind each partition is consumed by one instance in each consumer group
var filePath = process.argv[2];
var fs = require('fs');

function sent (err, data) {
	console.log('Offset at ' + data[subTopic][topicPartition]); //TODO: your concrete logic goes here
};

var zookeeperHandle = 'localhost:2181/'

var kafka = require('kafka-node');
var producer = new kafka.Producer(new kafka.Client(zookeeperHandle)); //do we need new?
producer.on('ready', function () {
		fs.readFile(filePath, function (err, data) {
			var messagesToSend;
			if (err) throw err;

			messagesToSend = data.toString().split('\n');
			
			//console.log (messagesToSend);

			var payloads = [{
				topic: subTopic,
				messages: messagesToSend, 
				partition: topicPartition
				}];//just one request for now, probably needs more

			producer.send(payloads, sent);
}
);

		});

producer.on('error', function (err) {
		console.log ('PRODUCER ERROR');
		});

var net = require('net');

var client = new net.Socket();

client.connect(5555, '10.67.19.74', function () {
	console.log('Connected');
});

client.on('data', function (data) {
	console.log(data.toString());
});

client.on('end', function () {
	console.log('disconnected from server');
});

client.write("reboot");
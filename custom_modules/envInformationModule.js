var exec = require('child_process').exec;

exports.setHostname = function(envSettings){
	var command = 'hostname';
	exec(command,[], function (error, stdout, stderr) {
		if(error){
			console.log('error when executing: ' + command);
			console.log('output : ' + stderr);
		}
		console.log('hostname : ' + stdout);
		var result = stdout.replace(/(\r\n|\n|\r)/gm,"");
		envSettings.serverPath = result;
	});
};
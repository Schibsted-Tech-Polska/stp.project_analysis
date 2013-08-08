var flow = require('nimble');
var spawn = require('child_process').spawn;
var logger = require('winston');
var nameOfModule = 'executorModule';

exports.executeCommands = function(options, commands, lastFunction){
	var reversedOptions = options.reverse();
	options.map(function(current, i){
		console.log('-->options.cwd ' + i + " : " + current.cwd );
		current.maxBuffer = 200*1024*5;
	});
	commands.map(function(current, i){
		console.log('-->command ' + i + " : " + current );
	});
	
	var arrayOfExec =
	commands.map(function(currentCommand){
		
			return function(callback){
				var args = currentCommand.split(' ');
				
				var currentSpawn = spawn(args[0], args.slice(1), reversedOptions.pop());
				console.log('currentSpawn' + currentSpawn);
				
				currentSpawn.stdout.on('data', function (data) {
				  console.log('stdout: ' + data);
				});

				currentSpawn.stderr.on('data', function (data) {
				  console.log('stderr: ' + data);
				});

				currentSpawn.on('error', function(err){
					console.log('error :  ' + err);
				});

				currentSpawn.on('close', function (code) {
				  console.log('child process exited with code ' + code);
				  callback();
				});
			};
	});
	

	arrayOfExec.push(function(callback){
		        logger.info(nameOfModule, 'before executing last callback');

			    lastFunction();
			   
				callback();	
			});
	console.log(arrayOfExec);

	flow.series(arrayOfExec);
	
};	
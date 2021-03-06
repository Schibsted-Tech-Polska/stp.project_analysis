var flow = require('nimble');
var spawn = require('child_process').spawn;
var logger = require('winston');
var nameOfModule = 'executorModule';
var datastoreModule = require('../custom_modules/datastoreModule');

exports.executeCommands = function(optionsAndCommands, lastFunction, nameOfProject){
	var options = optionsAndCommands.options;
	var commands = optionsAndCommands.commands;
	var correctExitCode = 0;
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

				currentSpawn.stdout.on('data', function (data) {
				  datastoreModule.appendToLog(nameOfProject, data.toString());
				});

				currentSpawn.stderr.on('data', function (data) {
			 	  console.log('ERROR : ! ' + data);
				  datastoreModule.appendToLog(nameOfProject, data.toString());
				});


				currentSpawn.on('error', function(err){
					logger.info(nameOfModule,'error when executing ' + currentCommand + ' err: ' + err);
				   	datastoreModule.appendToLog(nameOfProject, err.toString());
				});

				currentSpawn.on('close', function (code) {
				  console.log('child process exited with code ' + code);
				  if(code !== correctExitCode){
				  	datastoreModule.setErrorWhenExecuting(nameOfProject);
				  }
				  callback();
				});
			};
	});


	arrayOfExec.push(function(callback){
		        logger.info(nameOfModule, 'before executing last callback');

			    //lastFunction();

				callback();
			});
	console.log(arrayOfExec);

	flow.series(arrayOfExec);

};
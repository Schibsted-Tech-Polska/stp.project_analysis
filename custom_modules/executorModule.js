var flow = require('nimble');
var exec = require('child_process').exec;
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
				exec(currentCommand, reversedOptions.pop(), function(err,stdout,stderr){
					logger.info(nameOfModule, 'stdout : ' + stdout);
					if(err){
						console.log('err : ', err);
						logger.info(nameOfModule, 'error when executing : ' + currentCommand);
						logger.info(nameOfModule, 'stdout : ' + stdout);
						logger.info(nameOfModule, 'stderr : ' + stderr);
						
					}
					callback();	
				});
			};
	});
	

	arrayOfExec.push(function(callback){
		        logger.info(nameOfModule, 'before executing last callback');

			    lastFunction();
			   
				callback();	
			});

	flow.series(arrayOfExec);
	
};	
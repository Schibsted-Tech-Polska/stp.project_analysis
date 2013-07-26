var flow = require('nimble');
var exec = require('child_process').exec;
var logger = require('winston');
var nameOfModule = 'executorModule';

exports. executeCommands = function(options, commands, lastFunction){
	

	var firstCall = true;
	console.log("---> options[0] : " + options[0].cwd + " [1] : " + options[1].cwd);
	var reversedOptions = options.reverse();
	
	var arrayOfExec = 
	commands.map(function(currentCommand){
		
			return function(callback){
				exec(currentCommand, reversedOptions.pop(), function(err,stdout,stderr){
					//logger.info(nameOfModule, 'stdout : ' + stdout);
					if(err){
						logger.info(nameOfModule, 'error when executing : ' + currentCommand);
						logger.info(nameOfModule, 'stdout : ' + stdout);
						logger.info(nameOfModule, 'stderr ; ' + stderr);
						
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
	
}	
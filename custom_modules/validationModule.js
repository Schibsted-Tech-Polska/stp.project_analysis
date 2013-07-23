var underscore = require('underscore');
var logger = require('winston');

exports.validateInput = function(properties, callback){
	//TODO 
	var forbiddenCommands = [";", "|", "||", "&&","rm","cp","cat","ls","at","net","netstat","del","copy"];
	var gitCommandMustStartWith = ["git"];
	var javaBuildCommandMustStartWith = ["mvn","ant"];
	var safeGitCommand = 'git clone';
	var doNothing = function(){};

	var v1 = validate(properties.gitCommand,forbiddenCommands,underscore.contains);
	v1(function(){
		properties.gitCommand = safeGitCommand;
	}, doNothing);//TODO assign to var DoNothing

	var v2 = validate(properties.gitCommand,gitCommandMustStartWith,startsWith);
	v2(doNothing
		,function(){
		properties.gitCommand = safeGitCommand;
	});

	var v3 = validate(properties.javaBuildCommand,forbiddenCommands,underscore.contains);
	v3(function(){
		properties.javaBuildCommand = '';
	},doNothing);

	var v4=validate(properties.javaBuildCommand,javaBuildCommandMustStartWith,startsWith);	
	v4(doNothing,function(){
		properties.javaBuildCommand = '';
	});

	var filesToOmitForbiddenCommands = [''];
	var v5 = validate(properties.filesToOmit, filesToOmitForbiddenCommands,isEqual);
	v5(function(){
		var emptyArray=[];
		properties.filesToOmit = emptyArray;
	},function(){
		properties.filesToOmit = properties.filesToOmit.split(',');
	})
	
	


	var possibleLanguages = ['js','php','java'];
	validate(properties.language, possibleLanguages, underscore.contains)
	(function(){
		properties.analysisTool = 'sonar';
	}, 
	function(){
		console.log('validation pass ' + properties.language );
		if( isEqual(properties.language,'js-plato') ){
			properties.analysisTool = 'plato';
			properties.language='js';
		}else if(isEqual(properties.language,'js-sonar')){
			properties.analysisTool = 'sonar';
			properties.language='js';
		}else{
			properties.analysisTool = 'sonar';
		}
		
		
		});

	callback();
}


function validate(commandToValidate, forbiddenCommands,predicate){//TODO validate
	return function(actionWhenFail, actionWhenPass){
		var result = true;
		forbiddenCommands.map(function(currentCommand){
			if(predicate(commandToValidate,currentCommand)){
				
				result =  false;
			}
		});	
		if(!result){
			logger.info('validation of : [ ' + commandToValidate + " ] FAILED");
			actionWhenFail();
	  	}else{
	  		actionWhenPass();
	  	}

	}
}

function isEqual(firstArg, secondArg){
	return firstArg === secondArg;
}

function startsWith(string, properStartCommand){	
	console.log(string + " -> " + properStartCommand);
	var result = false;
	
		if(string.substring(0, properStartCommand.length)  === properStartCommand){
			result = true;
		}
	
	console.log("not start with : " + result)
	return result;
}





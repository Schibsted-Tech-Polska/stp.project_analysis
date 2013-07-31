var underscore = require('underscore');
var logger = require('winston');

exports.validateInput = function(properties){
	
	var forbiddenCommands = [";", "|", "||", "&&","rm","cp","cat","ls","at","net","netstat","del","copy"];
	var gitCommandMustStartWith = ["git"];
	var javaBuildCommandMustStartWith = ["mvn","ant"];
	var doNothing = function(){};
	properties.errorMessages = {};

	console.log('validatie git command : ' + properties.gitCommand);

	var v1 = validate(properties.gitCommand,forbiddenCommands,underscore.contains);
	v1(function(){
		properties.errorMessages.gitCommand = 'bad git command';
	}, doNothing);

	var v2 = validate(properties.gitCommand,gitCommandMustStartWith,startsWith);
	v2(doNothing, function(){
		properties.errorMessages.gitCommand = 'bad git command';
	});

	var v3 = validate(properties.javaBuildCommand,forbiddenCommands,underscore.contains);
	v3(function(){
		properties.errorMessages.javaBuildCommand = 'bad java build command';
	},doNothing);

	var v4=validate(properties.javaBuildCommand,javaBuildCommandMustStartWith,startsWith);	
	v4(doNothing,function(){
		if( !isEqual (properties.javaBuildCommand,'') ){
			properties.errorMessages.javaBuildCommand = 'bad java build command';
		}
	});


	var filesToOmitForbiddenCommands = [''];
	var v5 = validate(properties.filesToOmit[0], filesToOmitForbiddenCommands,isEqual);
	v5(function(){
		var emptyArray=['**/nothing'];
		properties.filesToOmit = emptyArray;
	}, doNothing)
	
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


	var link = properties.link;
	if(!validateLink(link)){
		properties.errorMessages.linkMsg = 'bad link';
	}
	if(!validateSources(properties)){
		properties.errorMessages.sourcesMsg = 'you must type sources';
	}

};

function validateSources(properties){
	console.log(' validator sources : ' + properties.sources);
	var result = true;
	if(isEqual(properties.language,'java') ){
		console.log('java');
		if(emptyOrUndefined(properties.sources)){
			result = false;
		}
	}
	return result;
}

function validateLink(link){
	if(contains(link, "git")){
		var delimeter = '/';
    	var splittedLink = link.split(delimeter);
	    
	    if(splittedLink.length === 5){
	      return true;
	    }
	    return false;
	}else if(contains(link, "svn")){
		return true;
	}
	return false;
}

/*
function and(function1, function2){
	return function(arg1, args2){
		function1(arg1,arg2) && function2(arg1,arg2);
	}
}*/
function contains(path, expression){
	if(path.indexOf(expression) !== -1) 
		return true;
	return false;

} 

function validate(commandToValidate, forbiddenCommands,predicate){
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
	};
}

function emptyOrUndefined(arg){
	return isEqual(arg,'') || isEqual(arg, undefined);
}

function isEqual(firstArg, secondArg){
	return firstArg === secondArg;
}

function startsWith(string, properStartCommand){	
	var result = false;
	
		if(string.substring(0, properStartCommand.length)  === properStartCommand){
			result = true;
		}
	return result;
}

exports.hasErrors = function(properties){
	for(error in properties.errorMessages){
		return true;		
	}
	return false;
};


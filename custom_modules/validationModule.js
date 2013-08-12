var underscore = require('underscore');
var logger = require('winston');
var analysisToolChecker = require('../custom_modules/analysisToolChecker');

exports.validateInput = function(properties){
	console.log('filesToOmit : ' + properties.filesToOmit);

	var forbiddenCommands = [";", "|", "||", "&&","rm","cp","cat","ls","at","net","netstat","del","copy"];
	var gitCommandMustStartWith = ["git"];
	var javaBuildCommandMustStartWith = ["mvn","ant"];
	var doNothing = function(){};
	properties.errorMessages = {};
	properties.previousValues = {};
	
	var getValue = createGetter(properties);
	var containsForbiddenCommands = validate(getValue, forbiddenCommands, contains);
	var reportBadGitCommand = createErrorReporter(properties.errorMessages ,'bad git command');
 
	containsForbiddenCommands('gitCommand', reportBadGitCommand, doNothing);

	var gitCommandShouldStartsWith = validate(getValue, gitCommandMustStartWith, startsWith);
	gitCommandShouldStartsWith('gitCommand', doNothing, reportBadGitCommand);

	
	var reportBadJavaBuildCommand = createErrorReporter(properties.errorMessages ,'bad java build command');	
	containsForbiddenCommands('javaBuildCommand', reportBadJavaBuildCommand, doNothing);

    
    var javaBuildCommandShouldStartsWith = validate(getValue, javaBuildCommandMustStartWith, startsWithOrIsEmpty);//TODO startsWithOrIsEmpty	
	javaBuildCommandShouldStartsWith('javaBuildCommand', doNothing, reportBadJavaBuildCommand);

	// var possibleLanguages = ['js-plato', 'js-sonar', 'php', 'java'];
	// var containsProperLanguage = validate(getValue, possibleLanguages, contains);
	// var reportBadLanguageCommand = createErrorReporter(properties.errorMessages, 'not supported language when fail');
	// containsProperLanguage('language', doNothing, reportBadLanguageCommand);
	
	var link = properties.link;
	if(!validateLink(link)){
		properties.errorMessages.linkMsg = 'bad link';
	}
	if(!validateParameter(properties.sources, emptyOrUndefined)){
		properties.errorMessages.sources = 'you must type sources';
	}
	if(!validateParameter(properties.binaries, emptyOrUndefined) 
		&& isEqual(properties.language, 'java') ){
		properties.errorMessages.binaries = 'you must type binaries';
	}
	
	console.log('errors after validation');
	interateOverObject(properties.errorMessages);

	analysisToolChecker.checkAnalysisTool(properties);
	persistPreviousValues(properties);
};


function createGetter(map){
	return function(name){ return map[name]; };
}

function createErrorReporter(map, errorMessage){
	return function(name){
		console.log('set errorMessage : ' + errorMessage);
		map[name] = errorMessage;
		console.log(map[name]);
	};
}


function isEmpty(string){
	return string.trim() === '';
}

function persistPreviousValues(properties){
	var difference = compareTwoObjects(properties, properties.errorMessages);
	console.log('difference : ' + difference);
	properties.previousValues = underscore.pick(properties, difference);
	console.log('previousValues : ' + properties.previousValues);
	interateOverObject(properties.previousValues);
}

function compareTwoObjects(first, second){
	var firstKeys = interateOverObject(first);
	var secondKeys = interateOverObject(second);
	return underscore.difference(firstKeys, secondKeys);
}

function interateOverObject(object){
	var keys = [];
	for (var key in object) {
	   if (object.hasOwnProperty(key)) {
	      var obj = object[key];
	      console.log(key + "  = " +obj);
	      keys.push(key);
	   }
	}
	return keys;
}


function validateParameter(parameter, predicate){
	return !predicate(parameter);
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

function contains(path, expression){
	if(path.indexOf(expression) !== -1){ 
		return true;
	}
	return false;

} 

function validate(getValue, forbiddenCommands,predicate){
	return function(name, actionWhenFail, actionWhenPass){
		var result = true;
		var commandToValidate = getValue(name);

		forbiddenCommands.map(function(currentCommand){
			if(predicate(commandToValidate,currentCommand)){
				result =  false;
			}
		});	
		if(!result){
			logger.info('validation of : [ ' + commandToValidate + " ] FAILED");
			actionWhenFail(name);
	  	}else{
	  		actionWhenPass(name);
	  	}
	};
}

function emptyOrUndefined(arg){
	return isEqual(arg,'') || isEqual(arg, undefined);
}

function isEqualTo(value){
	return function(arg){
		return value === arg;
	};
}

function isEqual(firstArg, secondArg){
	return firstArg === secondArg;
}

function startsWithOrIsEmpty(string, properStartCommand){
 	return startsWith(string, properStartCommand) || isEmpty(string);
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

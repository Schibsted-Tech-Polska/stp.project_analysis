var exec = require('child_process').exec;
var fs = require('fs');
var flow = require('nimble');
var fileModule = require('../custom_modules/fileModule');
var sourceFinder = require('../custom_modules/sourceFinderModule');
var jsFilesToOmit = require('../custom_modules/javaScriptFilesToOmit');
var paths = require('../custom_modules/paths');
var logger = require('winston');
var nameOfModule = 'sonarModule';


var languageToFileMap = {'java' : 'java.properties',
						  'php' : 'php.properties' ,
						   'js' : 'js.properties' };


var sonarRunnerCommand= 'sonar-runner';
var platoCommand = 'plato -r -d reports . ';
 
var nameOfPropertiesFile = 'sonar-project.properties';


//TODO this module is to big
var basePropertiesPath = function(){
	return __dirname.replace('custom_modules','base_properties');
};

//--------------------------------------
function AnalyzeExecution(){
	this.options = [];
	this.commands = [];
};
AnalyzeExecution.prototype.execute = function(lastCallback){
	lastCallback = lastCallback || fileModule.deleteFolder(this.options.cwd);
	executeCommands(this.options, this.commands, lastCallback);
};
AnalyzeExecution.prototype.toString = function(){
	var self = this;
   return this.commands.map(function(current,i){
		console.log('commands nr ' + i + " : " + current + " location : " + " location : " + self.commands[i].cwd) ;
	}) ;

	//var result2 =  this.commands.map(function(current,i){
	//	return console.log('commands nr ' + i + " : " + current + " location : ";
	//}) ;
};

//TODO ProjectMetainfo not properties
function PropertiesGenerator( properties ){
	console.log('-->sources : ' + properties.sources);
	var filesToOmit = properties.filesToOmit;
	this.SRC = properties.sources;
	//var startFinder = false;
	

	this.parameters = {
		'projectLocation':properties.projectLocation,
		'extension':"."+properties.language
	}

	//if(properties.sources != undefined){
	//	startFinder = true;
	//}

	//if( properties.language=='js' ){
		this.parameters.filesToOmit = filesToOmit;
	//}else{
	//	this.parameters.filesToOmit = filesToOmit;//TODO must be at least one
	//}
	logger.info(nameOfModule, 'files that will be ingnored by propertiesGenerator ' + this.parameters.filesToOmit );


}

PropertiesGenerator.prototype.generate = function(propertiesToChange,callback){
	console.log('this.sources : ' + this.SRC);
	if(this.SRC == undefined ){
		sourceFinder.findSrcLocation(this.parameters ,propertiesToChange, callback);	
	}else{
		console.log('--->user type sources location @ : ' + this.SRC );
		propertiesToChange.SRC = this.SRC;
		callback(propertiesToChange);		
	}
}
//-------------------------------------------------------
exports.analyze = function(properties){

	logger.info(nameOfModule, 'used analysisTool : ' + properties.analysisTool);
	var configPlaceholders = {'UNIQUE_KEY' : escapeCharacters(properties.link),
							  'NAME' : properties.nameOfGitRepo };//config placeholders 
	
	flow.series([
		 function(callback){
	 		logger.info(nameOfModule, "step1 - generating properties file");
	 		//TODO propertyFile
            generatePropertiesFile(properties, configPlaceholders, callback);
 	 	},
	 	function(callback){
	 		logger.info(nameOfModule, "step2 -  start sonnarRunnerClient");
	 		startSonarRunnerClient(properties);
		}
	  ]);
     
}

function startSonarRunnerClient(properties){
		
	 	var language = properties.language;
		var projectLocation = properties.projectLocation; 
		
		if(language === 'java'){
	 	 	startJavaClient(properties);
	 	 }else{
	 	 	startOtherLanguagesClient(properties);
	 	 }
}

function startJavaClient(properties){

	var projectLocation = properties.projectLocation; 
	var javaBuildCommand = properties.javaBuildCommand;

	if(javaBuildCommand){
		logger.info(nameOfModule, "userTypedJavaBuildCommand : " + javaBuildCommand);
		var options = {
            cwd: projectLocation
	 	 };
	 	 
	 	var project = new AnalyzeExecution();
	 	project.options[0] = options;
	 	project.options[1] = options;
		project.commands[0] = javaBuildCommand;
        project.commands[1] = sonarRunnerCommand;
		 
		project.execute();
	}
	else{
		checkTypeOfJavaProject(projectLocation);
	}
}


function startOtherLanguagesClient(properties){
	 var options = {
            cwd: properties.projectLocation
	 	 };


	 	 var project = new AnalyzeExecution();
	 	 project.options[0] = options;
	 	 project.options[1] = options;
	 	 project.commands[1] = 'none';
	 	 if(properties.analysisTool=='plato'){
	 	 	var doNothing = function(){};
	 	 	project.commands[0] = platoCommand;
	 	 	project.execute(doNothing);
	 	 }else{
			project.commands[0] = sonarRunnerCommand;
			project.execute();
		 }
} 

function generatePropertiesFile(properties ,propertiesToChange, callback) {
	
	var language = properties.language;
	var projectLocation = properties.projectLocation;

	var delimeter  = '/';
	var srcPath = basePropertiesPath() + delimeter + languageToFileMap[language];
	var destPath = projectLocation + delimeter + nameOfPropertiesFile;
	logger.info(nameOfModule, "generating propertyFile, src : " + srcPath +
							  "\n dest : " + projectLocation);

	var saveNewProperties = function(propertiesToChange){  
		fileModule.copyFileAndChangeProperties(srcPath, destPath, propertiesToChange,
	  		function(err){
	  			if(err){
	  				logger.info(nameOfModule, 'copyFileAndChangeProperties Error : ' + err);
	  			}
				callback();
			});
	};
    //TODO 
	var propertiesGenerator = new PropertiesGenerator(properties);
	propertiesGenerator.generate(propertiesToChange,saveNewProperties);
}

function escapeCharacters(newId){
	var charToBeEscape = '/';
	var charToEscape = '_';
	return replaceAll(charToBeEscape, charToEscape, newId);
}

function replaceAll(find, replace, str) {
  return str.replace(new RegExp(find, 'g'), replace);
}


exports.getUrlOfAnalyzedProject = function(properties){

	if(properties.analysisTool == 'sonar'){
		var sonarUrl = paths.sonarUrl();
    	return sonarUrl+escapeCharacters(properties.link);
	}else{
		var appUrl = paths.applicationUrl();
		var platoSuffix = "/reports/index.html";
		return [appUrl, properties.nameOfGitRepo, platoSuffix].join('');
		
	}
   

}


function checkTypeOfJavaProject(projectLocation){
	 var options = {
            cwd: projectLocation
	 	 };

	var finder = require('findit').find(projectLocation);

    var typeOfProject = [];
	var locationsOfBuildFiles = [];
    var counter = 0;

    var currentFindProjects = new AnalyzeExecution();
	
	//This listens for files found
	finder.on('file', function (file) {//TODO only first file is important
		
		if(file.indexOf('pom.xml') != -1){
			//typeOfProject = 'maven';
			//options.cwd = file;
			
			//currentFindProject.commands[0] = 'mvn clean install';
            //currentFindProject.commands[1] = sonarRunnerCommand; //'mvn sonar:sonar';  //;

            var options = {
            		cwd: fileModule.extractDirectoryFromPath(file)
            };
            currentFindProjects.commands.push('mvn clean install');
            currentFindProjects.options.push(options);
           // var options1 = {
           // 		cwd: projectLocation
           // };

            //currentFindProject.options[1] = options1;
          
            //currentFindProject.options[0] = options0;

            //typeOfProject.push(currentFindProject);
			//locationsOfBuildFiles.push(file);
			
		}else if(file.indexOf('build.xml') != -1){
			//options.cwd = file;
			//var currentFindProject = new AnalyzeExecution();
			currentFindProjects.commands.push('ant build');
            //currentFindProject.commands[1] = sonarRunnerCommand;

            var options = {
            		cwd: fileModule.extractDirectoryFromPath(file)
            };
            //var options1 = {
            //		cwd: projectLocation
            //};
			//currentFindProject.options[0] = options0;
			//currentFindProject.options[1] = options1;
			currentFindProjects.options.push(options);

            //typeOfProject.push(currentFindProject);
			//locationsOfBuildFiles.push(file);
		}
		
  		
	});

	finder.on('end',function(){
		logger.info(nameOfModule, 'find type of java project : ' + typeOfProject[0]);
		
		//if(typeOfProject.length === 0) {
			//typeOfProject = 'gradle';
		//	var currentFindProject = new AnalyzeExecution(options);
		  //  currentFindProject.commands[0] = sonarRunnerCommand;
           // currentFindProject.commands[1] = 'none';
          
            
            var options = {
            		cwd: projectLocation
            };
            currentFindProjects.commands.push(sonarRunnerCommand);
            currentFindProjects.options.push(options);
			//currentFindProject.options[0] = options;
			//currentFindProject.options[1] = options;
          
            //typeOfProject.push(currentFindProject);
        

		  //typeOfProject[0].execute();
		  //typeOfProject.map(function(current){
		  //	current.execute();
		  //})
			currentFindProjects.execute();
		  console.log('all finded projects : ' + currentFindProjects.toString() );
	});
}

function executeCommands(options, commands, lastFunction){
	
	var firstCall = true;
	console.log("---> options[0] : " + options[0].cwd + " [1] : " + options[1].cwd);
	var reversedOptions = options.reverse();
	
	var arrayOfExec = 
	commands.map(function(currentCommand){
		
			return function(callback){
				exec(currentCommand, reversedOptions.pop(), function(err,stdout,stderr){
					logger.info(nameOfModule, 'stdout : ' + stdout);
					if(err){
						logger.info(nameOfModule, 'error when executing : ' + currentCommand);
						logger.info(nameOfModule, 'stdout : ' + stdout);
						logger.info(nameOfModule, 'stderr ; ' + stderr);
						
					}
					callback();	
				});
			};
	});
	

	//arrayOfExec.push(function(callback){
	//	        logger.info(nameOfModule, 'before executing last callback');
	//		    lastFunction();
	//			callback();	
	//		});

	flow.series(arrayOfExec);//apply(flow,arrayOfExec);
	
}	


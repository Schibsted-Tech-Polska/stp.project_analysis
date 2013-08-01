var fs = require('fs');
var flow = require('nimble');
var fileModule = require('../custom_modules/fileModule');
var paths = require('../custom_modules/paths');
var logger = require('winston');
var executor = require('../custom_modules/executorModule');
var nameOfModule = 'sonarModule';
var datastoreModule = require('../custom_modules/datastoreModule');
var PropertiesGenerator = require('../custom_modules/PropertiesGenerator');


var languageToFileMap = {	'java' : 'java.properties',
							'php' : 'php.properties' ,						
							'js' : 'js.properties'	};

var sonarRunnerCommand= 'sonar-runner';
var platoCommand = 'plato -r -d reports . ';
 
var nameOfPropertiesFile = 'sonar-project.properties';



//TODO this module is to big
var basePropertiesPath = function(){
	return __dirname.replace('custom_modules','base_properties');
};

//--------------------------------------
function AnalyzeExecution(absoluteLocationOfProject){
	this.absoluteLocationOfProject = absoluteLocationOfProject;
	this.options = [];
	this.commands = [];
};
AnalyzeExecution.prototype.execute = function(lastCallback){
	console.log('absoluteLocationOfProject : ' + this.absoluteLocationOfProject);
	//var locationOfProject = this.options[this.options.length-1].cwd;
	var progressIncrementator = function(absoluteLocationOfProject){
		return function(){
			//var absoluteLocationOfProject = this.absoluteLocationOfProject;
			console.log('absoluteLocationOfProject : ' + absoluteLocationOfProject);
			var nameOfProject = fileModule.extractFileNameFromPath(absoluteLocationOfProject);
			datastoreModule.incrementStatus(nameOfProject);
		}
	};

	lastCallback =  progressIncrementator(this.absoluteLocationOfProject); //lastCallback || fileModule.deleteFolder(this.absoluteLocationOfProject , progressIncrementator);
	executor.executeCommands(this.options, this.commands, lastCallback);
};
AnalyzeExecution.prototype.toString = function(){
	var self = this;
   return this.commands.map(function(current,i){
		console.log('commands nr ' + i + " : " + current +" location : " + self.commands[i].cwd) ;
	});
};

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
     
};

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
	var options={};

	var projectLocation = properties.projectLocation; 
	var javaBuildCommand = properties.javaBuildCommand;
	var binariesLocation = properties.binaries;
	var project = new AnalyzeExecution(projectLocation);

	console.log('projectLocation : ' + projectLocation);
	if(javaBuildCommand.indexOf('mvn') !== -1){

		var locationOfExectuting = [projectLocation,binariesLocation].join('/'); 
		options.cwd = fileModule.extractDirectoryFromPath(locationOfExectuting);
		console.log('--> after extractDirectoryFromPath options.cwd : ' +options.cwd);
		project.options[0] = options;
	 	project.options[1] = options;
		project.commands[0] = javaBuildCommand;
        project.commands[1] = 'mvn sonar:sonar';
		 
	}else{
		options.cwd = projectLocation;
		project.options[0] = options;
	 	project.options[1] = options;
		project.commands[0] = javaBuildCommand;
        project.commands[1] =  sonarRunnerCommand;
	}

	project.execute();

    /*
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
	}*/
}


function startOtherLanguagesClient(properties){
	 var options = {
            cwd: properties.projectLocation
	 	 };


	 	 var  project = new AnalyzeExecution(properties.projectLocation);
	 	 project.options[0] = options;
	 	 project.options[1] = options;
	 	 project.commands[1] = 'none';
	 	 if(properties.analysisTool === 'plato'){
	 	 	var doNothing = function(){
				datastoreModule.incrementStatus(properties.nameOfGitRepo);
		 	};
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
	var propertiesGenerator = PropertiesGenerator.create(properties);
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

	if(properties.analysisTool === 'sonar'){
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
    var currentFindProjects = new AnalyzeExecution();
	
	//This listens for files found
	finder.on('file', function (file) {//TODO only first file is important
		
		if(file.indexOf('pom.xml') !== -1){
		
            var options = {
            		cwd: fileModule.extractDirectoryFromPath(file)
            };
            console.log('---> options.cwd : ' + options.cwd);
            currentFindProjects.commands.push('mvn clean install');
            currentFindProjects.options.push(options);

            //currentFindProjects.commands.push('mvn sonar:sonar');
            //currentFindProjects.options.push(options);
          
		}else if(file.indexOf('build.xml') !== -1){
		
			currentFindProjects.commands.push('ant build');
        
		    var options = {
            		cwd: fileModule.extractDirectoryFromPath(file)
            };
           	
           	currentFindProjects.options.push(options);

		}
	});

	finder.on('end',function(){
		logger.info(nameOfModule, 'find type of java project : ' + typeOfProject[0]);
          
            
            var options = {
            		cwd: projectLocation
            };
            console.log('--> options.projectLocation' + options.cwd);
            currentFindProjects.commands.push(sonarRunnerCommand);
            currentFindProjects.options.push(options);

			currentFindProjects.execute();
		  console.log('all finded projects : ' + currentFindProjects.toString() );
	});
}



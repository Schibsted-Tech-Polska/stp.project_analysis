var fs = require('fs');
var flow = require('nimble');
var fileModule = require('../custom_modules/fileModule');
var paths = require('../custom_modules/paths');
var logger = require('winston');
var executor = require('../custom_modules/executorModule');
var nameOfModule = 'sonarModule';
var datastoreModule = require('../custom_modules/datastoreModule');
var PropertiesGenerator = require('../custom_modules/PropertiesGenerator');
var xmlParserModule = require('../custom_modules/xmlParserModule');


var languageToFileMap = {'java' : 'java.properties',
						'php' : 'php.properties' ,
						'js' : 'js.properties'};

var sonarRunnerCommand= 'sonar-runner';
var platoCommand = 'plato -r -d reports .';

var nameOfPropertiesFile = 'sonar-project.properties';

var basePropertiesPath = function(){
	return __dirname.replace('custom_modules','base_properties');
};


function AnalyzeExecution(absoluteLocationOfProject){
	this.absoluteLocationOfProject = absoluteLocationOfProject;
	this.options = [];
	this.commands = [];
};
AnalyzeExecution.prototype.execute = function(lastCallback){
	console.log('absoluteLocationOfProject : ' + this.absoluteLocationOfProject);

	var progressIncrementator = function(nameOfProject){
		return function(){
			datastoreModule.incrementStatus(nameOfProject);
		};
	};
	var nameOfProject = fileModule.extractFileNameFromPath(this.absoluteLocationOfProject);

	lastCallback =  lastCallback ||
	fileModule.deleteFolder(this.absoluteLocationOfProject , progressIncrementator(nameOfProject));

	executor.executeCommands(this, lastCallback, nameOfProject);
};
AnalyzeExecution.prototype.toString = function(){
	var self = this;
   return this.commands.map(function(current,i){
		console.log('commands nr ' + i + " : " + current +" location : " + self.commands[i].cwd) ;
	});
};


exports.analyze = function(properties){

	logger.info(nameOfModule, 'used analysisTool : ' + properties.analysisTool);
	var configPlaceholders = {'UNIQUE_KEY' : escapeCharacters(properties.link),
							  'NAME' : properties.nameOfGitRepo,
							  'EXCL' : properties.filesToOmit };

	flow.series([
		 function(callback){
	 		logger.info(nameOfModule, "step1 - generating properties file");
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

		project.options[0] = options;
	 	project.options[1] = options;
		project.commands[0] = javaBuildCommand;
        project.commands[1] = 'mvn sonar:sonar';

	}else if(javaBuildCommand.indexOf('ant') !== -1){
		options.cwd = projectLocation;
		project.options[0] = options;
	 	project.options[1] = options;
		project.commands[0] = javaBuildCommand;
        project.commands[1] =  sonarRunnerCommand;
	}else{
		options.cwd = projectLocation;
		project.options[0] = options;
		project.commands[0] = sonarRunnerCommand;
	}

	project.execute();

}


function startOtherLanguagesClient(properties){
	 var options = {
            cwd: properties.projectLocation
	 	 };


	 	 var  project = new AnalyzeExecution(properties.projectLocation);
	 	 project.options[0] = options;
	 	 if(properties.analysisTool === 'plato'){
	 	 	var incrementStatus = function(){
				datastoreModule.incrementStatus(properties.nameOfGitRepo);
		 	};
	 	 	project.commands[0] = platoCommand;
	 	 	project.execute(incrementStatus);
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


exports.getUrlOfAnalyzedProject = function(properties, callback){

	console.log('*analysisTool : ' + properties.analysisTool);

    if(properties.javaBuildCommand.indexOf('mvn') !== -1 ){
    	var locationOfExectuting = [properties.projectLocation, properties.binaries].join('/');
		var pathToPomFile = fileModule.extractDirectoryFromPath(locationOfExectuting);
		var locationOfPomFile = [pathToPomFile,'pom.xml'].join('/');

		console.log('-->location of pom file : ' + locationOfPomFile);
   		properties.locationOfPomFile = locationOfPomFile;
   		properties.sonarUrl = paths.sonarUrl();
		xmlParserModule.constructLinkToAnalyzedProject(properties, callback);

	}else if(properties.analysisTool === 'sonar'){
		var sonarUrl = paths.sonarUrl();
    	properties.linkToAnalyzedProject = sonarUrl+escapeCharacters(properties.link);
    	callback();
	}else{
		var appUrl = paths.applicationUrl();
		var platoSuffix = "/reports/index.html";
		properties.linkToAnalyzedProject =  [appUrl, properties.nameOfGitRepo, platoSuffix].join('');
		callback();
	}

};

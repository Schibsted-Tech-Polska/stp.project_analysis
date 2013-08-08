var sourceFinder = require('../custom_modules/sourceFinderModule');
var logger = require('winston');
var nameOfModule = 'PropertiesGenerator';

exports.create = function(properties){
	return new PropertiesGenerator(properties);
};

//TODO ProjectMetainfo not properties
function PropertiesGenerator( properties ){
	console.log('-->sources : ' + properties.sources);
	var filesToOmit = properties.filesToOmit;
	this.SRC = properties.sources;
	this.BIN = properties.binaries;
	//var startFinder = false;
	

	this.parameters = {
		'projectLocation':properties.projectLocation,
		'extension':"."+properties.language
	};

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
	if(this.BIN){
		propertiesToChange.BIN = this.BIN;
	}
		propertiesToChange.SRC = this.SRC;
		callback(propertiesToChange);		
};
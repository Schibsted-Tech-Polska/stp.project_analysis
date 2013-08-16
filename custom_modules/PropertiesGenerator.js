var sourceFinder = require('../custom_modules/sourceFinderModule');
var logger = require('winston');
var nameOfModule = 'PropertiesGenerator';

exports.create = function(properties){
	return new PropertiesGenerator(properties);
};

function PropertiesGenerator( properties ){
	console.log('-->sources : ' + properties.sources);
	var filesToOmit = properties.filesToOmit;
	this.SRC = properties.sources;
	this.BIN = properties.binaries;
	
	this.parameters = {
		'projectLocation':properties.projectLocation,
		'extension':"."+properties.language
	};

		this.parameters.filesToOmit = filesToOmit;
	
	logger.info(nameOfModule, 'files that will be ingnored by propertiesGenerator ' + this.parameters.filesToOmit );
}

PropertiesGenerator.prototype.generate = function(propertiesToChange,callback){
	if(this.BIN){
		propertiesToChange.BIN = this.BIN;
	}
		propertiesToChange.SRC = this.SRC;
		callback(propertiesToChange);		
};
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
	console.log('this.sources : ' + this.SRC);
	if(this.SRC == undefined || this.SRC ==''){
		sourceFinder.findSrcLocation(this.parameters ,propertiesToChange, callback);	
	}else{
		console.log('--->user type sources location @ : ' + this.SRC );
		propertiesToChange.SRC = this.SRC;
		propertiesToChange.BIN = this.BIN;
		callback(propertiesToChange);		
	}
};
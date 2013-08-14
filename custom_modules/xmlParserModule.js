	var fs = require('fs'),
	    eyes = require('eyes'),
	    xml2js = require('xml2js');
	var logger = require('winston');
	var nameOfModule = 'xmlParserModule';

exports.constructLinkToAnalyzedProject = function(properties, callback){


	var parser = new xml2js.Parser();

	parser.on('end', function(result) {
		 eyes.inspect(result);
		 var link = [result.project.groupId, result.project.artifactId].join(':');
		 properties.linkToAnalyzedProject = properties.sonarUrl + link;
		 callback();
	 
	});
    fs.readFile(properties.locationOfPomFile, function(err, data) {
		if(err){
			logger.info(nameOfModule,
				'error when read file from : ' + properties.locationOfPomFile + ' err: ' + err);
		}
		try{
			parser.parseString(data);
		}catch(err){
			console.log('catch : ' + err);
		}
	});
};

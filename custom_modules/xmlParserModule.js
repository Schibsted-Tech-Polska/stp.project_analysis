	var fs = require('fs'),
	    eyes = require('eyes'),
	    xml2js = require('xml2js');

exports.constructLinkToAnalyzedProject = function(properties, callback){


	var parser = new xml2js.Parser();

	parser.on('end', function(result) {
	 console.log('artifactId : ' + result.project.artifactId);
	 console.log('groupId : ' + result.project.groupId);
	 eyes.inspect(result);
	 var link = [result.project.groupId, result.project.artifactId].join(':');
	 console.log('---> link : ' + link);
	 properties.linkToAnalyzedProject = properties.sonarUrl + link;
	 callback();
	 
	});

	fs.readFile(properties.locationOfPomFile, function(err, data) {
	  parser.parseString(data);
	});
}
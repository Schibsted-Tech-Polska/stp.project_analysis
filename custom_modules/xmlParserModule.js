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
    console.log('properties.locationOfPomFile : ' + properties.locationOfPomFile);
	fs.readFile(properties.locationOfPomFile, function(err, data) {
		console.log('data : ' + data);
	  	parser.parseString(data);
	});
}

/*
exports.getArrayOfProperties = function(data){
	console.log('parser receive : ' + data);
	var parser = new xml2js.Parser();
	//var cleanedString = data.replace("\ufeff", "");
	parser.parseString(data);

	parser.on('end', function(result){
		eyes.inspect(result);
	});
}*/
var underscore = require('underscore');
var Glob = require("glob");
var flow = require('nimble');
var nameOfModule = 'sourceFinderModule';
var logger = require('winston');
var findit = require('findit');
/**
*@param {parameters} should contain : projectLocation, extension, filesToOmit[]

@example
   parameters = {
				'extension':'.js',
				'projectLocation':users/you/project/location,
				'filesToOmit':['jshint','jquery']
				}
*/
exports.findSrcLocation = function(parameters, propertiesToChange, cb){
	var projectLocation = parameters.projectLocation;
	var finder = findit.find(projectLocation);
	var filesToOmit = parameters.filesToOmit;
	logger.info(nameOfModule, 'filesToOmit by findSrcLocation : ' + filesToOmit);
	var allFiles = [];

	flow.series([
		function(callback){
			finder.on('file', function (file) {
				if(contains(file,parameters.extension)){
					var extracted = extractDirectory(file);
					if(shouldPushNewPath(allFiles, extracted)){
						allFiles.push(extracted);
					}
				}
		    });
			finder.on('end', function(){
				callback();
			});
		},
		function(callback){
			console.log('allFiles : ' + allFiles);
			propertiesToChange.SRC = allFiles;
			cb(propertiesToChange);
		}
		]);
};

function shouldPushNewPath(directoriesWithFile,extracted){
	return !underscore.contains(directoriesWithFile,extracted)
    			&& !isSubpath(directoriesWithFile, extracted);
}

function isSubpath(paths, path){
	var result = false;
	paths.map(function(currentPath){
		if(contains(path, currentPath)){
			result = true;
		}
	});
	return result;
}

function contains(path, expression){
	if(path.indexOf(expression) !== -1){
		return true;
	}
	return false;

}



function anyOf(path, expressions, predicate){
	var result = false;
	expressions.map(function(currentExpression){
		if(predicate(path, currentExpression)){
			result = true;
		}
	});
	return result;
}

function extractDirectory(path){
	var delimeter = '/';
	var splittedPath = path.split(delimeter);
	var indexOfLastElement = splittedPath.length - 1;
	var nameToCutFromPath = splittedPath[indexOfLastElement];
	var result = path.substring(0, path.length - nameToCutFromPath.length);
	return result;


}
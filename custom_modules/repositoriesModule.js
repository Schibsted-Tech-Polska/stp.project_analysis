 var exec = require('child_process').exec;
var paths = require('../custom_modules/paths');
var logger = require('winston');
var svnCheckoutCommand = 'svn checkout';
var locationOfFolderWithProjects = paths.locationOfFolderWithProjects();
var nameOfModule = 'repositoriesModule';

exports.downloadRepo = function(properties,callback){

	
	var link = properties.link;
	var gitCommand = properties.gitCommand;
	logger.info(nameOfModule, 'downloadRepo from : ' + link );
	
	if(contains(link, "git")){
		downloadFromVersionControl(gitCommand, link, callback);
	}else if(contains(link, "svn")){
		downloadFromVersionControl(svnCheckoutCommand, link, callback);
	}
	
}
  
function downloadFromVersionControl(command, link, callback){
	var options = {
		cwd : locationOfFolderWithProjects
	};

	exec([command,link].join(' '), options,
		function (error, stdout, stderr) {
			if(error){
				logger.info(nameOfModule, " error" + error + " while executing command : " + command +
										  "\n with link : " + link );
			}
			callback();
		});
}



exports.getNameOfRepo = function(link){
	var delimeter = '/';
	var splittedLink = link.split(delimeter);
	var indexOfLastElem = splittedLink.length - 1;
	
	if(splittedLink[indexOfLastElem] == '')
		return splittedLink[indexOfLastElem-1];	
	return splittedLink[indexOfLastElem];
}

function contains(path, expression){
	if(path.indexOf(expression) != -1) 
		return true;
	return false;

} 
 var exec = require('child_process').exec;
var paths = require('../custom_modules/paths');
var logger = require('winston');
var svnCheckoutCommand = 'svn checkout';
var locationOfFolderWithProjects = paths.locationOfFolderWithProjects();
var nameOfModule = 'repositoriesModule';
var datastoreModule = require('../custom_modules/datastoreModule');

exports.downloadRepo = function(properties,callback){
	var link = properties.link;
	var gitCommand = properties.gitCommand;
	logger.info(nameOfModule, 'downloadRepo from : ' + link + 'with command : ' + gitCommand);
	
	if(contains(link, "git")){
		downloadFromVersionControl(gitCommand, properties, callback);
	}else if(contains(link, "svn")){
		downloadFromVersionControl(svnCheckoutCommand, properties, callback);
	}
};
  
function downloadFromVersionControl(command, properties, callback){
	var link = properties.link;
	var options = {
		cwd : locationOfFolderWithProjects
	};

	exec([command,link].join(' '), options,
		function (error, stdout, stderr) {
			if(error){
				logger.info(nameOfModule, " error" + error + stderr + stdout + " while executing command : " + command +
										  "\n with link : " + link );
			}
			//datastoreModule.incrementStatus(properties.nameOfGitRepo);
			callback();
		});
}



exports.getNameOfRepo = function(link){
	var delimeter = '/';
	var splittedLink = link.split(delimeter);
	var indexOfLastElem = splittedLink.length - 1;
	
	if(splittedLink[indexOfLastElem] === ''){
		return splittedLink[indexOfLastElem-1];	
	}
	return splittedLink[indexOfLastElem];
};

function contains(path, expression){
	if(path.indexOf(expression) !== -1){
		return true;
	}
	return false;

} 
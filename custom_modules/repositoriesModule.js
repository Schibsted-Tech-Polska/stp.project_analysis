 var exec = require('child_process').exec;
var paths = require('../custom_modules/paths');
var logger = require('winston');
var svnCheckoutCommand = 'svn checkout';
var locationOfFolderWithProjects = paths.locationOfFolderWithProjects();
var nameOfModule = 'repositoriesModule';
var datastoreModule = require('../custom_modules/datastoreModule');
var configSsh = require('../configSsh');

exports.downloadRepo = function(properties,callback){
	var link = properties.link;
	var gitCommand = properties.gitCommand;
	logger.info(nameOfModule, 'downloadRepo from : ' + link + 'with command : ' + gitCommand);

	if(contains(link, "git")){
		downloadFromSshForGit(gitCommand, link, callback);
		//downloadFromVersionControl(gitCommand, sshLink, callback);
	}else if(contains(link, "svn")){
		downloadFromVersionControl(svnCheckoutCommand, link, callback);
	}
};




function downloadFromSshForGit(command, link, callback){
	var sshLink = makeSshLinkForGit(link);
	var partialCommand = "ssh-agent bash -c 'ssh-add " +
						 configSsh.getSshLocation() + "; "
	var finalCommand = partialCommand + command + " " + sshLink + "'";

	var options = {
		cwd : locationOfFolderWithProjects
	};

	exec(finalCommand, options,
		function (error, stdout, stderr) {
			if(error){
				logger.info(nameOfModule, " error" + error + stderr + stdout + " while executing command : " + command +
										  "\n with link : " + link );
			}
			callback();
		});
}

exports.convertGitHttpToSsh = function(link){
	return makeSshLinkForGit(link);
};

function makeSshLinkForGit(link){
	var prefix = 'git@github.com:';
	var delimeter = '/';
	var splittedLink = link.split(delimeter);
	var indexOfLastElem = splittedLink.length - 1;
	var suffix = [splittedLink[indexOfLastElem-1],splittedLink[indexOfLastElem]].join('/');
	return prefix + suffix  + '.git';
}

function downloadFromVersionControl(command, link, callback){

	var options = {
		cwd : locationOfFolderWithProjects
	};

	exec([command,link].join(' '), options,
		function (error, stdout, stderr) {
			if(error){
				logger.info(nameOfModule, " error" + error + stderr + stdout + " while executing command : " + command +
										  "\n with link : " + link );
			}
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
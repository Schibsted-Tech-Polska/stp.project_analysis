var nameOfFolderWithProject = 'analyzedProjects';

function getServerPath(){
	console.log("---======= " + GLOBAL.serverPath);
	return GLOBAL.serverPath;
}

exports.locationOfFolderWithProjects =function(){
	return  __dirname.replace('custom_modules',nameOfFolderWithProject);
};
var sonarPort = 9000;
function sonarUrl(){
	return "http://"+ getServerPath()+":"+sonarPort+"/";
};
exports.sonarUrlPort = function(){
	return sonarUrl();
};
exports.getUrlForAllStatuses = function(){
	return sonarUrl()+'api/projects/';
}

exports.sonarUrl = function(){
	return sonarUrl() + "dashboard/index/";
	
};

var applicationPort = 3000;
exports.getApplicationPort = function(){
	return applicationPort;
};

exports.applicationUrl = function(){
	return "http://"+getServerPath()+":"+applicationPort+"/";
};


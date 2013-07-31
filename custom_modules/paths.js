var nameOfFolderWithProject = 'analyzedProjects';

exports.locationOfFolderWithProjects =function(){
	return  __dirname.replace('custom_modules',nameOfFolderWithProject);
};

exports.sonarUrl = function(){
	return "http://localhost:9000/dashboard/index/";
};

var port = 3000;
exports.getPort = function(){
	return port;
};

exports.applicationUrl = function(){
	return "http://localhost:"+port+"/";
};


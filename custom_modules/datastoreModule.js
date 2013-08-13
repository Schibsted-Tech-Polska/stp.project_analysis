var logger = require('winston');
var nameOfModule = 'datastoreModule';

exports.addNewAnalysis = function(projectName){
	var current = findByProjectName(PROGRESS_STATUS, projectName);
	console.log('current -----> ' + current);
	if(current === undefined ){
		PROGRESS_STATUS.push({'projectName' : projectName, 
							  'status' : 1, 
							  'linkToAnalyzedProject' : '',
							  'log': [],
							  'errorWhenExecuting': false });
		console.log('adding new analysis : ' + PROGRESS_STATUS);
	}else{
		console.log('set current status to ' + 1);
		current.status = 1;
		current.log = [];
		current.errorWhenExecuting = false;
	}
};
exports.incrementStatus = function(projectName){
	console.log('incrementStatus for : ' + projectName);
	var record = findByProjectName(PROGRESS_STATUS, projectName);
	record = {'projectName' : projectName,
			   'status' : ++record.status };
};

exports.getRecordForProjectName = function(projectName){
	return findByProjectName(PROGRESS_STATUS, projectName);
};  

exports.appendToLog = function(projectName, data){
	var findedProject = findByProjectName(PROGRESS_STATUS, projectName);
	if (findedProject !== undefined){
		findedProject.log.push(data);
	}
};

exports.addLinkToAnalysis = function(projectName, linkToAnalyzedProject){
	var result = findByProjectName(PROGRESS_STATUS, projectName);
	result.linkToAnalyzedProject = linkToAnalyzedProject;
};

exports.didAnalyzeExist = function(projectName){
	var result = findByProjectName(PROGRESS_STATUS, projectName);
	return result !== undefined;
};

exports.getLinkToAnalyzedProject = function(projectName){
	var result = findByProjectName(PROGRESS_STATUS, projectName);
	return result.linkToAnalyzedProject;
}

exports.setErrorWhenExecuting = function(projectName){
	var findedProject = findByProjectName(PROGRESS_STATUS, projectName);
	console.log('set error for projectName : '+ findedProject.projectName);
	if (findedProject !== undefined){
		findedProject.errorWhenExecuting = true;
	}
	
}

function findByProjectName(source, projectName) {
  for (var i = 0; i < source.length; i++) {
    if (source[i].projectName === projectName) {
      return source[i];
    }
  }
  logger.info(nameOfModule, "Couldn't find object with projecetName: " + projectName);
  return undefined;
  
}
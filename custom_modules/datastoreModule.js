var logger = require('winston');
var nameOfModule = 'datastoreModule';

exports.addNewAnalysis = function(projectName, linkToAnalyzedProject){
	console.log("**** receive linkToAnalyzedProject : " + linkToAnalyzedProject);
	var current = findByProjectName(PROGRESS_STATUS, projectName);
	console.log('current -----> ' + current);
	if(current === undefined ){
		PROGRESS_STATUS.push({'projectName' : projectName, 
							  'status' : 0, 
							  'linkToAnalyzedProject' : linkToAnalyzedProject});
		console.log('adding new analysis : ' + PROGRESS_STATUS);
	}else{
		console.log('set current status to ' + 0);
		current.status = 0;
		current.linkToAnalyzedProject = linkToAnalyzedProject;
	}
};
//TODO fix when same project analyzed twice
exports.incrementStatus = function(projectName){
	console.log('incrementStatus');
	var record = findByProjectName(PROGRESS_STATUS, projectName);
	record = {'projectName' : projectName,
			   'status' : ++record.status };
};

exports.getRecordForProjectName = function(projectName){
	return findByProjectName(PROGRESS_STATUS, projectName);
};   

function findByProjectName(source, projectName) {
  for (var i = 0; i < source.length; i++) {
    if (source[i].projectName === projectName) {
      return source[i];
    }
  }
  logger.info(nameOfModule, "Couldn't find object with projecetName: " + projectName);
  return undefined;
  
}
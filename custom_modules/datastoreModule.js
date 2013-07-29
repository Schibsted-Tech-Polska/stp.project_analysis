exports.addNewAnalysis = function(projectName){
	var current = findByProjectName(PROGRESS_STATUS, projectName);
	if(current === undefined ){
		PROGRESS_STATUS.push({'projectName' : projectName, 
							  'status' : 0});
		console.log('adding new analysis : ' + PROGRESS_STATUS);
	}else{
		current.status = 0;
	}
}

//TODO fix when same project analyzed twice
exports.incrementStatus = function(projectName){
	console.log('incrementStatus');
	var record = findByProjectName(PROGRESS_STATUS, projectName);
	record = {'projectName' : projectName,
			   'status' : ++record.status };
}

exports.getRecordForProjectName = function(projectName){
	return findByProjectName(PROGRESS_STATUS, projectName);
}   

function findByProjectName(source, projectName) {
  for (var i = 0; i < source.length; i++) {
    if (source[i].projectName === projectName) {
      return source[i];
    }
  }
  return undefined;
  console.log("Couldn't find object with projecetName: " + projectName);
}
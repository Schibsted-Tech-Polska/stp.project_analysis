var request = require('request');
var paths = require('../custom_modules/paths');
var xmlParser = require('../custom_modules/xmlParserModule');
var logger = require('winston');
var nameOfModule = 'projectStatus';
var datastoreModule = require('../custom_modules/datastoreModule');

exports.status = function(req, res){
	var id = req.params.id;
	console.log('id of requests : ' + id);
	if(datastoreModule.didAnalyzeExist(id)){
		res.render('projectStatus',
		{'nameOfGitRepo':id});
	}else{
		res.status(404).send('Not found');
	}	

	
};

exports.allStatuses = function(req, res){
	var url = paths.sonarUrlPort() + 'api/projects/';
	
	request.get({'url':url,
				json:true},
	 		function(error,response,body){
	 			if(error){
	 				logger.info(nameOfModule, 'error while retriving all statuses from /api/projects/ : '+ err );
	 			}
	 		console.log("response :" + body );
			renderStatuses(res, body);		
	});
};
function renderStatuses(res, data){
	var url = paths.sonarUrl();
	data.map(function(current){
		console.log(current);
		current.url = url + current.k;
	});

	res.render('allStatuses',{ 'projects':data });
}
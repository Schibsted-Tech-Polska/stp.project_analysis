var request = require('request');
var paths = require('../custom_modules/paths');
var xmlParser = require('../custom_modules/xmlParserModule');

exports.status = function(req, res){
	var id = req.params.id;
	console.log('id of requests : ' + id);
	res.render('projectStatus',
		{'nameOfGitRepo':id});
};

exports.allStatuses = function(req, res){
	var url = paths.sonarUrlPort() + 'api/projects/';
	
	request.get({'url':url,
				json:true},
	 		function(error,response,body){
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
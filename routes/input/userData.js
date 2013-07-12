var gitModule = require('gitModule');
var sonarModule = require('sonarModule');
var utilModule = require('utilModule');
var flow = require('nimble');

exports.form = function(req, res){
res.render('inputForm', {
	title: 'analysis tool'
	});
};


exports.submit = function(data){
	
	
	return function(req, res, next){
		var link = req.body.link;
		console.log('receive data ' + link);
		var targetLanguage = req.body.targetLanguage;
		console.log('targetLanguage : ' + targetLanguage);
		var javaBuildCommand = req.body.command;
		console.log('javaBuildCommand: ' + javaBuildCommand);

     	var nameOfGitRepo;
		var interval = 15000;//10s
		flow.series([
			function(callback){
				console.log("--->first callback");
				nameOfGitRepo = gitModule.getNameOfRepo(link);
				console.log("nameOfGitRepo : " + nameOfGitRepo);
				callback();
			},
			function(callback){
				console.log("--->second callback");
	        	gitModule.cloneRepo(link,callback);
			},
			function(callback){
				 console.log("--->third callback");
				 var projectLocation = utilModule.buildAbsolutePath(nameOfGitRepo);
				 var properties = {
				 	'targetLanguage' : targetLanguage,
				 	'projectLocation' : projectLocation,
				 	'link' : link,
				 	'nameOfGitRepo' : nameOfGitRepo,
				 	'javaBuildCommand' : javaBuildCommand
				 };
				 sonarModule.analyze(properties);
				 console.log("---->third finished");
			}

		]);
        var linkToAnalyzedProject = sonarModule.getUrlOfAnalyzedProject(link);
		console.log("-------link to analyzed project : " + linkToAnalyzedProject);
		res.setHeader('202');
		res.redirect(linkToAnalyzedProject);

     };
}
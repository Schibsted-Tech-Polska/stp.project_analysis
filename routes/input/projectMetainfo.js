var gitModule = require('gitModule');
var sonarModule = require('sonarModule');
var utilModule = require('fileModule');
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
		var language = req.body.targetLanguage;
		console.log('targetLanguage : ' + language);
		var javaBuildCommand = req.body.command;
		console.log('javaBuildCommand: ' + javaBuildCommand);

        startAnalysisProcess(link, language, javaBuildCommand);

        var linkToAnalyzedProject = sonarModule.getUrlOfAnalyzedProject(link);
		console.log("-------link to analyzed project : " + linkToAnalyzedProject);
		res.setHeader('202');
		res.redirect(linkToAnalyzedProject);

     };
}

function startAnalysisProcess(link, language, javaBuildCommand){

        

        var nameOfGitRepo;
		//TODO make 3 functions
		flow.series([
			function(callback){
				nameOfGitRepo = gitModule.getNameOfRepo(link);
				callback();//inlnie
			},
			function(callback){
				gitModule.cloneRepo(link,callback);
			},
			function(callback){


				 console.log("--->third callback");
				 var projectLocation = utilModule.buildAbsolutePath(nameOfGitRepo);
				 var properties = {
				 	'language' : language,
				 	'projectLocation' : projectLocation,
				 	'link' : link,
				 	'nameOfGitRepo' : nameOfGitRepo,
				 	'javaBuildCommand' : javaBuildCommand
				 };
				 sonarModule.analyze(properties);
				 console.log("- prop lang : "+ properties.language);
				 console.log("---->third finished");
			}

		]);


}
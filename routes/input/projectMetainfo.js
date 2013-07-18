var repoModule = require('repositoriesModule');
var sonarModule = require('sonarModule');
var fileModule = require('fileModule');
var flow = require('nimble');
var validationModule = require('validationModule');
var jsFilesToOmit=require('javaScriptFilesToOmit');

exports.form = function(req, res){
res.render('inputForm', {
	title: 'analysis tool',
	jsFilesToOmit:jsFilesToOmit.getFiles()
	});
};


exports.submit = function(data){
	
	
	return function(req, res, next){

		var link = req.body.link;
		//var language = req.body.targetLanguage;
		//var javaBuildCommand = req.body.command;
		//var gitCommand = req.body.gitCommand;
        console.log('controller get link : ' + link);
		 var properties = {
				 	'language' : req.body.targetLanguage,
				 	'link' : link,
				 	'gitCommand' : req.body.gitCommand,
				 	'javaBuildCommand' : req.body.javaBuildCommand,
				 	'filesToOmit': req.body.filesToOmit
				 };
        
        startAnalysisProcess(properties);

        var linkToAnalyzedProject = sonarModule.getUrlOfAnalyzedProject(link);
		console.log("-------link to analyzed project : " + linkToAnalyzedProject);
		res.setHeader('202');
		res.redirect(linkToAnalyzedProject);



     };
}

function startAnalysisProcess(properties){

        

        //var nameOfGitRepo;
		//TODO make 3 functions
		flow.series([
			function(callback){
				console.log('--> after validationModule ');
				validationModule.validateInput(properties, callback);

			},
			function(callback){
				properties.nameOfGitRepo = repoModule.getNameOfRepo(properties.link);
				console.log('--> extract nameOfGitRepo : ' + properties.nameOfGitRepo);
				callback();//inlnie
			},
			function(callback){
				repoModule.downloadRepo(properties,callback);
			},
			function(callback){


				 console.log("--->third callback");
				 var projectLocation = fileModule.buildAbsolutePath(properties.nameOfGitRepo);
				 console.log('---> projectLocation after build Absolute Path : ' + projectLocation);
				 /*var properties = {
				 	'language' : language,
				 	'projectLocation' : projectLocation,
				 	'link' : link,
				 	'nameOfGitRepo' : nameOfGitRepo,
				 	'javaBuildCommand' : javaBuildCommand
				 };*/
				 properties.projectLocation = projectLocation;
				 sonarModule.analyze(properties);
				 console.log("- prop lang : "+ properties.language);
				 console.log("---->third finished");
			}

		]);


}
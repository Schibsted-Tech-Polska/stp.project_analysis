var repoModule = require('../../custom_modules/repositoriesModule');
var sonarModule = require('../../custom_modules/sonarModule');
var fileModule = require('../../custom_modules/fileModule');
var flow = require('nimble');
var validationModule = require('../../custom_modules/validationModule');
var jsFilesToOmit=require('../../custom_modules/javaScriptFilesToOmit');
var logger = require('winston');


//uncomment if loggin should go to file
//logger.add(logger.transports.File, { filename: 'logfile.log'} );

exports.form = function(req, res){
res.render('inputForm', {
	title: 'analysis tool',
	jsFilesToOmit:jsFilesToOmit.getFiles()
	});
};


exports.submit = function(data){

	
	return function(req, res, next){

		var link = req.body.link;
		var properties = {
				 	'language' : req.body.targetLanguage,
				 	'link' : link,
				 	'gitCommand' : req.body.gitCommand,
				 	'javaBuildCommand' : req.body.javaBuildCommand,
				 	'filesToOmit': req.body.filesToOmit
				 };
        
        properties.nameOfGitRepo = repoModule.getNameOfRepo(properties.link);
        startAnalysisProcess(properties);

        var linkToAnalyzedProject = sonarModule.getUrlOfAnalyzedProject(properties);
        logger.info('projectMetainfo', ' link to analyzed project : ' + linkToAnalyzedProject);
		res.setHeader('202');
		res.redirect(linkToAnalyzedProject);
	};
}

function startAnalysisProcess(properties){
		//var nameOfGitRepo;
		//TODO make 3 functions
		flow.series([
			function(callback){
				validationModule.validateInput(properties, callback);

			},
			//function(callback){
			//	properties.nameOfGitRepo = repoModule.getNameOfRepo(properties.link);
			//	console.log('--> extract nameOfGitRepo : ' + properties.nameOfGitRepo);
			//	callback();//inlnie
			//},
			function(callback){//TODO fix crashing node when link is in bad format
				repoModule.downloadRepo(properties,callback);
			},
			function(callback){
				
				 var projectLocation = fileModule.buildAbsolutePath(properties.nameOfGitRepo);
				 logger.info('projectMetainfo', '---> projectLocation after build Absolute Path : ' + projectLocation);
			
				 properties.projectLocation = projectLocation;
				 sonarModule.analyze(properties);
				
				
			}

		]);
}
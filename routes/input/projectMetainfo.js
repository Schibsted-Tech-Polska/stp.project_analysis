var repoModule = require('../../custom_modules/repositoriesModule');
var sonarModule = require('../../custom_modules/sonarModule');
var fileModule = require('../../custom_modules/fileModule');
var flow = require('nimble');
var validationModule = require('../../custom_modules/validationModule');
var jsFilesToOmit=require('../../custom_modules/javaScriptFilesToOmit');
var logger = require('winston');
var check = require('validator').check;
var viewFormatter = require('../../custom_modules/viewFormatter');
var databaseModule = require('../../custom_modules/databaseModule');

//uncomment if loggin should go to file
//logger.add(logger.transports.File, { filename: 'logfile.log'} );
var getParameters = {
					title: 'Analysis tool',
					jsFilesToOmit: jsFilesToOmit.getFiles().join('\n'),
					errorMessages: ''
					};

exports.form = function(req, res){
	getParameters.errorMessages = '';
	res.render('inputForm', getParameters);
};


exports.submit = function(data){

	
	return function(req, res){

		var link = req.body.link;
		
		var properties = {
				 	'language' : req.body.targetLanguage,
				 	'link' : link,
				 	'gitCommand' : req.body.gitCommand,
				 	'javaBuildCommand' : req.body.javaBuildCommand,
				 	'filesToOmit':  req.body.filesToOmit.split('\n'),
				 	'sources': req.body.sources
				 };

		
		//TODO watch out for possible race conditions!
		validationModule.validateInput(properties);
		
		if(validationModule.hasErrors(properties)){
			getParameters.errorMessages = properties.errorMessages;
			//res.writeHead(400); 
			//res.setHeader('400', {'Content-Type': 'text/html' });
			res.render('inputForm', getParameters);
		}else{
			//res.render('projectStatus');
			var linkToAnalyzedProject = sonarModule.getUrlOfAnalyzedProject(properties);
			databaseModule.addNewAnalysis2(linkToAnalyzedProject);

			properties.nameOfGitRepo = repoModule.getNameOfRepo(properties.link);
			startAnalysisProcess(properties);
			/*var monitor = function(res){
				//return function(){
					var progressCounter = 0
					return function(){
						console.log('progressCounter++ is now ' + progressCounter);
						progressCounter++;
						res.render('projectStatus', {'progressCounter' : progressCounter});
						if(progressCounter == 2 ){
							
							  
					        var linkToAnalyzedProject = sonarModule.getUrlOfAnalyzedProject(properties);
					        logger.info('projectMetainfo', ' link to analyzed project : ' + linkToAnalyzedProject);
							//res.setHeader('302');

							res.redirect(linkToAnalyzedProject);
						}
					}
				//}
			}*/
			
			logger.info('projectMetainfo', ' link to analyzed project : ' + linkToAnalyzedProject);
							//res.setHeader('302');

			res.redirect(linkToAnalyzedProject);
			

	        
		}
	};
}

function startAnalysisProcess(properties){
		//var nameOfGitRepo;
		//TODO make 3 functions
		//monitor();
		flow.series([
			//function(callback){
			//	validationModule.validateInput(properties, callback);
			//
			//},
			function(callback){//TODO fix crashing node when link is in bad format
				//monitor();
				repoModule.downloadRepo(properties,callback);
				
			},
			function(callback){
				 //monitor();
				 var projectLocation = fileModule.buildAbsolutePath(properties.nameOfGitRepo);
				 logger.info('projectMetainfo', '---> projectLocation after build Absolute Path : ' + projectLocation);
			
				 properties.projectLocation = projectLocation;
				 sonarModule.analyze(properties);
				 
			}

		]);
}
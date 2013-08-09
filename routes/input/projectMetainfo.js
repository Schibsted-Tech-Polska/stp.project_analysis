var repoModule = require('../../custom_modules/repositoriesModule');
var sonarModule = require('../../custom_modules/sonarModule');
var fileModule = require('../../custom_modules/fileModule');
var flow = require('nimble');
var validationModule = require('../../custom_modules/validationModule');
var jsFilesToOmit=require('../../custom_modules/javaScriptFilesToOmit');
var logger = require('winston');
var check = require('validator').check;
var viewFormatter = require('../../custom_modules/viewFormatter');
var datastoreModule = require('../../custom_modules/datastoreModule');

//uncomment if loggin should go to file
//logger.add(logger.transports.File, { filename: 'logfile.log'} );
var getParameters = {
					title: 'Analysis tool',
					jsFilesToOmit: jsFilesToOmit.getFiles().join('/\n'),
					errorMessages: '',
					previousValues: ''
					};

exports.form = function(req, res){
	getParameters.errorMessages = '';
	getParameters.previousValues='';
	console.log('fileTo omit : ' + getParameters.jsFilesToOmit);
	res.render('inputForm', getParameters);
};

exports.submit = function(){
	
	return function(req, res){
		var filesToOmit = req.body.filesToOmit;
		console.log('filesToOmit after split: ' + filesToOmit);
		var properties = {
				 	'language' : req.body.targetLanguage,
				 	'link' : req.body.link,
				 	'gitCommand' : req.body.gitCommand,
				 	'javaBuildCommand' : req.body.javaBuildCommand,
				 	'filesToOmit':  req.body.filesToOmit.split('/\n'),
				 	'sources': req.body.sources,
				 	'binaries': req.body.binaries
				 };
		
		//TODO watch out for possible race conditions!
		validationModule.validateInput(properties);
		
		if(validationModule.hasErrors(properties)){
			getParameters.errorMessages = properties.errorMessages;
			getParameters.previousValues = properties.previousValues;
			res.render('inputForm', getParameters);
		}else{
			properties.nameOfGitRepo = repoModule.getNameOfRepo(properties.link);
			startAnalysisProcess(properties);

			datastoreModule.addNewAnalysis(properties.nameOfGitRepo);
			res.redirect('/projectStatus/' + properties.nameOfGitRepo);
		}
	};
};

function startAnalysisProcess(properties){
		flow.series([
			function(callback){//TODO fix crashing node when link is in bad format
				repoModule.downloadRepo(properties,callback);
			},
			function(callback){
				var projectLocation = fileModule.buildAbsolutePath(properties.nameOfGitRepo);
				logger.info('projectMetainfo', '---> projectLocation after build Absolute Path : ' + projectLocation);
			    properties.projectLocation = projectLocation;
			    sonarModule.getUrlOfAnalyzedProject(properties, callback);
			},
			function(callback){
				datastoreModule.addLinkToAnalysis(properties.nameOfGitRepo, properties.linkToAnalyzedProject);
				logger.info('projectMetainfo', 'link to analyzed project : ' + properties.linkToAnalyzedProject);
				callback();

			},
			function(callback){
				 sonarModule.analyze(properties);
				 datastoreModule.incrementStatus(properties.nameOfGitRepo);
			}

		]);
}
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


		/*var nameOfGitRepo = gitModule.getNameOfRepo(link);
		console.log("nameOfGitRepo : " + nameOfGitRepo);
		gitModule.cloneRepo(link);

        
    var projectLocation = utilModule.buildAbsolutePath(nameOfGitRepo);
		sonarModule.analyze(targetLanguage, projectLocation);
*/		var nameOfGitRepo;
		var interval = 10000;//10s
		flow.series([
			function(callback){
				console.log("--->first callback");
				nameOfGitRepo = gitModule.getNameOfRepo(link);
				console.log("nameOfGitRepo : " + nameOfGitRepo);
				callback();
			},
			function(callback){
				 setTimeout(function(){ 
					console.log("--->second callback");
	        gitModule.cloneRepo(link);
	        callback();
	      },interval); 
			},
			function(callback){
				console.log("--->third callback");
				 var projectLocation = utilModule.buildAbsolutePath(nameOfGitRepo);
				 sonarModule.analyze(targetLanguage, projectLocation, link, nameOfGitRepo);
			}

			]);

		res.redirect('/');

     };
}
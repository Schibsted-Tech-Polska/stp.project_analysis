var repositoriesModule = require('../custom_modules/repositoriesModule');
var assert = require('assert');
var link = "https://github.com/tomekl007/mulitmethods_like_clojure";
var expectedNameOfRepo = "mulitmethods_like_clojure";
var svnLink = "https://svn.schibsted-it.no/mno/framework/trunk/";
var expectedNameOfSvnRepo = "trunk";
var normalGitLink = 'https://github.com/schibstednorge/projects_analysis';
var expectedGitSshLink = 'git@github.com:schibstednorge/projects_analysis.git';

describe('get nameOf repo for ' + link, function(){
	it('should return  : ' + expectedNameOfRepo , function(){
		var result = repositoriesModule.getNameOfRepo(link);
		assert.equal(result, expectedNameOfRepo);
		
	})
})

describe('get nameOf repo for ' + svnLink, function(){
	it('should return  : ' + expectedNameOfSvnRepo , function(){
		var result = repositoriesModule.getNameOfRepo(svnLink);
		assert.equal(result, expectedNameOfSvnRepo);
		
	})
})

describe('get ssh link repo for ' + normalGitLink, function(){
	it('should be  : ' + expectedGitSshLink , function(){
		var result = repositoriesModule.convertGitHttpToSsh(normalGitLink);
		assert.equal(result, expectedGitSshLink);
	})
})


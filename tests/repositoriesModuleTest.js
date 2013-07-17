var repositoriesModule = require('repositoriesModule');
var assert = require('assert');
var link = "https://github.com/tomekl007/mulitmethods_like_clojure";
var expectedNameOfRepo = "mulitmethods_like_clojure";
var svnLink = "https://svn.schibsted-it.no/mno/framework/trunk/";
var expectedNameOfSvnRepo = "trunk";

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


var expressValidator = require('express-validator');

describe('sth ' , function(){
	it('should return  : ' , function(){
		var result = repositoriesModule.getNameOfRepo(svnLink);
		assert.equal(result, expectedNameOfSvnRepo);
		
	})
})

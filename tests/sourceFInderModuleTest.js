//run this test with flag -A 
var sourceFinderModule = require('sourceFinderModule');
var fileModule = ('fileModule');

var projectLocation = __dirname + "/testDir";
var exec = require('child_process').exec;
var assert = require('assert');

beforeEach(function(){
  exec(".sh createTestStructure.sh");
})


describe('find src for testDirectory ' , function(){
	it('should propertiesToChange.SRC equal : ', function(done){
		
		var extension = '.js';
		var filesToOmit = ['omit'];
		var parameters = {
							'extension':extension,
							'projectLocation':projectLocation,
							'filesToOmit':filesToOmit
						};
		var propertiesToChange = {};
		sourceFinderModule.findSrcLocation(parameters,propertiesToChange,
			function(propertiesToChange){
				console.log("find : " +propertiesToChange.SRC);
				assert.equal(propertiesToChange.SRC.length,2);
				done();
		});
		
	})
})

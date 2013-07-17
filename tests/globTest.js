var glob = require("glob");
var options = {
		 cwd: "/Users/tomaszlelek/apps/projects_analysis/tests/"
};

describe('test for glob module', function(){
	it('should : ' , function(done){
		glob("*.js",options,function(err,files){
			console.log("file : " + files);
			done();
		});
		
	})
})

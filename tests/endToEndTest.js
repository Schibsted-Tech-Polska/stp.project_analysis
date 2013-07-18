var http = require('http');
var request = require('request');
var assert = require('assert');
var linkToProject="https://github.com/tomekl007/exapmleMavenProject";
var expectedStatusCode = 302;

describe('trigger project analysis and generating report ', function(){
	it('should show location the future locaiton of report  ' + expectedStatusCode , function(done){

	  
	 
	request.post({url:'http://localhost:3000/qualityAnalysis',
	form:{
		link:linkToProject,
		gitCommand:'git clone',
		javaBuildCommand:'none',
		targetLanguage:'java',
		filesToOmit:''
	}}, function(error,response,body){
			console.log("response :" + body + "status code : " +response.statusCode);
			var statusCode = response.statusCode;
			assert.equal(statusCode, expectedStatusCode);//TODO extract from link 
			done();
		});
	
		
    })
})




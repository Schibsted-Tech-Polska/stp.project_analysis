var http = require('http');
var request = require('request');
var assert = require('assert');
var linkToProject="https://github.com/schibstednorge/EscenicToDrMobileConverterWeb";
var expectedStatusCode = 302;

describe('trigger project analysis and generating report ', function(){
	it('should show location the future locaiton of report  ' + expectedStatusCode , function(done){

	  
	 
	request.post({url:'http://localhost:3000/',
	form:{
		link:linkToProject,
		gitCommand:'git clone --recursive',
		javaBuildCommand:'ant',
		targetLanguage:'java',
		filesToOmit:'**/*nothing\n**/*twoNothing',
		sources:'src',
		binaries:'build/artifacts/EscenicToDrMobileConverterWeb-dev.build.jar.classes' 
	}}, function(error,response,body){
			console.log("response :" + body + "status code : " +response.statusCode);
			var statusCode = response.statusCode;
			assert.equal(statusCode, expectedStatusCode);//TODO extract from link 
			done();
		});
		
	
		
    })
})


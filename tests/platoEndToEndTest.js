var http = require('http');
var request = require('request');
var assert = require('assert');
var linkToProject="https://github.com/schibstednorge/aftenposten-windows8";
var expectedStatusCode = 302;

describe('trigger project analysis and generating report ', function(){
	it('should show the future location of report  ' + expectedStatusCode , function(done){

	  
	 
	request.post({url:'http://localhost:3000/',
	form:{
		link:linkToProject,
		gitCommand:'git clone',
		javaBuildCommand:'',
		targetLanguage:'js-plato',
		filesToOmit:'',
		sources:'aftenposten-windows8'
	}}, function(error,response,body){
			console.log("response :" + body + "status code : " +response.statusCode);
			var statusCode = response.statusCode;
			assert.equal(statusCode, expectedStatusCode);//TODO extract from link 
			done();
		});
	
		
    })
})


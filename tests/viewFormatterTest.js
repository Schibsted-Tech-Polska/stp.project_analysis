var util = require("util");
var assert = require('assert');
var formatter = require('../custom_modules/viewFormatter');
var data = "**/*jshint\n**/*jquery\n**/*min";
var expectedOutput = "**/*jshint,**/*jquery,**/*min";


describe("given input data : " + data, function(){
	it('should return formated string like ' + expectedOutput , function(){
		var result = formatter.stringToString('\n', ',', data);		
		console.log(result);
		assert.equal(expectedOutput, result);
	 
	})
})

var analysisToolChecker = require("../custom_modules/analysisToolChecker");
var assert = require('assert');
var properties = {};
var language = 'js-sonar';
var expectedLanguage = 'js';
var expectedAnalysisTool = 'sonar';

describe('checking analysis tool', function(){
	it('after test analysis tool should be set to  ' + expectedAnalysisTool, function(){
		properties.language = language;
		analysisToolChecker.checkAnalysisTool(properties);
		assert.equal(properties.analysisTool , expectedAnalysisTool);
	})
	it('and language should be set to ' + expectedLanguage, function(){
		assert.equal(properties.language, expectedLanguage);
	})
})
var inputCleaner = require('../custom_modules/inputCleaner');
var properties={};
var assert = require('assert');
var expectedSources = "sth"
properties.sources = '/'+expectedSources;
var expectedBinaries = "sth2";
properties.binaries = "/"+expectedBinaries;

describe('sources and binaries after cleaned', function(){
	it('should cont contain ' + "'/'" + "at start of expresstion", function(){
		inputCleaner.cleanInput(properties);
		assert.equal(properties.binaries, expectedBinaries);
		assert.equal(properties.sources, expectedSources);
	})
})

describe('undefined sources and binaries after cleaned', function(){
	it('shoould be still undefined', function(){
		properties.binaries = undefined;
		properties.sources = undefined;
		inputCleaner.cleanInput(properties);
		assert.equal(properties.binaries, undefined);
		assert.equal(properties.sources, undefined);
	})
})
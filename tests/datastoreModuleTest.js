var rewire = require("rewire");
var datastoreModule = rewire("../custom_modules/datastoreModule");
var assert = require('assert');
var projectName = 'exampleProject';
datastoreModule.__set__('PROGRESS_STATUS', []);//mock dependency

describe('add new analysis', function(){
	it('should exist ', function(){
		datastoreModule.addNewAnalysis(projectName);
		assert.notEqual(datastoreModule.didAnalyzeExist(projectName), undefined );
	});

})
describe('increment status of ' + projectName, function(){
	it('should have status equal 2 ', function(){
		datastoreModule.incrementStatus(projectName);
		var resultProject = datastoreModule.getRecordForProjectName(projectName);
		assert.equal(resultProject.status, 2);
	});
})
describe('trying to add analysis with same project Name', function(){
	it('should set current status to 1', function(){
		datastoreModule.addNewAnalysis(projectName);
		assert.equal(datastoreModule.getRecordForProjectName(projectName).status, 1);
	});
})

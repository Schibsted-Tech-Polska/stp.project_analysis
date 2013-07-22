var validationModule = require('validationModule');
var assert = require('assert');
var properties; 
var gitCloneCommand = 'git clone';

beforeEach(function(){
	properties = {
				 	'gitCommand' : '',
				 	'javaBuildCommand' : '',
				 	'filesToOmit': new String('none')
				 };
})

describe('validate git command', function(){
	it('after validation should be equal to : ' + gitCloneCommand , function(){
		properties.gitCommand = "ntoProper git command";
		validationModule.validateInput(properties,function(){
			console.log('callback');
		})
		assert.equal(properties.gitCommand, gitCloneCommand);
		
	})
})


describe('validate java command', function(){
	it('after validation javaBuildCommand should be empty: ' , function(){
		properties.javaBuildCommand = "java";
		validationModule.validateInput(properties,function(){
			console.log('callback');
		})
		assert.equal(properties.javaBuildCommand, '');
		
	})
})

describe('validate java and git command', function(){
	it('after validation should be all properties should be unchanged: ' , function(){
		var antBuildCommand = "ant build";
		var gitCloneCommand = "git clone --recursive";
		properties.javaBuildCommand = antBuildCommand;
		properties.gitCommand = gitCloneCommand;
		validationModule.validateInput(properties,function(){
			console.log('callback');
		})
		assert.equal(properties.javaBuildCommand, antBuildCommand);
		assert.equal(properties.gitCommand, gitCloneCommand);
		
	})
})



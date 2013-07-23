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

describe('java and git commands', function(){
	it('should not change after successful validation: ' , function(){
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

describe('language set to js-plato', function(){
	it('should set language to js, and analysisTool to plato ' , function(){
		properties.language='js-plato';
		validationModule.validateInput(properties,function(){
			console.log('callback');
		})
		assert.equal(properties.language, 'js');
		assert.equal(properties.analysisTool, 'plato');
		
	})
})

describe('language set to js-sonar', function(){
	it('should set language to js, and analysisTool to sonar ' , function(){
		properties.language='js-sonar';
		validationModule.validateInput(properties,function(){
			console.log('callback');
		})
		assert.equal(properties.language, 'js');
		assert.equal(properties.analysisTool, 'sonar');
		
	})
})


var language = 'java';
describe('language set to ' + language, function(){
	it('should language be unchanged, and analysisTool set to sonar ' , function(){
		properties.language=language;
		validationModule.validateInput(properties,function(){
			console.log('callback');
		})
		assert.equal(properties.language, language);
		assert.equal(properties.analysisTool, 'sonar');
		
	})
})



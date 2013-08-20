var validationModule = require('../custom_modules/validationModule');
var assert = require('assert');
var properties;
var gitCloneCommand = 'git clone';

beforeEach(function(){
	properties = {
				 	'gitCommand' : '',
				 	'javaBuildCommand' : '',
				 	'filesToOmit': new String('none'),
				 	'link': 'https://github.com/jhnns/rewire'

				 };
})

describe('validate git command', function(){
	it('after validation should have error messages: ' + gitCloneCommand , function(){
		properties.gitCommand = "ntoProper git command";
		validationModule.validateInput(properties,function(){
			assert.equal(validationModule.hasErrors(properties),true);
		})


	})
})


describe('validate java command', function(){
	it('after validation should have error messages' , function(){
		properties.javaBuildCommand = "java";
		validationModule.validateInput(properties,function(){
			assert.equal(validationModule.hasErrors(properties),true);

		})

	})
})

describe('java and git commands', function(){
	it('should not have errorMessages ' , function(){
		var antBuildCommand = "ant build";
		var gitCloneCommand = "git clone --recursive";
		properties.javaBuildCommand = antBuildCommand;
		properties.gitCommand = gitCloneCommand;
		validationModule.validateInput(properties,function(){
			console.log('callback');
			assert.equal(validationModule.hasErrors(properties), false);
		})


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


describe('link set to not proper value ' + language, function(){
	it('validation should result in link validation messages ' , function(){
 	 	properties.link="https://github.com/schibstednorge/smarttv/blob/master/app/scenes/Article.js#L274";

		validationModule.validateInput(properties,function(){
			assert.equals(properties.errorMessages.link, 'bad link');
		})


	})
})

describe('link set to proper value ' + language, function(){
	it('validation should result in no link validation messages ' , function(){
 	 	properties.link="https://github.com/tomekl007/js_structure_for_testing";

		validationModule.validateInput(properties,function(){
			assert.equals(validationModule.hasErrors(properties), false);
		})


	})
})

var mvnCommand = 'mvn clean vaadin:update-widgetset -Pcompile-widgetset install';
describe('validation of mvn command ' + language, function(){
	it('should result in no validation messages ' , function(){
 	 	properties.javaBuildCommand=mvnCommand;

		validationModule.validateInput(properties,function(){
			assert.equals(validationModule.hasErrors(properties), false);
		})


	})
})



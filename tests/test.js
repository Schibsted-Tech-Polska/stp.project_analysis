var exec = require('child_process').exec;

describe('response', function(){
	it('should return redirecting to ...', function(){
		exec("curl -X POST -H 'Content-Type: application/json' -d '{'link': 'https%3A%2F%2Fgithub.com%2Ftomekl007%2Fmulitmethods_like_clojure%0A',
		'targetLanguage':'java'}' http://localhost:3000/inputForm");
	})
})
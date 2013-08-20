var configSsh = require("../configSsh");
var assert = require('assert');

describe('get path to ssh key', function(){
	it('should return not undefined ', function(){
		var path = configSsh.getSshLocation();
		assert.notEqual(path, undefined);
	})
})
var util = require('util');

exports.stringToString = function(splitSeparator, joinSeparator, string){
	var array = string.split(splitSeparator);
	console.log('splitted array : ' + array);
	return array.join(joinSeparator);
}
exports.cleanInput = function(properties){
	if(startsWithAndIsNotUndefined(properties.sources, "/")){
		properties.sources = properties.sources.substring(1);
	}
	if(startsWithAndIsNotUndefined(properties.binaries, "/")){
		properties.binaries = properties.binaries.substring(1);
	}
};

function startsWithAndIsNotUndefined(string, properStartCommand){
	if(string !== undefined){
		return startsWith(string, properStartCommand);
	}else{
		return false;
	}
}

function startsWith(string, properStartCommand){
	var result = false;

		if(string.substring(0, properStartCommand.length)  === properStartCommand){
			result = true;
		}
	return result;
}
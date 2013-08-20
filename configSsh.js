var customLocation=undefined;

function getDefaultSshLocation(){
  var defaultSshLocation = "~/.ssh/id_rsa_codequality";
  return defaultSshLocation;
}

function getCustomSshLocation(){
	return customLocation;
}

exports.getSshLocation = function(){
	if(customLocation === undefined){
		return getDefaultSshLocation();
	}else{
		return getCustomSshLocation();
	}
};


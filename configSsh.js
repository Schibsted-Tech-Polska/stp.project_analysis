var customLocation=undefined;

function getDefaultSshLocation(){
  return  "~/.ssh/id_rsa";
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


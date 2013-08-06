var filesToOmit = ["file:**/node_modules/**", "public/**"];//TODO change omit to ignore

exports.getFiles = function(){
	return filesToOmit;
};

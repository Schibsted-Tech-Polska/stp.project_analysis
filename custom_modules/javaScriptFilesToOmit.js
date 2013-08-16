var filesToOmit = ["file:**/node_modules/**", "public/**"];

exports.getFiles = function(){
	return filesToOmit;
};

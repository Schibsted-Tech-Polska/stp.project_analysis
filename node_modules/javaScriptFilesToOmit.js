var filesToOmit = ["**/*jshint","**/*jquery","**/*min"];//TODO change omit to ignore

exports.getFiles = function(){
	return filesToOmit;
}
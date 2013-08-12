
var languageToAnalysisTool = {'js-plato' : 'plato'
							 ,'js-sonar' : 'sonar'
							 ,'php' : 'sonar'
							 ,'java' : 'sonar'};
var langageToSonar = {'js-sonar' : 'js'
				     ,'js-plato' : 'js'
				     ,'php' : 'php'
				     ,'java':'java'};							 

exports.checkAnalysisTool = function(properties){
	properties.analysisTool = languageToAnalysisTool[properties.language];
	properties.language = langageToSonar[properties.language];
};
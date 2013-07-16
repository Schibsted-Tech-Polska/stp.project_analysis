mno.namespace('mno.utils.params');

mno.utils.params = (function () {
    var parameters = false,
        path,
        getParameter,
        getAllParameters,
        getPath;

    function processUrl() {
        var fullPath = document.location.href.split("?", 2),
            paramsRaw = (fullPath[1] || "").split("#")[0].split("&") || [],
            i = paramsRaw.length,
            single,
            containsArray = [];

        parameters = [];
        path = fullPath[0];

        while (i--) {
            single = paramsRaw[i].split("=");
		    if(typeof (single[0]) === 'string') {
                if (parameters.hasOwnProperty(single[0])) {
                    if (typeof parameters[single[0]] === 'string') {
                        parameters[single[0]] = [parameters[single[0]]];
                    }
                    parameters[single[0]].push(unescape(single[1]));
                } else {
				    parameters[single[0]] = unescape(single[1]);
                }
            }
        }

    }

    getParameter = function(name) {
        if (parameters === false) {
            processUrl();
        }
        return (typeof parameters[name] === "undefined" ? false : parameters[name]);
    };

    getAllParameters = function getAllParameters() {
        if (parameters === false) {
            processUrl();
        }
        return parameters || false;
    };

    getPath = function() {
        if (parameters === false) {
            processUrl();
        }
        return path || false;
    };

    return {
        getPath:getPath,
        getParameter:getParameter,
        getAllParameters:getAllParameters
    };
}());


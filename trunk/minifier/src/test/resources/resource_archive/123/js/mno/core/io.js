mno.namespace('io');

/** @namespace */
mno.io = function () {
    var imports = {},
        funcNum = 1;

    /**
     * @description Load scripts async and run callback when completed.
     * @param {Object} obj
     * @param {String} obj.url The url of the script
     * @param {Boolean} [obj.reload=false] Load the script again if already loaded
     * @param {Function} obj.error Function to run if there is an error
     * @param {String} [obj.callbackVar=cb] Url variable for callback function. For JsonP.
     * @param {String} [obj.callbackName] Callback function name (e.g. if you want static URL)
     * @param {Function} [obj.jsonP] Callback function for JsonP
     * @param {Function} obj.callback Callback function.
     * @param {Integer} [obj.timeout=5000] timeout in milliseconds (default 5000)
     * @memberOf mno.io
     */
    function getScript(obj) {
        /* Set default properties and override with user properties */
        obj = $.extend({
            url:false,
            reload:false,
            error: function () {},
            callbackVar:'cb',
            cache:30000,
            timeout:5000,
            callback:function () {
            }
        }, obj);
        var scriptId
        funcNum++;

        if (!obj.url) {
            mno.core.log(1, 'getScript missing url');
            return false;
        }

        function removeScript(successful) {
            if (imports[obj.url] !== undefined) {
                $(imports[obj.url].element).remove();
                if (!successful) {
                    imports[obj.url].error();
                }
                delete imports[obj.url];
            }
        }

        if (obj.hasOwnProperty('jsonP')) {
            var jsonP = mno.core.jsonP;

            if (typeof obj.callbackName !== "undefined") {
                scriptId = '_' + obj.callbackName + '_';
            } else {
                scriptId = 'func' + (( Math.round(new Date().getTime() / obj.cache) * obj.cache ) + 'x' + funcNum);
            }
            obj.url += (obj.url.indexOf('?') === -1) ? '?' + obj.callbackVar + '=' : '&' + obj.callbackVar + '=';

            obj.url += 'mno.core.jsonP.' + scriptId;
            mno.core.log(1, 'callbackName: ' + scriptId);

            jsonP[scriptId] = function (data) {
                obj.jsonP(data);
                // because jsonP will not be used again we can remove it directly after function is ran
                delete jsonP[scriptId];
                removeScript(true);
            };
        }

        function runCallback() {
            if (imports[obj.url] !== undefined) {
                imports[obj.url].loaded = true;
                while (imports[obj.url].callback.length > 0) {
                    imports[obj.url].callback.shift()(); /*Run callback*/
                }
            }
            //Removed call to run when loaded. TEST
        }

        function runWhenLoaded() {
            if (!imports.hasOwnProperty(obj.url)) {
                if (imports[obj.url].loaded === true) {
                    runCallback();
                } else {
                    window.setTimeout(function () {
                        runWhenLoaded();
                    }, 50);
                }
            }
        }

        /* Creates a script element in head and run callback on load */
        function load(obj) {
            var timer = window.setTimeout(function () {
                    /* Log to the console that the call timed out, if it did.
                     *
                     * If jsonP[scriptId] is defined, there is a script waiting to be called,
                     *      so we have a timeout.
                     * If it is undefined, it means we already caught an error, called
                     *      the error callback and removed the waiting script, so this
                     *      is not a timeout at all. */
                    if ((typeof(jsonP) !== "undefined")
                        && (typeof(jsonP[scriptId]) !== "undefined")) {
                        mno.core.log(1, obj.url + ' timed out');
                    }
                    removeScript(false);
                }, obj.timeout),
                script = document.createElement('script'),
                firstScript = document.getElementsByTagName('script')[0];

            script.onreadystatechange = function () {
                if (this.readyState === 'complete' || this.readyState === 'loaded') {
                    script.onreadystatechange = null;
                    window.clearTimeout(timer);
                    runCallback();
                }
            };

            script.onerror = removeScript;

            script.onload = function () {
                window.clearTimeout(timer);
                runCallback();
            };

            imports[obj.url] = {
                element:script,
                loaded:false,
                error:obj.error,
                callback:[obj.callback]
            };

            script.src = obj.url;
            script.async = true;
            script.type = 'text/javascript';
            firstScript.parentNode.insertBefore(script, firstScript);
        }

        // TODO : SJEKKE OM SCRIPTET ER IGANG MED Å LASTES
        if (!imports.hasOwnProperty(obj.url)) {
            load(obj);
        } else {
            if (obj.reload === true) {
                /* Remove script element and reload the script */
                removeScript(true);
                load(obj);
            } else {
                /* Script is loaded, run callback */
                imports[obj.url].callback.push(obj.callback);
                runWhenLoaded();
            }
        }
        return true;
    }

    /**
     * @description Get a css file
     * @param {String} url Url of css file.
     */
    function getCSS(url) {
        url = url.indexOf('http://') === -1 ? mno.publication.url + '/resources/skins/' + url : url;
        if (!imports.hasOwnProperty(url)) {
            var css = document.createElement("link"),
                firstScript = document.getElementsByTagName('script')[0];
            css.setAttribute('type', 'text/css');
            css.setAttribute('rel', 'stylesheet');
            css.setAttribute('href', url);
            firstScript.parentNode.insertBefore(css, firstScript);
            imports[url] = css;
        }
    }


    return {
        getScript:getScript,
        getCSS:getCSS
    }
}();
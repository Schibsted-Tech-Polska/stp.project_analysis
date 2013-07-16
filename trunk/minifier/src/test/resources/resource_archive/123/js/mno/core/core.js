/*
 * Core Application for MNO Scalable Javascript Application
 *
 * The core application handles module lifecycle.
 * Based on Nikolas Zakas screencast on Scalable JavaScript Application architecture: http://developer.yahoo.com/yui/theater/video.php?v=zakas-architecture
 *
 * Tor Brekke Skjøtskift
 */

/*global window, mno, $, jQuery, console, document*/
/*jslint nomen: true, plusplus: true */

mno.namespace('core');

/** @namespace mno.core */
mno.core = (function () {
    "use strict";

    var moduleData = {},
        modulesOnCurrentPage = {},
        dataStore = {},
        debugging = false,
        _require,
        _extend,
        _wait;

    /**
     * @public
     * @description Returns all instantiated widgets.
     *
     * @memberOf mno.core
     */
    function getModuleData(widgetId) {
        return widgetId ? moduleData[widgetId] : moduleData;
    }

    /**
     * @public
     * @description Creates an instance of the module
     *
     * @param moduleId
     * @memberOf mno.core
     */
    function _createInstance(moduleId) {
        var sandbox = mno.sandbox.create(moduleId),
            instance = moduleData[moduleId].creator(sandbox),
            method;

        instance.$ = sandbox.$;

        if (!debugging) {
            //Looper gjennom alle funksjoner i modulen og legger på errorHandling
            $.each(instance, function (i, name) {
                method = instance[name];
                if (typeof method === "function") {
                    instance[name] = (function (name, method) {
                        return function () {
                            try {
                                return method.apply(this, arguments);
                            } catch (ex) {
                                mno.core.log(1, name + "(): " + ex.message);
                            }
                        };
                    }(name, method));
                } // end if
            }); // end for
        } // end if

        return instance;
    }

    function _instantiate(moduleId) {
        if (typeof moduleData[moduleId] !== "undefined") {
            if (moduleData[moduleId].require.length !== 0) {
                _require(moduleData[moduleId]);
            } else if (moduleData[moduleId].extend.length !== 0) {
                _extend(moduleData[moduleId]);
            } else {
                moduleData[moduleId].instance = $.extend({}, moduleData[moduleId].instance, _createInstance(moduleId));
                try {
                    if (modulesOnCurrentPage.hasOwnProperty(moduleId) === false) {
                        modulesOnCurrentPage[moduleId] = moduleData[moduleId];
                    }
                    mno.core.log(1, "widget created: " + moduleId);
                    mno.event.triggerEvent({
                        type: moduleId + '-load',
                        data: true
                    });
                } catch (e) {
                    mno.core.log(3, "This error does not affect the other js! Error: failed while running widget: " + moduleId + " width error: " + e);
                    if (e.stack) {
                        mno.core.log(3, e.stack);
                    }
                }
            }
        } else {
            mno.core.log(3, "This error does not affect the other js! moduleId: " + moduleId + " does not exist!!");
        }
    }

    /**
     * @public
     * @description Instantiates the widget and run init
     *
     * @param {String} moduleId The unique widget id.
     * @memberOf mno.core
     */
    function start(moduleId) {
        function init(moduleId) {
            try {
                moduleData[moduleId].instance.init();
                mno.core.log(1, "widget started: " + moduleId);
                mno.event.triggerEvent({
                    type: moduleId + '-init',
                    data: true
                });
            } catch (e) {
                mno.core.log(3, "This error does not affect the other js! Error: failed while running widget: " + moduleId + " width error: " + e);
                if (e.stack) {
                    mno.core.log(3, e.stack);
                }
            }
        }

        if (typeof moduleData[moduleId] !== "undefined") {
            if (moduleData[moduleId].wait.length !== 0) {
                _wait(moduleData[moduleId]);
            } else {
                if (typeof moduleData[moduleId].instance.init === 'function') {
                    init(moduleId)
                } else {
                    var event = {};

                    _instantiate(moduleId);
                    init(moduleId);
                    mno.event.registerEvents(event, moduleId);
                }
            }
        } else {
            mno.core.log(3, "This error does not affect the other js! moduleId: " + moduleId + " does not exist!!");
        }
    }

    /**
     * @public
     * @description Stops a widget
     * @param {String} moduleId A unique widget id.
     * @memberOf mno.core
     */
    function stop(moduleId) {
        var mod = moduleData[moduleId];
        if (mod.instance) {
            mod.instance.destroy();
            mod.instance = null;
        }
    }

    /**
     * @private
     * @description Returns true if module is loaded.
     *
     * @param {String} moduleId The unique id of the widget.
     * @memberOf mno.core
     *
     * @returns {Integer} 0 - The widget does not exist. 1 - The widget is not included in the current page. 2 - The widget will start later. 3 - The widget is already started.
     */
    function _moduleState(moduleId) {
        if (typeof moduleData[moduleId] === 'undefined') {
            return 0;
        } else if (modulesOnCurrentPage.hasOwnProperty(moduleId) === false) {
            return 1;
        } else if ($.isEmptyObject(moduleData[moduleId].instance) === true) {
            return 2;
        } else {
            return 3;
        }
    }

    /**
     * @private
     * @description Loads external Javascript files from the required property in the widget object and start the widget after the files are loaded.
     *
     * @param {Object} mod A widget Object.
     * @memberOf mno.core
     */
    _require = function (mod) {
        if (mod.require.length > 0) {
            var script = mod.require.pop(),
                path;
            /* async load google maps */

            /* Creates path to module. IMPORTANT: Script names cannot contain . (dot) */
            path = script.replace(/\./g, '/') + '.js';
            path = path.replace('widget/', 'widgets/');
            mno.io.getScript({
                url: script.indexOf("http") === 0 ? script : mno.publication.url + 'resources/js/' + path,
                callback: function () {
                    if (moduleData.hasOwnProperty(script)) {
                        mod.wait.push(script);
                        _instantiate(script);
                    }
                    _require(mod);
                }
            });

            mno.core.log(1, mod.id + ' requires ' + script);

            /* endif*/
        } else {
            _instantiate(mod.id);
        }
        /* endif */
    };

    /**
     * @private
     * @description Check the extends property of the widget object and extends the widget.
     *
     * @param {object} mod A widget object.
     * @memberOf mno.core
     */
    _extend = function (mod) {
        /** @inner */
        function _createLoadEvent(parent, mod) {
            mod.extend.push(parent);
            var event = {};
            event[parent + '-load'] = function load() {
                mno.event.removeEvents(parent + '-load', mod.id);
                _instantiate(mod.id);
            };
            mno.event.registerEvents(event, mod.id);
        }

        if (mod.extend.length !== 0) {
            var parent = mod.extend.pop(),
                state = _moduleState(parent);

            mno.core.log(1, mod.id + ' extends ' + parent);
            if (state === 3) {
                mod.instance = $.extend(Object.create(moduleData[parent].instance), mod.instance);
                _instantiate(mod.id);
            } else {
                _createLoadEvent(parent, mod);
                if (state === 1) {
                    _instantiate(parent);
                } else if (state === 0) {
                    mno.core.log(1, parent + ' is not added to the project');
                }
            }
        } else {
            _instantiate(mod.id);
        }
    };

    /**
     * @description Resolves widget start order if supplied in the wait property of the widget object.
     *
     * @param {Object} mod A Widget object.
     * @memberOf mno.core
     */
    _wait = function (mod) {
        if (mod.wait.length > 0) {
            var waitId = mod.wait.pop(),
                event = {};

            if (_moduleState(waitId) !== 2) {
                start(mod.id);
            } else {
                event[waitId + '-init'] = function () {
                    mno.core.log(1, "wait started: " + mod.id);
                    start(mod.id);
                };
                mno.event.registerEvents(event, mod.id);
            }
        }
    };

    /**
     * @public
     * @description Toggle debug mode
     *
     * @param {Boolean} bol
     * @memberOf mno.core
     */
    function debug(bol) {
        debugging = bol;
    }

    /**
     * @public
     * @memberOf mno.core
     * @returns {Boolean}   false = Debugging is off.
     *                      true = Debugging is on.
     */
    function getDebug() {
        return debugging;
    }

    /**
     * @public
     * @description Registers the widget in the application framework.
     *
     * @param {Object} mod A widget object.
     * @memberOf mno.core
     * @example
     * mno.core.register({
     *      id: 'widget.controllerName.viewName'
     *      wait: ['widget.controllerName.viewName','widget.controllerName.viewName'],
     *      extend: ['widget.controllerName.viewName','widget.controllerName.viewName'],
     *      require: ['path/to/script.js'],
     *      forceStart: true,
     *      creator: function (sandbox) {
     *          function init() {
     *              ... Code to be run on instantiation...
     *          }
     *
     *          function destroy() {
     *              ... Clean up variables etc ...
     *          }
     *
     *          return {
     *              init: init;
     *              destroy: destroy
     *          }
     *      }
     * });
     */
    function register(mod) {
        if (!moduleData.hasOwnProperty(mod.id)) {
            moduleData[mod.id] = Object.create(mno.module);
            $.extend(moduleData[mod.id], mod);
        }
    }

    /**
     * @public
     * @description Starts all registered widgets. Use startAllOnCurrentPage instead.
     *
     * @memberOf mno.core
     */
    function startAll() {
        var moduleId;

        for (moduleId in moduleData) {
            if (moduleData.hasOwnProperty(moduleId)) {
                _instantiate(moduleId);
            }
        }

        for (moduleId in moduleData) {
            if (moduleData.hasOwnProperty(moduleId)) {
                start(moduleId);
            }
        }
        mno.event.triggerEvent({
            type:'all-widgets-loaded',
            data:true
        });
    }

    /**
     * @public
     * @description Start all widgets included in the current page. These widgets are listed in mno.model.
     *
     * @memberOf mno.core
     */
    function startAllOnCurrentPage() {
        var widget,
            tmpArray = [],
            moduleId,
            i,
            tmpCheckWidget,
            tmpModuleDataWidget,
            model = mno.model,
            mod;

        //Get all widget ids and put in tmp array

        for (widget in model.widget) {
            if (model.widget.hasOwnProperty(widget)) {
                widget = model.widget[widget];
                tmpArray.push({
                    widgetId: widget.type
                });

                if (typeof widget.mapData !== "undefined" && widget.mapData !== null) {
                    tmpArray.push({widgetId: "widget.slideshow.map"});
                }
                if (typeof widget.weatherContent !== "undefined" && widget.weatherContent !== null) {
                    tmpArray.push({widgetId: widget.weatherContent});
                }
            }
        }

        if (!$.isEmptyObject(model.article)) {
            tmpArray.push({widgetId: "widget.storyContent.article"});
        }

        // check which modules exist on page and set modulesOnCurrentPage object
        //for (mod in moduleData) {
            //if (moduleData.hasOwnProperty(mod) && moduleData[mod].forceStart === true) {
              //  modulesOnCurrentPage[mod] = moduleData[mod];
            //}
        //}

        for (i = 0; i < tmpArray.length; i++) {
            tmpCheckWidget = tmpArray[i];

            tmpModuleDataWidget = moduleData[tmpCheckWidget.widgetId];
            if (typeof tmpModuleDataWidget !== 'undefined') {
                modulesOnCurrentPage[tmpCheckWidget.widgetId] = tmpModuleDataWidget;
            }
        }

        for (moduleId in modulesOnCurrentPage) {
            if (modulesOnCurrentPage.hasOwnProperty(moduleId)) {
                _instantiate(moduleId);
            }
        }

        for (moduleId in modulesOnCurrentPage) {
            if (modulesOnCurrentPage.hasOwnProperty(moduleId)) {
                start(moduleId);
            }
        }

        mno.event.triggerEvent({
            type:'all-widgets-loaded',
            data:true
        });
    }

    /**
     * @public
     * @description Stops all widgets.
     *
     * @memberOf mno.core
     */
    function stopAll() {
        var moduleId;
        for (moduleId in moduleData) {
            if (moduleData.hasOwnProperty(moduleId)) {
                stop(moduleId);
            }
        }
    }

    /**
     * @public
     * @description Logs error messages to console if available.
     *
     * @param {Integer} severity 1 = log, 2 = warn, 3 = error.
     * @param {String|Object} Message.
     * @param {Boolean} forceServerLog Logs messages to server. (Not yet included)
     * @memberOf mno.core
     */
    function log(severity, message, forceServerLog) {
        forceServerLog = (typeof forceServerLog === 'undefined' ? false : forceServerLog);
        /* forecServerLog overrrides debugging if true always log to server */
        /* default forceServerLog is false if not set. debugging is set from main.js depending on url */

        if (forceServerLog || !debugging) {
            var logLevel = (severity === 1 ? 'LOGG' : (severity === 2 ? 'WARN' : (severity === 3 ? 'ERROR' : 'LOGG'))),
                rand = Math.ceil(Math.random() * 10);
            // var uniqeId = Base64.encode(message + navigator.userAgent + logLevel);
            /* only log 10% (limit logging) logging completly off */
//            if (rand === 1) {
            /*$.ajax({
             url: '/template/common/jsLogger/log.jsp',
             data: {
             message: 'message: ' + message + ' useragent: ' + navigator.userAgent,
             level: logLevel,
             debug: 'true'

             },
             type: 'post',
             dataType: 'json',
             cache: false,
             contentType: "application/x-www-form-urlencoded; charset=UTF-8",

             success: function(data){

             }
             });*/
//            }
        } else {
            if (debugging && typeof console === 'object') {
                console[(severity === 1) ? 'log' : (severity === 2) ? 'warn' : 'error'](message);
                if (severity === 3 && typeof console.trace === "function") {
                    console.trace();
                }
            }
        }
    }

    /**
     * @description Removes data of a specific type stored to a widget.
     *
     * @param {String} moduleId Unique widget id.
     * @param {String} type The type of data stored ex. module-position.
     * @memberOf mno.core
     */
    function removeData(moduleId, type) {
        // TODO
    }

    /**
     * @description Stores data of a specific type with a widget
     *
     * @param {String} moduleId A unique widget id.
     * @param {Object} data Data to be stored.
     * @param {String} data.type A string describing the data to be stored
     * @param data.data The data to be stored.
     * @memberOf mno.core
     */
    function storeData(moduleId, data) {
        if ($.isPlainObject(data) && data.type && moduleId) {
            if (!dataStore[data.type]) {
                dataStore[data.type] = {};
            }
            var dataObj = {};
            dataObj[moduleId] = data.data;
            $.extend(dataStore[data.type], dataObj);
        } else {
            mno.core.log(1, data + 'not an valid data object: ' + moduleId);
        }
    }

    /**
     * @description Get data of a specific type
     *
     * @param {String} type The type of data.
     * @memberOf mno.core
     */
    function getData(type) {
        if (dataStore.hasOwnProperty(type)) {
            var result = {},
                data;

            for (data in dataStore[type]) {
                if (dataStore[type].hasOwnProperty(data)) {
                    if (typeof dataStore[type][data] === 'function') {
                        result[data] = dataStore[type][data]();
                    } else {
                        result[data] = dataStore[type][data];
                    }
                }
            }

            return result;
        } else {
            return false;
        }
    }

    /**
     * @description Get the position of the widget container relative to the page and relative to parent.
     * @param {jQuery Object} container
     * @memberOf mno.core
     */
    function getPosition(container) {
        var offset = container.offset(),
            position = container.position();
        return {
            pageX: offset.left,
            pageY: offset.top,
            parentX: position.left,
            parentY: position.top
        };
    }

    /**
     * @description Start a timer for profiling
     * @param {String} name Name of timer
     * @memberOf mno.core.profiling
     */
    function startTimer(name) {
        if (debugging) {
            if (typeof console === 'object' && typeof console.time === 'function') {
                console.time(name);
            }
        }
    }

    /**
     * @description Stops a timer for profiling
     * @param {String} name Name of timer
     * @memberOf mno.core.profiling
     */
    function stopTimer(name) {
        if (debugging) {
            if (typeof console === 'object' && typeof console.timeEnd === 'function') {
                console.timeEnd(name);
            }
        }
    }

    /**
     * @description A general-purpose function to enable a function to use memoization. The function must use explicit, primitive parameters (or objects that generate unique strings in a toString() method).
     * @param {Function} func The function to be memoized.
     * @param context The context for the memoized function to execute within
     * @memberOf mno.core
     */
    function memoize(func, context) {
        function memoizeArg(argPos) {
            var cache = {};
            return function () {
                if (argPos === 0) {
                    if (cache.hasOwnProperty(arguments[argPos]) === false) {
                        cache[arguments[argPos]] = func.apply(context, arguments);
                    }
                    return cache[arguments[argPos]];
                } else {
                    if (cache.hasOwnProperty(arguments[argPos]) === false) {
                        cache[arguments[argPos]] = memoizeArg(argPos - 1);
                    }
                    return cache[arguments[argPos]].apply(this, arguments);
                }
            };
        }
        var arity = func.arity || func.length;
        return memoizeArg(arity - 1);
    }


    return {
        debug: debug,
        getDebug: getDebug,
        register: register,
        start: start,
        startAll: startAll,
        stop: stop,
        stopAll: stopAll,
        log: log,
        removeData: removeData,
        storeData: storeData,
        getData: getData,
        getPosition: getPosition,
        jsonP: {},
        startAllOnCurrentPage: startAllOnCurrentPage,
        /**
         * @namespace
         * @name mno.core.profiling
         * */
        profiling: {startTimer: startTimer, stopTimer: stopTimer},
        memoize: memoize,
        getModuleData: getModuleData
    };
}());
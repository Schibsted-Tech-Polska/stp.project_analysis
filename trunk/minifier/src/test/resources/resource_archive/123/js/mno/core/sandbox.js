mno.namespace('mno.sandbox');

/** @namespace mno.sandbox */
mno.sandbox = function () {
    /**
     * Interface for widgets to communicate with core<br/>
     * Returned by {@link mno.sandbox.create}
     * @name Sandbox
     * @class
     * @inner
     * @param {Object} settings
     * @param {jQuery} settings.container
     * @param {Array} settings.model
     */
    function Sandbox(settings) {
        var that = this;
        for (var i in settings) {
            if (settings.hasOwnProperty(i)) {
                this[i] = settings[i];
            }
        }
        /**
         * Limits the context of the jQuery object to the wrapper element
         *
         * @param selector
         * @param context
         */
        this.$ = function(selector, context) {
            return window.jQuery(selector, that.container);
        };
    }

    /**
     * The wrapper element for the widgets container
     * @memberOf Sandbox.prototype
     * @type {jQuery[]}
     */
    Sandbox.prototype.container = null;

    /**
     * Fields provided by the CMS
     * @type {Object[]}
     * @memberOf Sandbox.prototype
     */
    Sandbox.prototype.model = [];

    $(document).ready(function () { //mno.publication is written last in source. Set after document is ready.
        /**
         * Information about the current publication
         * @type Object
         * @memberOf Sandbox.prototype
         */
        Sandbox.prototype.publication = mno.publication;
    });
    //Sandbox.prototype.publication = function () {return mno.publication;}

    /**
     * Limits the context of the jQuery object to the wrapper element
     *
     * @param selector
     * @param context
     */
    Sandbox.prototype.$ = function(selector, context) {
        if (typeof selector === 'undefined') {
            return window.jQuery;
        } else if (typeof this.container === 'undefined') {
            return window.jQuery(selector);
        } else {
            return window.jQuery(selector, this.container);
        }
    };

    /**
     * Throws an event
     *
     * @param {Object} evt The event object. See {@link mno.event.triggerEvent}
     * @memberOf Sandbox.prototype
     */
    Sandbox.prototype.notify = function(evt) {
        if (window.jQuery.isPlainObject(evt) && evt.type) {
            mno.event.triggerEvent(evt);
        }
        return true;
    };

    /**
     * Creates an event listener.
     * @param {Object} evts See {@link mno.event.registerEvents}
     * @memberOf Sandbox.prototype
     */
    Sandbox.prototype.listen = function(evts) {
        if (window.jQuery.isPlainObject(evts)) {
            mno.event.registerEvents(evts, this.moduleId);
        }
    };

    /**
     * Removes an event listener
     * @param {String|Array} evts See {@link mno.event.removeEvents}
     * @memberOf Sandbox.prototype
     */
    Sandbox.prototype.ignore = function(evts, fn) {
        fn = fn || function () {};
        mno.event.removeEvents(evts, this.moduleId, fn);
    };

    /**
     * Load a script file
     * @param {Object} obj See {@link mno.io.getScript}
     * @memberOf Sandbox.prototype
     */
    Sandbox.prototype.getScript = function(obj) {
        mno.io.getScript(obj);
    };

    /**
     * Stores data for other widgets
     * @param {Object} data See {@link mno.core.storeData}
     * @memberOf Sandbox.prototype
     */
    Sandbox.prototype.storeData = function(data) {
        mno.core.storeData(this.moduleId, data);
    };

    /**
     * Get stored data about other widgets
     * @param {String} type See {@link mno.core.getData}
     * @memberOf Sandbox.prototype
     */
    Sandbox.prototype.getData = function(type) {
        return mno.core.getData(type);
    };

    /**
     * Gets the widget position relative to the page and parent
     * @returns {Object} pageX, pageY, parentX, parentY
     * @memberOf Sandbox.prototype
     */
    Sandbox.prototype.getPosition = function() {
        if (this.container !== null) {
            return mno.core.getPosition(this.container);
        } else {
            return false;
        }
    };

    /**
     * Renders a view
     * @param {String} type name and path to the view
     * @param {Object|Array} data Data to be used in the template
     * @param {Function} callback Callback function with the rendered view supplied as fiorst parameter
     * @memberOf Sandbox.prototype
     * @example
     * sandbox.render('widgets.pageTools.views.fontSize', items, function (data) {
     *       sandbox.container.append(data);
     *   });
     */
    Sandbox.prototype.render = function(type, data, callback) {
        return mno.views.render(type,data,callback);
    };

    /**
     * Starts an widget
     * @param {String} id A unique widget id.
     * @memberOf Sandbox.prototype
     */
    Sandbox.prototype.requireWidget = function(id) {
        return mno.core.start((id));
    };

    /**
     * See {@link mno.core.memoize}
     * @param func
     * @param context
     * @memberOf Sandbox.prototype
     */
    Sandbox.prototype.memoize = function(func, context){
        return mno.core.memoize(func, context);
    };

    /**
     * Creates a {@link Sandbox} Object
     * @param {String} moduleId A unique widget id
     * @memberOf mno.sandbox
     */
    function create(moduleId) {
        var container = null,
            model = [],
            mid,
            m,
            $this;

        if (window.jQuery('.'+moduleId).length !==0) {
            container = window.jQuery('.'+moduleId);
        } else {
            mno.core.log(1,'Missing container for '+moduleId);
        }

        if (container) {
            m = mno.model.widget;

            container.each(function(){
                $this = window.jQuery(this);
                mid = $this.attr('data-widget-id');

                if (m.hasOwnProperty(mid)) {
                    if (m[mid].hasOwnProperty('uiResources')) {
                        var uiResources = {};
                        for (var i=0; i < m[mid].uiResources.length;i++) {
                            if (mno.uiResources.hasOwnProperty(m[mid].uiResources[i])) {
                                uiResources[m[mid].uiResources[i]] = mno.uiResources[m[mid].uiResources[i]]($this); // Call uiResources script with container as parameter
                            }
                        }
                        m[mid].uiResources = uiResources;
                    }
                    model.push(m[mid]);
                }
            });

        }

        return new Sandbox({
            container:container,
            model:model,
            moduleId:moduleId
        });
    }

    return {
        create: create,
        Sandbox:Sandbox
    }
}();
/*
 *
 * Adtech lib ver 2.0
 *
 *  Our main ad library.
 *
 * Loads ads in iframes, as normal javascript-tags, or using script injection.
 *
 * NOTE:    No single ads should be loaded as "Async". If you want to use "Async" (script injection) - ALL ads on the page must be set as async.
 *          They are then loaded using the loadAd() function below.
 *
 *          This is to preserve load order, and to makes sure document.write is captured() correctly, and restored().
 *          If using "Async FIF" or "Javascript" this doesn't matter. These two can be used interchangeably.
 *
 * Author: Thomas Orten, Roar Stette
 *
 * AdElement utils based on code from C. Johansen (cjohansen.no)
 *
 * Copyright: Media Norge Digital AS, Polaris Media ASA (c) 2010, All Rights Reserved
 *
 */

/**
 * Util functions.
 */

var AdElement = {

    /**
     * Function for returning a DOM element.
     * To use all the helper methods below - one HAS to use get().
     *
     * @param {Object|String} arguments The ID of an element to retrieve, or an object with the ID of an iframe,
     *                                  and the div id inside the iframe you are trying to reach; { frame: "iframeid", container:  "diviniframe" }
     */

    get: function() {
        var args = arguments;
        args = args.length === 1 && Object.prototype.toString.call(args[0]) === "[object Array]" ? args[0] : args;
        if (args.length > 1) {
            var results = [];
            for (var i = 0; i < args.length; i++) {
                results.push(AdElement.get(args[i]));
            }
            return results;
        }
        var frame = false;
        try { frame = args[0].frame ? true : false ; } catch (err){}
        return AdElement.extendEl(typeof args[0] === "string" ?
            document.getElementById(args[0]) :
            frame ?
                window[args[0].frame].document !== null ?
                    window[args[0].frame].document.getElementById(args[0].container) :
                    document.getElementById(args[0].frame).contentWindow.document.getElementById(args[0].container) :
                args[0]);
    },
    /**
     * Attach all methods to the returned object, used by get().
     *
     * @param {Object} element The DOM element.
     */

    extendEl: function(element) {
        if (element !== null) {
            if (element.hasClassName != null) {
                return element;
            }
            for (var method in AdElement)

            { if (AdElement.hasOwnProperty(method)) {
                if (method === "get" || method === "extendEl") {
                    continue;
                }
                (function() {
                    var methodName = method;
                    element[methodName] = function() {
                        var args = [this];
                        for (var i = 0; i < arguments.length; i++) {
                            args.push(arguments[i]);
                        }
                        return AdElement[methodName].apply(element, args);
                    };
                })();
            }}
        }
        return element;
    },

    /**
     * Check to see whether an element has a given classname.
     *
     * @param {Object} element The DOM element.
     * @param {String} className The className to check for.
     */

    hasClassName: function(element, className) {
        return new RegExp("\\b" + className + "\\b").test(element.className);
    },

    /**
     * Adds a className to the element.
     *
     * @param {Object} element The DOM element.
     * @param {String} className The className to add.
     */

    addClassName: function(element, className) {
        if (!AdElement.hasClassName(element, className)) {
            element.className = (element.className + " " + className).trim();
        }
    },

    /**
     * Removes a className.
     *
     * @param {Object} element The DOM element.
     * @param {String} className The className to remove.
     */

    removeClassName: function(element, className) {
        var regex = new RegExp("\\b" + className + "\\b");
        element.className = element.className.replace(regex, "").replace(/\s+/, " ");
    },

    /**
     *  Insert a text node into an element.
     *
     * @param {Object} element The DOM element.
     * @param {String} txt The text to insert.
     */
    setText: function(element, txt) {
        element.appendChild( document.createTextNode(txt) );
    },

    /**
     * Set styles to a DOM element.
     *
     * @param {Object} element The DOM element.
     * @param {Object} props An object of with properties and values to set.
     */

    setStyle: function(element, props) {
        var prop;
        for (prop in props) {
            if (props.hasOwnProperty(prop)) {
                element.style[prop] = props[prop];
            }
        }
    },

    /**
     * Insert a DOM element into another, before all other elements inside.
     *
     * @param {Object} element The DOM element.
     * @param {Object} el The DOM element to prepend.
     */

    prepend : function (element, el) {
        element.insertBefore(el, element.childNodes[0]);
    },

    /**
     * Append a child element to an element.
     *
     * @param {Object} element The DOM element.
     * @param {Object} el The DOM element to append.
     */

    append : function (element, el) {
        element.appendChild(el);
    },

    /**
     * Move an element before another in the dom.
     *
     * @param {Object} element The DOM element.
     * @param {Object} el The DOM element to move.
     */

    insertBf : function (element, el) {
        element.parentNode.insertBefore(el, element);
    },

    /**
     * Move an element to after another element in the dom.
     *
     * @param {Object} element The DOM element.
     * @param {Object} el The DOM element to move.
     */

    insertAft : function (element, el) {
        element.parentNode.insertBefore(el, element.nextSibling());
    }

};

if (!document.all) {
    // Extend prototype for all but IE
    AdElement.extendEl(HTMLElement.prototype);
}

/**
 * Our main ad library and its functions.
 */

var adtech = function () {

    var scripts = [],
        docWrites = [],
        third_party = [],
        third_party_buffer = [],
        src_buffer = [],
        isJsonAd = false,
        env,
        head,
        pending = {},
        queue = {js: []},
        loadtype = 'injection', // 'injection', 'ajax', 'fif' or if undefined, document.write
        companionAliases = {},
        scriptitr = 0,
        timeout = 3000,
        globalGrp = 0,
        originalDocumentWrite = document.write,
        originalDocumentWriteln = document.writeln,
        useInnerHTML = true,   // Document.create or InnerHTML for dynamic iframes?
        intFIF = '/template/common/mnoAd/fif.html',
        config = {
            version: '9',
            wmode: 'opaque'
        },
        templates = {
            imgWLink: '<a href="${flashvars.clickTAG}" target="${attr.target}" style="border: 0;"><img src="${attr.img}" alt="" width="${attr.imgW}" height="${attr.imgH}" style="border: 0;" /></a>',
            img : '<img src="${attr.img}" alt="" width="${attr.imgW}" height="${attr.imgH}" style="border: 0;" />',
            iframe: '<iframe width="100%" height="100%" frameBorder="0" marginHeight="0" marginWidth="0" id="${id}" name="${id}" src="${src}" seamless></iframe>',
            ie7iframe: '<iframe width="100%" height="100%" frameBorder="0" marginHeight="0" marginWidth="0" id="${id}" name="${id}" src="${src}" scrolling="no"></iframe>'
        };

    /**
     * The function capture() uses to simply rewrite document.write() to something else; i.e. it returns false.
     *
     * @param {String} str The string that would usually document.write() to the page.
     * @returns false
     */

    var domWrite = function (str) {
        return false;
    };

    /**
     * Generic function for setting document.write() to something else.
     */

    function capture() {
        var dom = document;
        if (dom.write===originalDocumentWrite){
            dom.write = domWrite;
        }
        if (dom.writeln===originalDocumentWriteln){
            dom.writeln = domWrite;
        }
    }

    /**
     * Restores document.write() to its original state.
     */

    function restore () {
        document.write = originalDocumentWrite;
        document.writeln = originalDocumentWriteln;
    }

    /**
     * Trim string function.
     * @returns {String} The string withouth whitespace.
     */

    var trim = function() {
        return this.replace(/^\s+|\s+$/g, '');
    };

    /**
     * Creates a new DOM element.
     *
     * @param {String} type The tag name to create.
     * @param {Object} prop Object of attribute names and values.
     * @return {Object} The DOM element.
     */

    function Create (type, prop) {
        var tmp = document.createElement(type), i;
        for (i in prop) {
            if (prop.hasOwnProperty(i)) {
                tmp.setAttribute(i, prop[i]);
            }
        }
        return tmp;
    }

    /**
     * Cross-browser method for retrieving the flash object on the page.
     * We can't always use document.getElementById..
     *
     * @param {String} id The id of the flash object.
     * @returns {Object} The flash object
     */

    function getSwf(id) {
        if (window.document[id]) {
            return window.document[id];
        } else if (document.embeds && document.embeds[id]) {
            return document.embeds[movieName];
        } else {
            return document.getElementById(id);
        }
    }

    /**
     * Function for creating flashvar string, for use with e.g. swfobject.createSWF.
     * createSWF allows us to embed the flash before document.ready, but requires us to manually enter the flashVar string..
     *
     * @param {Object} vars Object of properties and values to make into a valid param string.
     * @returns {String} The flashvar string.
     */

    var makeParamStr = function (vars) {
        var tmp = '', flashvar;
        for (flashvar in vars) {
            if (vars.hasOwnProperty(flashvar)) {
                tmp += flashvar + "=" + escape( vars[flashvar] ) + "&";
            }
        }
        return tmp;
    };

    /**
     * Similar to the jQuery.extend() method. An object that will receive the new properties of an additional object.
     * If property exists, it will kepp the value of the 1st object's property passed in.
     *
     * @param {Object} p Object one
     * @param {Object} c Object two
     * @returns {Object} The combined object.
     */

    var extend = function (p, c) {
        c = c || {};
        var i;
        for (i in p) {
            if (p.hasOwnProperty(i)) {
                if (typeof p[i] ==='object') {
                    c[i] = (p[i].constructor === Array) ? [] : {};
                    extend(p[i], c[i]);
                } else {
                    c[i] = p[i];
                }
            }
        }
        return c;
    };

    /**
     * Our very own templating function.
     * A match will be done on the property names in the object, and the "property names" in the template string.
     *
     * @example
     * console.log(template({"imghref":"blank.gif"},'<img src="${imghref}" />'));
     * @param {Object} o An javascript object.
     * @param {String} str The template string.
     */

    var template = function (o, str) {

        var reg = /(\$\{)(.*?)(\})/g,
            temp = o;

        str = str.replace( reg, function(a, b, c) {
            var obj = {};
            try {
                obj = eval('temp.' + c);
            } catch (err) { return ''; }
            return obj === undefined || null ? '' : obj;
        });

        return str;
    };

    /**
     *  Tests so see whether browser(s) support async mode on dynamically created script elements.
     */

    function getEnv() {

        if (env) { return; }

        var ua = navigator.userAgent;

        env = {
            async: document.createElement('script').async === true
        };

        (env.webkit = /AppleWebKit\//.test(ua))
            || (env.ie = /MSIE/.test(ua))
            || (env.opera = /Opera/.test(ua))
            || (env.gecko = /Gecko\//.test(ua))
        || (env.unknown = true);
    }

    /**
     *  Called when the current pending resource of the specified type has finished loading. Executes the associated callback (if any) and loads the next resource in the queue.
     *
     * @param {String} type resource type ('css' or 'js')
     */

    function finish (type) {
        var p = pending[type],
            callback,
            urls;

        if (p) {
            callback = p.callback;
            urls     = p.urls;

            urls.shift();

            // If this is the last of the pending URLs, execute the callback and start the next request in the queue (if any).
            if (!urls.length) {
                if (callback) {
                    callback.call(p.context, p.obj);
                }

                pending[type] = null;

                if (queue[type].length) {
                    loadScript(type);
                }
            }
        }
    }

    /**
     *  Loads the specified resources, or the next resource of the specified type
     *  in the queue if no resources are specified. If a resource of the specified
     *  type is already being loaded, the new request will be queued until the
     *  first request has been finished.
     *
     *  When an array of resource URLs is specified, those URLs will be loaded in
     *  parallel if it is possible to do so while preserving execution order. All
     *  browsers support parallel loading of CSS, but only Firefox and Opera
     *  support parallel loading of scripts. In other browsers, scripts will be
     *  queued and loaded one at a time to ensure correct execution order.
     *
     *  @method load
     *  @param {String} type resource type ('css' or 'js')
     *  @param {String|Array} urls (optional) URL or array of URLs to load
     *  @param {Function} callback (optional) callback function to execute when the
     *    resource is loaded
     *  @param {Object} obj (optional) object to pass to the callback function
     *  @param {Object} context (optional) if provided, the callback function will
     *    be executed in this object's context
     *  @private
     */

    function loadScript (type, urls, callback, obj, context) {                                                      // For script injection

        var _finish = function () { finish(type); },
            i, len, node, p, pendingUrls, url;

        getEnv();

        if (urls) {

            // If urls is a string, wrap it in an array. Otherwise assume it's an
            // array and create a copy of it so modifications won't be made to the
            // original.

            urls = typeof urls === 'string' ? [urls] : urls.concat();


            // Create a request object for each URL. If multiple URLs are specified,
            // the callback will only be executed after all URLs have been loaded.
            //
            // Sadly, Firefox and Opera are the only browsers capable of loading
            // scripts in parallel while preserving execution order. In all other
            // browsers, scripts must be loaded sequentially.
            //
            // All browsers respect CSS specificity based on the order of the link
            // elements in the DOM, regardless of the order in which the stylesheets
            // are actually downloaded.
            if (env.async || env.gecko || env.opera) {
                // Load in parallel. These browsers preserve execution order
                queue[type].push({
                    urls    : urls,
                    callback: callback,
                    obj     : obj,
                    context : context
                });
            } else {
                // Load sequentially for others
                for (i = 0, len = urls.length; i < len; ++i) {
                    queue[type].push({
                        urls    : [urls[i]],
                        callback: i === len - 1 ? callback : null,                                                           // callback is only added to the last URL. IE
                        obj     : obj,
                        context : context
                    });
                }
            }
        }

        // If a previous load request of this type is currently in progress, we'll
        // wait our turn. Otherwise, grab the next item in the queue.
        if (pending[type] || !(p = pending[type] = queue[type].shift())) {
            return;
        }

        head || (head = document.head || document.getElementsByTagName('head')[0]);
        pendingUrls = p.urls;
        var id = 'adscript' + (++scriptitr);

        for (i = 0, len = pendingUrls.length; i < len; ++i) {

            url = pendingUrls[i];
            node = Create( 'script',                                                                                  // { method: 'append', pos: 'document.getElementsByTagName('head')[0]' }
                { type: 'text/javascript',
                    charset: 'utf-8',
                    id: id,
                    src: url
                });

            node.async = false;

            if (env.ie) {
                node.onreadystatechange = function () {
                    var readyState = this.readyState;

                    if (readyState === 'loaded' || readyState === 'complete') {
                        this.onreadystatechange = null;
                        _finish();
                    }
                };
            } else {
                node.onload = node.onerror = _finish;
            }

            head.appendChild(node);

        }

        function checkAd (id, head, node){                                                                           // Timeout function
            return (function() {
                if (!document.getElementById(id)) {
                    finish('js');
                } else {
                    head.removeChild(node);
                }
            });
        }

        var ad = checkAd (id, head, node);
        setTimeout(ad, timeout);
    }

    /**
     * Load ad assets: append images or embed using swfobject.
     * Used only when a banner is booked using our own banner template.
     *
     * @param {Object} options The ad object, with all its properties (swf, images, clicktags etc).
     * @param {String} [frame] If loadAssets is loaded from an iframe, this will be the id of the iframe.
     */

    function loadAssets (options, frame) {

        // If "frame" is a string, we'll make our element an object with a reference to to the string - so our get() function knows we're actually looking for a div inside the iframe
        var el = frame ? { frame: frame, container:  options.container }  :  options.container;

        extend(config, options.config);

        var hasFlash = false,
            that = this, // Store reference to "this". Remember, we could be accessing loadAssets through an iframe.. So we need to know our context
            container = AdElement.get(el),
            contHeight = options.config && options.config.height ? options.config.height : options.attr.imgH,   // Store the height of our assets. If options.config - we're dealing with a flash. If not, its an image, so we'll find it in options.attr
            contWidth = options.config && options.config.width ? options.config.width : options.attr.imgW;      // Same for width

        if (options.config) {
            hasFlash = that.swfobject.hasFlashPlayerVersion( options.config.version );  // Boolean for knowing whether we have flash installed. Think IPAD
        }

        // Function for embedding flash assets
        var flash = function () {

            // that.swgobject - remember we could be accessing this function from an iframe - so "that" could be a local copy of swfobject present inside the iframe.
            that.swfobject.createSWF(
                { data: options.config.src, width: options.config.width, height: options.config.height },
                { wmode: options.config.wmode, allowscriptaccess: 'always', flashvars : makeParamStr(options.flashvars) },
                options.container
            );

        };

        // Or for embedding image assets
        var image = function () {

            // Here we use our funky and dead simple template() function..
            if (options.flashvars.clickTAG) {
                container.innerHTML = template(options, templates.imgWLink );
            } else {
                container.innerHTML = template(options, templates.img );
            }
        };

        if (hasFlash && options.config.src) {
            // Both need to be true! We need flash installed, and we need flash assets!
            flash();
        } else if (options.attr.img) {
            // And here we of course need image assets
            image();
        } else {
            // Do Nothing
        }

        // Is there a pixel counter in this ad?
        if (options.attr.pxC) {
            var counter = Create (
                'image', {
                    width: 1, height: 1, src: options.attr.pxC
                });
            // Yep, append the image tag
            AdElement.get(el).parentNode.appendChild(counter);
        }

        if (frame) {
            // Yes, we're in an iframe.
            // And we're using our banner template.
            // So we need to override any sizes set by setIframeHeight(), as our actual embedded flash or image files may be BIGGER or SMALLER than its defaults.
            var fif = AdElement.get(frame);
            // Set size of the iframe itself
            fif.setAttribute('height', contHeight);
            fif.setAttribute('width', contWidth);
            // And its parent
            fif.parentNode.setStyle( {height: contHeight + 'px', width: contWidth + 'px'} );
        } else {
            // This is not in an iframe . Thus we only modify its parent container, as the ad container itself has become the id of the FLASH
            var swfCont = getSwf(options.container).parentNode;
            swfCont.style.height = contHeight + 'px';
            swfCont.style.width = contWidth + 'px';
        }

        // Yes, indicate this banner is booked using our banner template
        isJsonAd = true;

    }

    /**
     * Sets the height and width of the iframe's parent container, id the ad is loaded in our iframe.
     * As  iframes have 100% height and 100% width, we need to set an explicit size to the parent container for it to function correctly in all browsers.
     * In other words, if we HAVE loaded an iframe, we will enter this function, and set its size from the classes set in the ad widget itself.
     *
     * @param {String} pos The id of ad position. We will from here find its parent.
     */

    function setIframeHeight (pos) {

        var reg =/ad(W|H)\d+(px)?/g,
            w = "0px", h = "0px",
            cont = AdElement.get(pos),
            el = cont.parentNode;

        // Find the size according to its classname. This is set in the ad widget's config, in content studio. E.g. the size "25px" in the widget becomes class "adH25" on the page, which we here will chop to retrieve "25" from.
        // Just "25" would not be a valid classname, so we have to set the size with a prefix ("adH") - then strip it now to just get the actual number we're looking for.
        el.className.replace( reg, function (a) {
            if (a.indexOf("adW") != -1) { w = a.substr(3); }
            if (a.indexOf("adH") != -1) { h = a.substr(3); }
        });

        h += h.indexOf("px") == -1 && h.indexOf("%") == -1 ? "px": "";
        w += w.indexOf("px") == -1 && h.indexOf("%") == -1 ? "px" : "";

        // Set the size of the ad container
        cont.style.height = h;
        cont.style.width = w;

        isJsonAd = false;

        // If we have loaded all the ads as "async" ads, we have captured document.write.
        // As the iframe is now created and shown, we'll restore() document.write again.
        restore();

    }

    /**
     * Main loading function. Loads either ads in iframes (loadtype=fif),
     * injection (loadtype=injection), or regular document.write script-tag.
     *
     * @param {String} pos ID of the ad div, corresponds to Type in helios
     * @param {String} alias Alias of the ad position, used to build script src
     * @param {String} src If other than "null", attempts to load in the script (src)
     * @param {Number} group Randomly created group id, generated on each page refresh
     */

    function loadAd (pos, alias, src, group) {

        // Get ad reference <div>
        var el = AdElement.get(pos);

        // Generate Group ID if needed
        if (group && globalGrp == 0) { globalGrp = group; }
        // If group is missing from one of the placements, attach it from one of the others..
        group = group || globalGrp;

        // Check whether the div we're putting the ad in actually exists.
        if ( el !== null) {
            if (src === null || loadtype === 'fif') {
                // Create the actual iframe
                createIframe( pos, { a: alias, g: group }, 'fif' + pos);
                setIframeHeight(pos);
            } else {
                if (loadtype === 'injection') {
                    // Load scripts w/script injection. Capture() blocks document.write() to prevent ads from loading in incorrect ORDER in IE
                    capture();
                    // call loadScript() with src of scripttag, with callback function when finished loading
                    loadScript('js', src, function () {
                        if (scripts.length === 0) {
                            // Scripts array is empty, hence  there is no ad object to retrieve or pop(). This must be either a third party ad, or one containing document.writes. Handle these
                            if (third_party_buffer.length !== 0) {
                                // Third party ad, through our own banner template. Get its position (ID)
                                third_party[0] = pos;
                            } else {
                                // Document.write ad, not booked through our banner template. Get its position (ID).
                                docWrites[0] = pos;
                            }
                        }
                        // Initialize ad, handle doc.writes and such.
                        initAd(pos, alias, group);
                    });
                } else if (loadtype === 'ajax') {
                    // Not implemented yet
                } else {
                    // Old school. Document.write the script tag directly.
                    document.write('<scr'+'ipt type="text/javascript" src="'+ src +'"></scri'+'pt>');
                }
            }
        } else {
            // Container div doesn't exist
            log('Error, container div#'+ pos + ' does not exist for page '+ document.location.href +'.');
        }

    }

    /**
     *  Tells us to load a Friendly IFrame (FIF) directly.
     *
     *  @deprecated Should eventually use loadAd() only
     *  @param {String} pos ID of the ad div, corresponds to Type in helios
     *  @param {String} alias Alias of the ad position, used to build script src
     *  @param {Number} group Randomly created group id, generated on each page refresh
     *
     */

    function loadFIF (pos, alias, group) {
        // Call loadAd() with src set to null, as we do not want to load the script src directly
        loadAd(pos, alias, null, group);

    }

    /**
     * The function called by all ad specials booked using our banner template.
     * Pushes a javascript object into an array just before the script's callback function is called.
     * The object ands its properties are generated through the banner template "MNO Standard, Sticky, L, Ticker and Wallpaper".
     *
     * @param {Object} data the javascript ad object booked in the adtech system. Contains references to the flash file, its size, type ('standard'/'interstitial' etc) etc.
     *                      data.t : the type of ad. Could be 'standard', or any of the types defined in plugins.js
     *                      data.o : the ad object
     *                      data.o.config : contains the swf and its size, if it exists
     *                      data.o.attr : contains the image and its size, if it exists, as well as other properties such as timeout/pixelcounter/target and others
     */

    function pushAd (data) {

        if (typeof plugins[data.t] === 'undefined') { return; }

        // Check whether this is an ad object with properties, or else this is thirdy party code, booked with our banner template. (if so, we put the code in an IFRAME).
        if (typeof data.o !== 'undefined') {
            // If this ad is set to Type "Javascript", a script tag is written directly to the page. Thus, it is not async, so we check whether the script tag doesn't contain the letters "load" in its ID attribute.
            // This is to make sure we can still use this ad library even if the scripts are written directly to the page, and not loaded via loadAd or loadFIF
            var isDocWritten = document.getElementsByTagName('script')[document.getElementsByTagName('script').length-1].id.indexOf('load') === -1;
            // Get the last div that is written to the page, just before the script is loaded and pushAd called, before moving on in the DOM
            var containerId = document.getElementsByTagName('div')[document.getElementsByTagName('div').length-1].id;
            if (isDocWritten && containerId !== "") {
                // This is a script-tag written directly to the page
                data.o.container = containerId;
                plugins[data.t](data.o);
            } else {
                // This is async
                scripts.push(data);
            }
        } else {
            // Third party, push to its own buffer for later use. This code we will put in an IFRAME
            third_party_buffer.push(data);
        }
    }

    /**
     * Creates an iframe, using Create, or older - using innerHTML.
     *
     * @param {String} pos ID of the ad div, corresponds to Type in helios
     * @param {String} src Object with properties a - alias (optional) and g - group id (optional). Placement will be retrieved from the iframe's parent container
     *
     *                     intFIF = variable containing path to iframe html file.
     *                     p = ID of the ad div, corresponds to Type in helios
     *                     a = Alias of the ad position, used to build script src
     *                     g = Randomly created group id, generated on each page refresh
     *
     * @param {String} id The id of the iframe. Usually the ID of the ad div, prepended with the string 'fif'
     */

    function createIframe (pos, src, id) {

        var frame,
            el = AdElement.get(pos),
            id = id || '',
            tmpl_obj = { id: id, src: intFIF },
            isIE7 = navigator.appVersion.indexOf("MSIE 7.") !== -1;

        // Push "src" object to array to be retrieved later by the iframe. This object
        src_buffer[pos] = src;

        if (!isIE7) {
            if (useInnerHTML) {
                document.getElementById(pos).innerHTML = template(tmpl_obj, templates.iframe);
            } else {
                frame = Create( 'iframe',
                    { width: '100%',
                        height: '100%',
                        frameBorder: 0,
                        marginHeight: 0,
                        marginWidth: 0,
                        name: id,
                        id: id,
                        seamless: 'seamless',
                        src: intFIF }
                );
                el.append(frame);
            }
        } else {
            document.getElementById(pos).innerHTML = template(tmpl_obj, templates.ie7iframe);
        }
    }

    /**
     *  Initializes the ad position. Checks whether the docWrites array is empty (is then put in iframe),
     *  if scripts is empty (is a js-object, and its function can be invoked), or it is a third party ad using our own banner template.
     *
     * @param pos {String} The name of the reference div in which we will put the ad
     * @param alias {String} The Helios alias parameter, used to actually fetch the correct position. Looks like e.g. "FVN_Fors_Skyskraper3_180x500"
     * @param group {String} Should be a number, really.. The group ID - a unique random number generated by the polaris-adtech tag on each page load.
     *                       This param in the script src makes sure ads from the same campaign know of each other, and can be shown together.
     */

    function initAd  (pos, alias, group) {

        // Return if we've embedded an iframe, and the iframe doesn't exist. This means we are loading async using loadAd(), but appending in an iframe - thus depending on the iframe to call initAd(). This prevents initAd from being called twice
        if (loadtype === 'injection' && AdElement.get('fif' + pos) !== null) { return; }

        var ad,
            options = { container : pos },
            docWriteAd = false;

        if (group && globalGrp == 0) { globalGrp = group; }
        group = group || globalGrp;

        if (docWrites.length !== 0) {
            // Not jsonad, and not in friendly iframe. Doc write.
            // Put in iframe
            isJsonAd = false;
            createIframe(docWrites.shift(), { a: alias, g: group }, 'fif' + pos);
            docWriteAd = true;
            setIframeHeight(pos);
        } else if (scripts.length !== 0) {
            // Using our banner template. Array scripts contains the ad object and its assets
            ad =  scripts.shift();
            isJsonAd = true;
        }  else {
            // Third party ad, though using our banner template.
            // In this case we do not need the a (alias) parameter in the iframe, as we are not calling the ad position twice.
            isJsonAd = false;
            createIframe(third_party.shift(), { g: group }, 'fif' + pos);
            setIframeHeight(pos);
        }

        //  If document.write ad, or ad is empty, we need to reset document.write to its original state.
        if (!ad || docWriteAd) { restore(); return; }

        // Extend the current ad object with our default values
        extend(options, ad.o);

        // Run the actual ad!
        // In most caes, this means invoking plugins['standard']. All other ad specials are contained in the plugins.js file and extend this plugins object.
        if (ad.o) {
            plugins[ad.t](ad.o);
            delete scripts[pos];
            log('Successfully loaded script for "' + pos +'" . Calling callback function');
        } else {
            log('Ad template error, could not load ad '+ pos);
        }

    }

    /**
     * For logging.
     *
     * @param msg {String} Log message
     */

    function log (msg) {

        /* try {
         console.log(msg);
         }  catch (err) {} */

    }

    /**
     * The plugins object. By default only contains a method for showing "standard" flash or image ads with no magic, using swfobject or Create.
     *
     * @returns {Function} The function as defined by the t in the ad = { t : 'standard', o: {} } object.
     */

    var plugins = {

        // Plugins 'standard' object

        standard : function (options, context, frame) {
            // Context is either the _top window, or could also be the iframe's window object from which the ad position is being called
            // This is so we get the correct reference to "this" when we call() the loadAssets() function
            context = context || window;
            loadAssets.call(context, options, frame);
        }

    };

    /**
     * Public method. Used by the iframe html-file itself to access the plugins object and its members directly.
     *
     * @public
     * @param {String} plugin Same as t:{} in the ad object
     * @param {Object} options  Same as o:{} in the ad object
     * @param {Object} context Window by default. Can pass along the iframes' window object so it knows to use its own instance of swfobject, also contained within the iframe.
     *                         We have to do this if we want the iframe to embed flash, as Swfobject doesn't currently support embedding into child iframes,
     *                         even if they are on the same domain.
     * @param {String} frame The ID of the iframe that is calling, wo we know where to embed.
     */

    function _getPlugin (plugin, options, context, frame) {
        return plugins[plugin](options, context, frame);
    }

    /**
     * Method for testing ads. Used by the helios backend.
     *
     * @public
     * @param container
     * @param type
     */

    /**
     * Public function for testing ads in the Helios/Adtech system.
     * Accessed by iframes from within the system when previewing ads using our banner template.
     *
     * @param {String} container The ID of the div to embed the ad to test.
     * @param {String} type The type, as booked in Helios.
     */

    function _testAd (container, type) {
        extend({container: container}, type.o);
        return plugins[type.t](type.o);
    }

    /**
     * Function used by plugins.js, to extend our "plugins" object above, with more ad specials.
     *
     * @param {String} name The name of the ad special, e.g. "interstitial".
     * @param {Function} func The callback function, i.e. the code that will be called when that special is booked.
     */

    function _setPlugin (name, func) {
        return plugins[name] = func;
    }

    /**
     * Used in the ad widgets, on a config level.. This can be used if one wants to expose the ALIAS of a specific ad TYPE, and load this dynamically later on.
     * E.g. to load an ad one needs an ALIAS as a bare minimum. BUT to retrieve the ALIAS "FVN_FORS_ToppbannerXL_980x500", we'll simply ask in the config for e.g. TYPE "ToppbannerXL".
     * The ad position will then be put in an array here, so we can retrieve its ALIAS and SRC values later on. Used e.g. in plugins.js.
     * Then we cal load the ad dynamically using getCompanion("ToppbannerXL").
     *
     * @param {String} type The ad TYPE as found in Helios. The value entered in the ad config.
     * @param {String} alias The ALIAS, returned by Helios.
     * @param {String} src The SRC, also retrieved automagically from our ad taglib.
     */

    function _setCompanion (type, alias, src) {
        return companionAliases[type] = { alias : alias, src: src };
    }

    /**
     * Used to get the SRC and ALIAS values for an ad, so we can load it dynamically later on - e.g. for an ad special that needs two extra ads!
     *
     * @param {String} type The ad TYPE as found in Helios.
     */

    function _getCompanion (type) {
        return companionAliases[type];
    }

    /**
     *  Used in FIF.html to retrieve the contents of the third_party_buffer array; the latest ad booked in our banner template, but using third party tags..
     *  This will simply be document.written into the iframe.
     */

    function _getThirdPartyBuffer() {
        return third_party_buffer;
    }

    /**
     * Used by FIF.html to get the required ALIAS and GroupID required for the ad position.
     *
     * @param {String} pos The ID of the ad - i.e. the ID of the reference div for the ad. E.g. "toppbanner", "midtbanner", "skyskraper1".
     *                     Basically the ad TYPE in lowercase.
     */

    function _getSrcBuffer(pos) {
        var adObj = src_buffer[pos];
        delete src_buffer[pos];
        return adObj;
    }

    /**
     * Expose the methods above.
     */

    return {
        getPlugin: _getPlugin,
        setPlugin: _setPlugin,
        setCompanion: _setCompanion,
        getCompanion: _getCompanion,
        getThirdPartyBuffer: _getThirdPartyBuffer,
        getSrcBuffer: _getSrcBuffer,
        testAd: _testAd,
        loadAd: loadAd,
        loadFIF: loadFIF,
        loadAssets: loadAssets,
        capture: capture,
        restore: restore,
        initAd: initAd,
        pushAd: pushAd,
        Create: Create,
        log: log
    };

}();
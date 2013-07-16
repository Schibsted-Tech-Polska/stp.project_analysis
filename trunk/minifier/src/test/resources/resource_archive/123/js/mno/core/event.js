mno.namespace('event');

/** @namespace */
mno.event = function () {
    var events = {};

    var _functionName = function (fn) {
        if (fn.name !== undefined) {
            _functionName = function(fn) {
                return fn.name || false;
            }
        } else {
            _functionName = function(fn) {
                var name = /\W*function\s+([\w\$]+)\(/.exec(fn);
                if (name !== null) {
                    name = name[1];
                }
                return name || false;
            }
        }

        return _functionName(fn);
    };

    /**
     * @public
     * @description Register an event listener
     *
     * @param {Object} evts An event object where the event name is the key and the function is the value.
     * @param {String} mod A unique widget id.
     * @memberOf mno.event
     */
    function registerEvents (evts, mod) {
        if ($.isPlainObject(evts) && mod) {
            for (var key in evts) {
                if (evts.hasOwnProperty(key)) {
                    events[key] = events[key] || {};
                    events[key][mod] = events[key][mod] || [];
                    var fn = _functionName(evts[key]);
                    if (fn === false) {
                        events[key][mod].push(evts[key]);
                    } else if (typeof fn === 'string') {
                        events[key][mod][fn] = evts[key];
                    }
                }
            }
        } else {
            mno.core.log(1, evts + 'not an object: ' + mod);
        }
    }

    /**
     * @public
     * @description Throws an event
     *
     * @param {Object} evt An event object
     * @param evt.type The type of event
     * @param evt.data Data supplied eith the event
     */
    function triggerEvent (evt) {
        var thrown = false;
        if (events[evt.type] !== undefined) {
            var e  = events[evt.type];
            for (var id in e) {
                if (e.hasOwnProperty(id)) {
                    var mod = e[id];
                    for (var fn in mod) {
                        if (mod.hasOwnProperty(fn)) {
                            mod[fn](evt.data);
                            thrown = true;
                        }
                    }
                }
            }
        }
        if (thrown === true) {
            mno.core.log(1,'Throw event: ' + evt.type);
        }
    }

    /**
     * @public
     * @description Removes an event
     *
     * @param {String|String[]} evts The type of event
     * @param {String} mod A unique widget id.
     * @param {String|Boolean} fn Function name. Default false.
     * @memberOf mno.event
     */
    function removeEvents (evts, mod, fn) {
        fn = fn || false;
        evts = $.isArray(evts) ? evts : [evts];
        var i = evts.length;
        if (events[evts] !== undefined && events[evts][mod] !== undefined) {
            if (fn === false) {
                delete events[evts][mod];
            } else {
                if (events[evts][mod].hasOwnProperty(fn)) {
                    delete events[evts][mod][fn];
                }
            }
        } else {
            mno.core.log(1, evts + 'does not exist on ' +mod);
        }
    }

    return {
        events: events,
        registerEvents:registerEvents,
        triggerEvent:triggerEvent,
        removeEvents:removeEvents
    }
}();
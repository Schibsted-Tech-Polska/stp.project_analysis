/*
 * Namepsace: mno
 * Root of MNO Scalable Javascript Application
 *
 * Based on Nikolas Zakas screencast on Scalable JavaScript Application architecture: http://developer.yahoo.com/yui/theater/video.php?v=zakas-architecture
 *
 * Author:
 * Tor Brekke Skjøtskift
 *
 * Copyright:
 * Aftenposten AS (c) 2010, All Rights Reserved
 *
 * License:
 *
 */

/** @namespace */
var mno = mno || (function () {
    /**
     * @description Creates a namespace within the mno namepace
     * @param {String} ns The path to the namespace. mno is optional.
     * @example mno.namespace('core.profiling');
     * @memberOf mno
     */
    function namespace(ns) {
        var parts = ns.split('.'),
            parent = mno,
            i;
    
        /* Remove "mno" if present */
        if (parts[0] === 'mno') {
            parts = parts.slice(1);
        }

        for (i = 0; i < parts.length; i++)  {
            /*Create property if it doesn't exists*/
            if (typeof parent[parts[i]] === 'undefined') {
                parent[parts[i]] = {};
            }
            parent = parent[parts[i]];
        }

        return parent;
    }

    return {
        /**
         * @namespace
         * @name mno.states
         */
        states:{
            /**
             * @description Flags when dom is ready
             * @type Boolean
             */
            domReady:false,
            /**
             * @description Flags when all assets are ready
             * @type Boolean
             */
            windowLoad:false
        },
        namespace:namespace
    };
}());

$(document).ready(function () {
    mno.states.domReady = true;
});

$(window).bind('load', function () {
    mno.states.windowLoad = true;
});

/**
 * @ignore
 */
Array.prototype.rotate = (function() {
    var unshift = Array.prototype.unshift,
        splice = Array.prototype.splice;

    return function(count) {
        var len = this.length >>> 0;

        count = count >> 0;

        unshift.apply(this, splice.call(this, count % len, len));
        return this;
    };
}());

/**
 * @ignore
 */
if (!Array.prototype.indexOf) {
  Array.prototype.indexOf = function (obj, fromIndex) {
    if (fromIndex == null) {
        fromIndex = 0;
    } else if (fromIndex < 0) {
        fromIndex = Math.max(0, this.length + fromIndex);
    }
    for (var i = fromIndex, j = this.length; i < j; i++) {
        if (this[i] === obj)
            return i;
    }
    return -1;
  };
}

/**
 * @ignore
 */
if (typeof JSON !== 'object') {
    var  JSON = {};
    JSON.stringify = function (obj) {
        var t = typeof obj;
        if (t !== 'object' || t === null) {
            if (t === 'string') {
                obj = '"' + obj +'"';
            }
            return String(obj);
        } else {
            var n,
                v,
                json = [],
                arr = (obj.constructor === Array);

            for (n in obj) {
                v = obj[n];
                t = typeof v;
                if (t==='string') {
                    v = '"' + v + '"';
                } else if (t === 'object' && v !== null) {
                    v = JSON.stringify(v);
                }
                json.push((arr === true ? '' : '"' + n + '":') + String(v));
            }
            return (arr === true ? '[' : '{') + String(json) + (arr === true ? ']' : '}');
        }
    };
    JSON.parse = function (str) {
        if (str === '') {
            str = '""';
        }
        eval('var p = '+ str + ';');
        return p;
    };
}

/**
 * @ignore
 */
if (!Object.create) {
    Object.create = function (o) {
        if (arguments.length > 1) {
            throw new Error('Object.create implementation only accepts the first parameter.');
        }
        function F() {}
        F.prototype = o;
        return new F();
    };
}

/**
 * @ignore
 */
if (typeof console === 'undefined') {
    console = {}; // define it if it doesn't exist already
}
if (typeof console.log === 'undefined') {
    console.log = function() {};
}
if (typeof console.dir === 'undefined') {
    console.dir = function() {};
}


/* put "global" callbacks in this object  */
$.extend(mno,{callbacks: {}});
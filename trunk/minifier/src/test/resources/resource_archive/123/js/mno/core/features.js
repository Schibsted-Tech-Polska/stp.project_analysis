mno.namespace('features');

/** @namespace */
mno.features = (function () {
    var fixed = {
        value:_getFixedValue(),
        callbacks:[]
    },
    features = {
        /**
         * @description Is the css transform property supported
         * @type String|Boolean The correct prefixed property name or false if not supported.
         * @fieldOf mno.features
         */
        transform :(function() {
            var docEl = document.documentElement, s;
            if (docEl && (s = docEl.style)) {
                if (typeof s.transform === 'string') {
                    return 'transform';
                } else if (typeof s.MozTransform === 'string') {
                    return 'MozTransform';
                } else if (typeof s.WebkitTransform === 'string') {
                    return 'WebkitTransform';
                } else if (typeof s.OTransform === 'string') {
                    return 'OTransform';
                } else if (typeof s.MsTransform === 'string') {
                    return 'MsTransform';
                } else if (typeof s.KhtmlTransform === 'string') {
                    return 'KhtmlTransform';
                }
            }

            return false;
        }()),

        /**
         * @description Is the css transition property supported
         * @type String|Boolean The correct prefixed property name or false if not supported.
         * @memberOf mno.features
         */
        transition : (function() {
            var docEl = document.documentElement, s;
            if (docEl && (s = docEl.style)) {
                if (typeof s.transition === 'string') {
                    return 'transition';
                } else if (typeof s.MozTransition === 'string') {
                    return 'MozTransition';
                } else if (typeof s.WebkitTransition === 'string') {
                    return 'WebkitTransition';
                } else if (typeof s.OTransition === 'string') {
                    return 'OTransition';
                } else if (typeof s.MsTransition === 'string') {
                    return 'MsTransition';
                } else if (typeof s.KhtmlTransition === 'string') {
                    return 'KhtmlTransition';
                }
                return false;
            }
            return false;
        }()),

        /**
         * @description Is the css transition property supported
         * @type String|Boolean The correct prefixed property name or false if not supported.
         * @fieldOf mno.features
         */
        transitionProperty : (function() {
            var docEl = document.documentElement, s;
            if (docEl && (s = docEl.style)) {
                if (typeof s.transition === 'string') {
                    return 'transition';
                } else if (typeof s.MozTransition === 'string') {
                    return 'MozTransition';
                } else if (typeof s.WebkitTransition === 'string') {
                    return 'WebkitTransition';
                } else if (typeof s.OTransition === 'string') {
                    return 'OTransition';
                } else if (typeof s.MsTransition === 'string') {
                    return 'MsTransition';
                } else if (typeof s.KhtmlTransition === 'string') {
                    return 'KhtmlTransition';
                }
            }
            return false;
        }()),
        
        
        /**
         * @description Does the user agent supports touch
         * @type Boolean
         * @memberOf mno.features
         */
        touch : (function () {
            try {
                document.createEvent("TouchEvent");
                return true;
            } catch (e) {
                return false;
            }
        }()),
        /**
         * @description The platform of the user agent
         * @type String
         * @memberOf mno.features
         */
        platform : (function (){
            return navigator.platform;
        }()),
        /**
         * @description Checks if the user agent support position fixed
         * @param {Function} callback the callback function when test is completed
         * @memberOf mno.features
         */
        positionFixed: function (callback) {
            if (typeof fixed.value === 'undefined') {
                fixed.callbacks.push(callback);
                if (mno.states.domReady === true) {
                    _fixedTest();
                } else {
                    $(document).ready(_fixedTest);
                }
            } else {
                callback(fixed.value);
            }
        }
    };


    function _runFixedCallbacks() {
        for (var i = 0; i < fixed.callbacks.length;i++) {
            fixed.callbacks[i](fixed.value);
        }
    }
    function _getFixedValue() {
        var ret;
//        if (typeof localStorage !== 'undefined') {
//            var fixd = localStorage.getItem('mno_PFix');
//            if (fixd) {
//                ret = (fixd === 'true' || fixd === true);
//            }
//        }
        return ret;
    }

    function _setFixedValue(value) {
        if (typeof localStorage !== 'undefined') {
            localStorage.setItem('mno_PFix', value);
        }
        fixed.value = value;
        _runFixedCallbacks();
    }

    function _fixedTest() {
//        var test  = document.createElement('div'),
//            control = test.cloneNode(false),
//            root = document.body,
//            oldCssText = root.style.cssText,
        var iPhoneIOS5Pattern = /iPhone OS 5/i,
            iPadIOS5Pattern = /CPU OS 5/i,
            iDevice = navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPod/i) || navigator.userAgent.match(/iPad/i);

        if (iDevice && (navigator.userAgent.match(iPhoneIOS5Pattern) || navigator.userAgent.match(iPadIOS5Pattern))) {
            _setFixedValue(true);
        } else if (iDevice) {
            _setFixedValue(false);
//        if (typeof root.scrollIntoViewIfNeeded === 'function') {
//
//            var testScrollTop =  window.pageYOffset + 42,
//                originalScrollTop = window.pageYOffset;
//
//            root.appendChild(test);
//
//            test.style.cssText = 'position:fixed;top:0px;height:10px;width:100%;';
//
//            root.style.height="3000px";
//
//            // avoided hoisting for clarity
//            var testScroll = function() {
//                window.removeEventListener('scroll', testScroll, false);
//                if (fixed.value === undefined) {
//                    test.scrollIntoViewIfNeeded();
//                    _setFixedValue(window.pageYOffset === testScrollTop);
//                }
//
//                root.removeChild(test);
//                root.style.cssText = oldCssText;
//                window.scrollTo(0, originalScrollTop);
//                _runFixedCallbacks();
//            };
//
//            window.addEventListener('scroll', testScrollTop, false);
//            window.scrollTo(0, testScrollTop);
//            window.setTimeout(testScroll, 15); // ios 4 doesn't publish the scroll event on scrollto

        } else if (features.touch === true) {
//            root.style.cssText = 'padding:0;margin:0';
//            test.style.cssText = 'position:fixed;top:42px';
//
//            root.appendChild(test);
//            root.appendChild(control);
//
//            var ret = test.offsetTop !== control.offsetTop;
//            root.removeChild(control);
//            root.removeChild(test);
//            root.style.cssText = oldCssText;
            _setFixedValue(false);
        } else {
            _setFixedValue(true);
        }
    }

    return features;
}());
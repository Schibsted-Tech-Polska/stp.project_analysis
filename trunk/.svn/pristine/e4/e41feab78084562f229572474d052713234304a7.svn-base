mno.core.register({
    id:'widget.realEstateInfo.common', // common
    creator:function (sandbox) {

        var commonData = {
            publication:sandbox.publication.name
        };
        // collect ALL VIEWS configs
        for (widgetId in mno.model.widget) {
            var data = mno.model.widget[widgetId];
            if (data.type.match(/^widget\.realEstateInfo/)) {
                delete data.type;
                jQuery.extend(true, commonData, data);
            }
        }

        var loadingStarted = false,
            loadingFinished = false,
            data = null,
            callbackQueue = [],
            itemUrl = (commonData.serviceUrl || 'http://oca.medianorge.no/oca/s/v1/get/ad/') + commonData.objectId + '.jsonp',
            isMobile = (mno.features.platform === "iPhone");

        function init() {

        }

        function destroy() {
        }


        function pushField(list, object, key, label, formatStr, args) {
            // safety check: the object and the property have to exist
            var data = null;
            if (typeof(object) !== "undefined") {
                if (object.hasOwnProperty(key)) {
                    data = object[key];
                }
            }
            if (data === null) return;

            // support extra format args (make data {0} and args {1}, {2}...)
            if (typeof(args) === "undefined") {
                args = [];
            }
            args.unshift(data);

            // do a "Something {0} sth"-style replacement
            // we support a special nasty syntax to make "{0},-" properer norwegian number formatting
            var dataStr = '';
            if (formatStr == '{0},-') {
                dataStr = formatPrice(args[0]);
            } else {
                dataStr = formatStr.format(args);
            }
            list.push({ label:label, value:dataStr });
        }

        function getData(callback) {
            // if data is loaded, fire immediately
            if (loadingFinished === true) {
                callback(data);
            }

            // add to listener (callback) list for when the data is ready
            callbackQueue.push(callback);

            // load stuff and notify the waiting guys
            if (loadingStarted === false) {
                loadingStarted = true;

                if (typeof(_gaq) !== "undefined") {
                    try {
                        _gaq.push([ 'rECl._trackEvent', commonData.id, 'visit']);
                    }
                    catch(e) {
                        mno.core.log(3, e);
                    }
                }


                sandbox.getScript({
                    callbackVar:'callback',
                    url:itemUrl,
                    jsonP:function (jsonData) {
                        jsonData = jsonData.ad; // TODO make me prettier
                        var objectProperties = {};
                        if (jsonData.propertyLinks) {
                            $.each(jsonData.propertyLinks, function (key, val) {
                                if (val.property) {
                                    objectProperties[val.property.name] = val.aNode || val.value;
                                }

                            });
                        }
                        jsonData.properties = objectProperties;
                        jsonData.isMobile = isMobile;
                        data = jsonData;
                        loadingFinished = true;
                        fireCallbacks();
                    }
                });
            }
        }

        function fireCallbacks() {
            while (callbackQueue.length > 0) {
                var cb = callbackQueue.pop();
                try {
                    cb(data);
                }
                catch (e) {
                    mno.core.log(3, "Error in callback");
                    if (e.hasOwnProperty('stack')) {
                        // chrome
                        mno.core.log(2, e.stack);
                    } else {
                        mno.core.log(2, e);
                    }
                }
            }
        }

        function formatPrice(price) {
            price += '';
            parts = price.split('.');
            x1 = parts[0];
            x2 = parts.length > 1 ? ',' + parts[1] : ',&ndash;';
            var rgx = /(\d+)(\d{3})/;
            while (rgx.test(x1)) {
                x1 = x1.replace(rgx, '$1' + '&nbsp;' + '$2');
            }
            return x1 + x2;
        }

        return {
            init:init,
            destroy:destroy,

            formatPrice:formatPrice,
            pushField:pushField,
            getData:getData
        }
    }
});
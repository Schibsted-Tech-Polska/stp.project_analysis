mno.core.register({
    id:'widget.eventPlaceSearch.main',
    creator: function (sandbox) {
        function encodeHash(data) {
            var hash = '';

            for (var key in data) {
                if (data.hasOwnProperty(key)) {
                    hash += key + '=' + data[key] + '|';
                }
            }
            return encodeURI(hash);
        }

        function decodeHash() {
            var hash = window.location.hash.substring(2),
                hashArray = decodeURI(hash).split('|'),
                i,
                keyValue,
                ret = {
                    text: '',
                    resultsPerPage: 10,
                    featureIds: [],
                    resultsIndex: 0
                };

            for (i = 0; hashArray[i];i++) {
                keyValue = hashArray[i].split('=');
                if (typeof ret[keyValue[0]] === 'Array') {
                    ret[keyValue[0]].push(keyValue[1]);
                } else {
                    ret[keyValue[0]] = keyValue[1]
                }
            }

            return ret;
        }

        function constructSearchUrl(data, url) {
            var i;

            url = url + '?';

            for (i = 0; data.featureIds[i]; i++) {
                url += 'featureValueId=' + data.featureIds[i] + '&';
            }

            url += 'text=' + data.text + '&';
            url += 'firstIndex=' + data.resultsIndex * data.resultsPerPage + '&';
            if(data.resultsPerPage !== -1) {
                url += 'count=' + data.resultsPerPage;
            }
            return url;
        }

        function search(url, params) {
            params = params || decodeHash();

            window.location.hash = '##' + encodeHash(params);

            sandbox.notify({
                type:'eventPlaceSearch-searchQuery',
                data:params
            });

            sandbox.getScript({
                url: constructSearchUrl(params, url),
                callbackVar: 'callback',
                reload: true,
                jsonP: function (data) {
                    sandbox.notify({
                        type:'eventPlaceSearch-search',
                        data:data
                    });
                }
            });
        }

        function updateSearch(url, data) {
            var params = decodeHash();

            for (var key in data) {
                if (data.hasOwnProperty(key)) {
                    params[key] = data[key];
                }
            }
            console.log(params);
            search(url,params);
        }

        function init() {}
        function destroy() {}

        return {
            encodeHash:encodeHash,
            decodeHash:decodeHash,
            constructSearchUrl:constructSearchUrl,
            search:search,
            updateSearch:updateSearch,
            init:init,
            destroy:destroy
        }
    }
});
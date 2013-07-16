mno.core.register({
    id: 'widget.statistics.googleAnalytics',
    creator:function (sandbox) {

        /**
         * This code triggs Google Analytics when the SPID/paywall javascript has been executed.
         */
        function init() {
            if (sandbox.container) {
                var model = sandbox.model[0],
                paywallEnabled = model.paywallEnabled,
                activate = model.activate;
                var cache;

                if(activate === 'true'){
                    // Adding a listener if the paywall is enabled
                    if(paywallEnabled === 'true'){
                        sandbox.listen({
                            'paywall-ready': function(data) {
                                // Prevent retrigging
                                if(cache === undefined){
                                    // Prevent retrigging of google.
                                    cache = true;
                                    processGoogleAnalytics(model);
                                }
                            }
                        });
                    } else {
                        // Fallback if no paywall is active
                        processGoogleAnalytics(model);
                    }
                }
            }
        }

        // Trigg GA
        function processGoogleAnalytics(model){
            window._gaq = window._gaq || [];
            _gaq.push(['_setAccount', model.gaAccount]);
            _gaq.push(['_setDomainName', model.gaDomain]);
            var addTrack = model.addTrack;
            var dUrl = location.pathname, dSearch = location.search;
            if (dSearch.indexOf("?") == -1 && addTrack != '') {
                dSearch = "?" + addTrack;
            } else if (dSearch.indexOf("?") != -1 && addTrack != '') {
                dSearch = dSearch + "&" + addTrack;
            }
            _gaq.push(['_trackPageview', dUrl + dSearch]);
            (function() {
                var ga = document.createElement('script');
                ga.type = 'text/javascript';
                ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                var s = document.getElementsByTagName('script')[0];
                s.parentNode.insertBefore(ga, s);
            })();
        }

        function destroy() {
            $ = null;
        }

        return {
            init:init,
            destroy:destroy
        };
    }
});



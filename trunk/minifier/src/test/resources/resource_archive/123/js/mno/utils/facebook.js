mno.namespace('mno.utils.facebook');
mno.utils.facebook = (function($) {
    var inited;

    function fbConnectInit() {
        if(inited !== true) {
            inited = true;

            var e = document.createElement('script');
            e.type = 'text/javascript';
            e.src = 'http://connect.facebook.net/nb_NO/all.js';
            e.async = true;
            document.getElementById('fb-root').appendChild(e);
        }
    }

    return {
        fbConnectInit: fbConnectInit
    }
})(jQuery);
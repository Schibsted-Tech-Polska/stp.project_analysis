mno.core.register({
    id:'widget.pageTools.print',
    creator: function (sandbox) {
        function init() {
            function trackPrint() {
                $('body').append('<img src="http://adserver.adtech.de/adserv|3.0|995.1|3637799|0|16|ADTECH;loc=300;alias=AP_Print_Telling_1x1;key=key1+key2+key3+key4;grp=[group];cookie=info" />');
            }
            sandbox.container.find('.print').bind('click', function (e) {
                $(window).unbind('beforeprint', trackPrint);
                trackPrint();
                window.print();
                e.preventDefault();
                $(window).bind('beforeprint', trackPrint);
                e.preventDefault();
            });
            $(window).bind('beforeprint', trackPrint);
        }

        function destroy() {

        }

        return {
            init:init,
            destroy:destroy
        }
    }
});
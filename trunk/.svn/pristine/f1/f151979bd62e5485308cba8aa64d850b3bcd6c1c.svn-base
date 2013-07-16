mno.core.register({
    id:'widget.mnopolarisAd.placement',
    forceStart:true,
    creator: function (sandbox) {
        function init () {

            sandbox.listen({
                'leftAdInserted':function (data) {
                    if ($('window').width() <= 1220) {
                        $('#viewport').css('width','980px');
                    } else {
                        $('#viewport').css('width','1200px');

                    }
                }
            });
            /*
            $(window).unbind('resize');
            */
        }

        function destroy () {}

        return {
            init:init,
            destroy:destroy
        }
    }
});
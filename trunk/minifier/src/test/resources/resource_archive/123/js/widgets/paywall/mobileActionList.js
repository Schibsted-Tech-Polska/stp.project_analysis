mno.core.register({
    id:'widget.paywall.mobileActionList',
    creator: function (sandbox) {
        var hostPublicationUrl = sandbox.model[0].hostPublicationUrl,
            height = 0;
        function init() {
            var $trigger = sandbox.container.find('.userAccount'),
                dropDown = mno.utils.dropdown({
                    trigger:$trigger,
                    content:sandbox.container.find('.logoutscreen'),
                    onOpen:function () {
                        $trigger.text('u');
                    },
                    onClose: function () {
                        $trigger.text('f');
                    }
                });

            $trigger.on('click', function (e) {
                dropDown.toggle();
                e.preventDefault();
            });


            sandbox.listen({
                'access-change': function(data) {
                    // Check if logged in
                    // TODO: The if below must be wrong. Why false here?
                    //if ( data.status == false ) {
                    // TODO replace with dropDown.update()
                   //sandbox.container.find('.logoutscreen');
                    //sandbox.container.find('.loginscreen').css('display', 'none');
                    //	}
                }
            });
            /*sandbox.container.find(".profile").bind('click', function (e) {
                window.location = VGS.getAccountURI();
                e.preventDefault();
            });*/
            sandbox.container.find(".register").bind('click', function (e) {
                window.location = VGS.getSignupURI();
                e.preventDefault();
            });
            sandbox.container.find(".login").bind('click', function (e) {
                window.location = VGS.getLoginURI().replace(window.location.toString(), hostPublicationUrl + '/paywall/pwrd.jsp?redirect=' + Base64.encode(window.location.toString()));
                e.preventDefault();
            });
            sandbox.container.find(".logout").bind('click', function (e) {
                VGS.Auth.logout();
                e.preventDefault();
            });
        }

        return {
            init: init,
            destroy: function() {
            }
        };
    }
});
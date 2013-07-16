mno.core.register({
    id:'widget.paywall.mobileActionListButton',
    creator: function (sandbox) {
        function init() {
            sandbox.container.bind('click', function (e) {
                e.preventDefault();
                e.stopPropagation();
                sandbox.notify({
                    type:'userprofile-clicked',
                    data:{
                        param1:true,
                        e:e
                    }
                });
            });
        }

        return {
            init: init,
            destroy: function() {
            }
        };
    }
});
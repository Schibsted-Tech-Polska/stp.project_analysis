mno.core.register({
    id:'widget.topMenu.sectionMenu',
    creator: function (sandbox) {
            var $ = sandbox.$;

        function init() {

            // Add click event to every menu item
            sandbox.container.find('span.link').each(function (e) {
                $(this).bind('click',function(e){
                    window.location.href = $(this).attr("data-menu-href");
                } );
            });
        }

        function destroy () {
            $ = null;
        }

        return {
            init: init,
            destroy: destroy

        };
    }
});
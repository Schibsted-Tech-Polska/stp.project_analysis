mno.core.register({
    id:'widget.mobileSwipe.default',
    creator: function (sandbox) {
        var paywallEnabled;

        function init() {
            sandbox.container.find(".srContainer").bind('click', function(e) {
                var elements = $(this).children(".dxwSlideRow").find(".dxwRowItem:not('.dxwRowItemNotSelected')").find(".slideItem");
                var clicked = Math.floor( elements.length * event.pageX / document.width );
                window.location.href=$(elements[clicked]).find("a").attr("href");
            });
        }


        return {
            init: init,
            destroy: function() {
            }
        };
    }
});
mno.core.register({
    id:'widget.mobileSwipe.tabbedSwipe',
    creator: function (sandbox) {
        var paywallEnabled;

        function init() {
            sandbox.container.find(".srContainer").bind('click', function(e) {
                var header = $(this).children(".dxwSlideRow").find(".dxwRowItem:not('.dxwRowItemNotSelected')").find("header"); // The header for the section
                var links = $(this).children(".dxwSlideRow").find(".dxwRowItem:not('.dxwRowItemNotSelected')").find("li"); // All the links on the swipe page
                if ( links.length == 0 ) return false; // If there is no links on the page, then just return
                var headerHeight = header.outerHeight(true); // How height is the header
                var linkHeight = $(links[0]).outerHeight(); // How heigh is each link
                var y = event.offsetY - header.outerHeight(true); // Where was the click (minus teh height of the header)
                var clickedIndex = Math.floor( y / linkHeight );
                if ( clickedIndex + 1 > links.length ) return false;
                window.location.href=$(links[clickedIndex]).children("a").attr("href");
            });
        }


        return {
            init: init,
            destroy: function() {
            }
        };
    }
});
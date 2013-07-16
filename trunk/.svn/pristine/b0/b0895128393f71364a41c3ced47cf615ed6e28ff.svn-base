/**
 * Created by IntelliJ IDEA.
 * User: ARISINAB
 * Date: 02.des.2010
 * Time: 12:29:39
 * To change this template use File | Settings | File Templates.
 */
mno.core.register({
    id:'widget.topMenu.mobileMenu',
    creator: function (sandbox) {

        /**
         * Creates swipe navigation on section pages
         */
        function initSwipe() {
            menuItems = [SITEURL];
            sandbox.container.find('> ul > li > a').each(function () {
                menuItems.push($(this).attr('href'));
            });

            var path = mno.utils.params.getPath();
            var sectionIndex = window.jQuery.inArray(path, menuItems);

            if (sectionIndex !== -1) {
                menuItems.rotate(sectionIndex);

                sandbox.listen({
                    'gesture':function (direction) {
                        var url;
                        if (direction==='left') {
                            url = menuItems.pop();
                        } else if (direction === 'right') {
                            if (menuItems[1]) {
                                url=menuItems[1];
                            }
                        }
                        if (url !== undefined && url !== path) {
                            window.location.href = url;
                        }
                    }
                });
            }
        }
        function init() {
            if(sandbox.container !== null){
            	initSwipe();
            }
        }

        function destroy() {

        }

        return {
            init:init,
            destroy: destroy
        };
    }
});
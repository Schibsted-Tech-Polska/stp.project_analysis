mno.core.register({
    id:'widget.topMenu.mobileTabbedMenuDxw',
    wait:['group.mobileHeader'],    // todo groups always run first
    creator: function (sandbox) {
        function init() {
//            mno.features.positionFixed(function (pfixed) {
//                if (pfixed === false) {
//
//                }
//            });
        }

        function destroy() {

        }

        return {
            init:init,
            destroy:destroy
        }
    }
});
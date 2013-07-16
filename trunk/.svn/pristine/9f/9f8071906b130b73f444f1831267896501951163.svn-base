mno.core.register({
    id:'widget.siteIndex.default',
    creator: function (sandbox) {

        function init() {
            var sectionWidgetId = mno.publication.sectionWidgetId;
            mno.utils.dialog({
                content:sandbox.publication.url + '?widget=sectionSiteMap&contentId=' + sectionWidgetId
            });
//            sandbox.storeData({
//                type:'module-position',
//                data: function () {
//                    return {
//                        title:'Nettstedkart',
//                        position:sandbox.getPosition()
//                    };
//                }
//            });
        }

        function destroy () {
        }

        return  {
            init: init,
            destroy: destroy
        };

    }
});

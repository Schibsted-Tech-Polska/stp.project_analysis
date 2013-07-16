mno.core.register({
    id:'widget.realEstateInfo.visitingInfo',
    extend: ['widget.realEstateInfo.common'],

    creator:function (sandbox) {

        function init() {
            var parent = this;
            if (sandbox.container) {
                // loop through instances of the widget

                this.getData(function (objData) {
                    sandbox.container.each(function (widgetIndex, element) {
                        // assign locally a model variable for the current instance
                        var model = sandbox.model[widgetIndex];
                        var $view = $(element);

                        sandbox.render("widgets.realEstateInfo.views.visitingInfo", { obj: objData, visiting: objData.properties.viewings }, function($html) {
                            $view.html($html);
                        });
                    });
                });
            }
        }

        function destroy() {
        }

        return {
            init:init,
            destroy:destroy
        }
    }
});
mno.core.register({
    id:'widget.realEstateInfo.otherInfo',
    extend:['widget.realEstateInfo.common'],

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

                        var propertyInfo = [];

                        var add = function (key, label, format) {
                            parent.pushField(propertyInfo, objData.properties, key, label, format || '{0}');
                        }
                        //add('cadastre.cadastralUnitNumber', 'Kommunenr');
                        add('cadastre.cadastralUnitNumber', 'G&aring;rdsnr')
                        add('cadastre.propertyUnitNumber', 'Bruksnr');
                        add('sectionUnitNumber', 'Seksjonsnr');
                        add('externalAdId', 'Meglers referanse');

                        var info = objData.properties.facilities;
                        if (typeof(info) !== "undefined") {
                            try {
                                // if there's only one feature, it's a string instead of an array
                                if (info.constructor.name === "String") {
                                    info = [ info ];
                                }
                            } catch (e) {
                            }

                            for (var i = 0; i < info.length; i++) {
                                parent.pushField(propertyInfo, info, i, '', "{0}");
                            }
                        }
                        sandbox.render("widgets.realEstateInfo.views.otherInfo", { obj:objData, info:propertyInfo }, function ($html) {
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

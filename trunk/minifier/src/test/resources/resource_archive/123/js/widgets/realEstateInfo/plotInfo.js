mno.core.register({
    id:'widget.realEstateInfo.plotInfo',
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

                        var propertyInfo = [];
                        var addFeature = function (key, label, format, args) {
                            parent.pushField(propertyInfo, objData.properties, key, label, format, args);
                        };
                        addFeature('primaryRoomArea', 'Primærrom', '{0}m²');
                        addFeature('usableArea', 'Bruksareal', '{0}m²');
                        addFeature('grossArea', 'Bruttoareal', '{0}m²');
                        addFeature('plotSize', 'Tomt', '{0}m²');
                        addFeature('constructionYear', 'Byggeår', '{0}');
                        addFeature('renovatedYear', 'Renovert', '{0}');
                        addFeature('energyLabel', 'Energimerking', '{0}');
                        addFeature('changeOfOwnershipInsurance', 'Eierskifteforsikring', '{0}');

                        sandbox.render("widgets.realEstateInfo.views.plotInfo", { obj: objData, info: propertyInfo }, function($html) {
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
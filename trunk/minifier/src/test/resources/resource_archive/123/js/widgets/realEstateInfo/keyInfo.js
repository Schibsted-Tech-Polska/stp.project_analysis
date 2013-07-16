mno.core.register({
    id:'widget.realEstateInfo.keyInfo',
    extend:['widget.realEstateInfo.common'],
    creator:function (sandbox) {
        function init() {
            var parent = this;
            if (sandbox.container) {
                // loop through instances of the widget
                sandbox.container.each(function (widgetIndex, element) {
                    // assign locally a model variable for the current instance
                    var $basicInfo = $(element);

                    parent.getData(function (jsonData) {
                        var featureArray = [];
                        var addFeature = function (key, label, format, args) {
                            parent.pushField(featureArray, jsonData.properties, key, label, format, args);
                        };
                        addFeature('priceIndication', 'Prisantydning', '{0},-');
                        addFeature('collectiveDebt', 'Fellesgjeld', '{0},-');
                        addFeature('price', 'Totalpris', '{0},-');
                        addFeature('primaryRoomArea', 'Primærrom', '{0}m²');
                        addFeature('propertyType', 'Boligtype', '{0}');
                        addFeature('ownershipType', 'Eierform', '{0}');
                        addFeature('numberOfRooms', 'Rom', '{0}');
                        addFeature('numberOfBedrooms', 'Soveom', '{0}');
                        addFeature('floor', 'Etasje', '{0}.');
                        addFeature('collectiveAssets', 'Fellesformue', '{0},-');
                        addFeature('sharedCost', 'Felleskost. mnd', '{0},-');

                        sandbox.render("widgets.realEstateInfo.views.keyInfo", { obj:jsonData, features:featureArray }, function ($html) {
                            $basicInfo.html($html);
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
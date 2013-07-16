mno.core.register({
    id:'widget.realEstateInfo.keyInfoBar',
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

                        var otherInfo = [];

                        function addToList(key, format) {
                            parent.pushField(otherInfo, objData.properties, key, '', format);
                        }

                        addToList('propertyType', '{0}');
                        addToList('primaryRoomArea', '{0} m²');
                        addToList('numberOfRooms', '{0} rom'); // TODO check
                        addToList('numberOfBedrooms', '{0} soverom');
                        addToList('floor', '{0}. etasje');

                        sandbox.render("widgets.realEstateInfo.views.keyInfoBar", {
                            price: parent.formatPrice(objData.properties.priceIndication),
                            otherInfo:otherInfo
                        }, function ($html) {
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
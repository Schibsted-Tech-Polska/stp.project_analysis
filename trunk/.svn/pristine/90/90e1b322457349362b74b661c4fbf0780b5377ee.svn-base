mno.core.register({
    id:'widget.realEstateInfo.priceInfo',
    extend: ['widget.realEstateInfo.common'],

    creator:function (sandbox) {

        var commonData = {
            publication:sandbox.publication.name
        };

        function init() {
            var parent = this;
            if (sandbox.container) {
                // loop through instances of the widget
                this.getData(function (objData) {
                    sandbox.container.each(function (widgetIndex, element) {
                        // assign locally a model variable for the current instance
                        var model = sandbox.model[widgetIndex];
                        var $view = $(element);

                        var priceInformation = [];
                        var addFeature = function (key, label, format, args) {
                            parent.pushField(priceInformation, objData.properties, key, label, format, args);
                        };
                        addFeature('priceIndication', 'Prisantydning', '{0},-');
                        addFeature('collectiveDebt', 'Fellesgjeld', '{0},-');
                        addFeature('estimatedValue', 'Verditakst', '{0},-');
                        addFeature('mortgageValue', 'Lånetakst', '{0},-');
                        addFeature('collectiveAssets', 'Fellesformue', '{0},-');
                        addFeature('sharedCost', 'Felleskost. mnd', '{0},-');

                        sandbox.render("widgets.realEstateInfo.views.priceInfo", { obj: objData, costs: priceInformation }, function($html) {
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
mno.core.register({
    id:'widget.realEstateInfo.heading',
    extend:['widget.realEstateInfo.common'],

    creator:function (sandbox) {

        function init() {
            if (sandbox.container) {
                // loop through instances of the widget

                this.getData(function (objData) {
                    sandbox.container.each(function (widgetIndex, element) {
                        // assign locally a model variable for the current instance
                        var model = sandbox.model[widgetIndex];
                        var $view = $(element);

                        /* ["2012", "07", "11", "16", "11", "00", "0200"] */
                        var dateParts = objData.properties.lastChangedDate.match(/(\d+)/g),
                            norwegianMonths = [ 'Januar', 'Februar', 'Mars', 'April', 'Mai', 'Juni', 'Juli', 'August', 'September', 'Oktober', 'November', 'Desember' ];
                        var dateString = parseInt(dateParts[2], 10) + '. ' + norwegianMonths[parseInt(dateParts[1], 10) - 1] + ' ' + dateParts[0],
                            timeString = dateParts[3] + ':' + dateParts[4];

                        sandbox.render("widgets.realEstateInfo.views.heading", {
                            obj:objData,
                            dateString:dateString,
                            timeString:timeString
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

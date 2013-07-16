mno.core.register({
    id:'widget.realEstateInfo.brokerInfo',
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

                        var url;
                        try {
                            url = objData.properties['contact.url'];
                            if (!(!!url.match(/https?:\/\//))) {
                                objData.properties['contact.url'] = 'http://' + url;
                            }
                        } catch (e) {
                            // oh well, no url to fix
                        }

                        sandbox.render("widgets.realEstateInfo.views.brokerInfo", { obj:objData.properties }, function ($html) {
                            $view.html($html);

                            $view.find('a').click(function () {
                                if (typeof(_gaq) !== "undefined") {
                                    try {
                                        _gaq.push([ 'rECl._trackEvent', objData.id, 'exit']);
                                    }
                                    catch (e) {
                                        mno.core.log(3, e);
                                    }
                                }
                            })
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
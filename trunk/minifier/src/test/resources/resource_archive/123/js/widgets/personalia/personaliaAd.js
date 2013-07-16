mno.core.register({
    id:'widget.personalia.personaliaAd',
    creator:function (sandbox) {
        var $ = sandbox.$,
            adLocation = (typeof sandbox.model[0] !== 'undefined') ? sandbox.model[0].personaliaAdLocation : '',
            appUrl = (typeof sandbox.model[0] !== 'undefined') ? sandbox.model[0].personaliaAppUrl : '',
            params = mno.utils.params,
            that,
            resultElement = $('#personaliaAdWrapper');

        function callback(data) {
            if(data.message.records){
                var item = {
                    items: data.message.records,
                    adLocation: adLocation

                };
                if (sandbox.container) {
                    sandbox.render('widgets.personalia.views.personaliaAd', item, function (html) {

                        var name = (typeof item.items[0].firstName !== 'undefined') ? item.items[0].firstName +" "+ item.items[0].lastName : item.items[0].lastName;

                        resultElement.append("<h3>"+name+"</h3>").append(html);
                    });
                }
            }
        }

        function init() {
            if(sandbox.container){
                that = this;
                var parameters = params.getAllParameters();

                sandbox.getScript({
                url: appUrl + 'showAd.htm?adNo=' + parameters.adNo + '&view=json',
                callbackVar:'callback',
                jsonP:callback
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

mno.core.register({
    id:'widget.notifications.categories',
    extend:['mno.utils.rubrikk'],
    creator: function (sandbox) {
        var that = this;

        // TODO Fjern denne fra globalt scope
        function callback(data) {
            if (data.message.records) {
                var paramCount = sandbox.model[0].adCount,
                records = data.message.records,
                count = (records.length >= paramCount) ? paramCount : records.length,
                item = {
                    adUrl: sandbox.model[0].adUrl,
                    sokUrl: sandbox.model[0].sokUrl,
                    items: records
                };

                if (sandbox.container) {
                    sandbox.render('widgets.notifications.views.categories', item, function (html) {
                        sandbox.container.append(html);
                    });
                }
            }
        }

        callbackNotificationCategories = function (data) {
            callback.call(that.instance, data);
        };

        function init() {
            sandbox.getScript({
                url:this.jsonUrlNotifications + 'categories.json'
            });
        }

        function destroy() {

        }

        return  {
            init: init,
            destroy: destroy
        };
    }
});

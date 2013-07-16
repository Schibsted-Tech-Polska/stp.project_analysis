mno.core.register({
    id:'widget.notifications.notificationAd',
    extend:['mno.utils.rubrikk'],
    creator: function (sandbox) {
        var $ = sandbox.$;
        var that = this;

        function callback(data) {
            var notificationad = data.message.success && typeof data.message.records !== "undefined";

            if (notificationad !== false && data.message.records.length > 0) {
                notificationad = data.message.records[0];
                var imgWidth = (sandbox.model[0].isMobile==true) ? sandbox.model[0].max_image_width : 466;
                var item = {
                    notificationad: notificationad,
                    lisaLevel: this.lisaLevel,
                    imgWidth: imgWidth
                };

                if (sandbox.container) {
                    sandbox.render('widgets.notifications.views.notificationAd', item, function (html) {
                        sandbox.container.empty();
                        sandbox.container.append(html);
                    });
                }

            }
        }

        cbNotificationAd = function(data) {
            callback.call(that.instance, data);
        };

        function init() {
            if (sandbox.container) {
                var params = mno.utils.params,
                   jsonUrl = 'notificationad.json?renderType=public&notificationAdId=' + params.getParameter('notificationAdId') + '&cb=cbNotificationAd',
                   wholeUrl = this.rubrikkCacheUrl + jsonUrl;
                if (params.getParameter('rnd')) {
                    wholeUrl = wholeUrl + '&rnd=' + params.getParameter('rnd');
                }
                sandbox.getScript({
                    url:wholeUrl
                });
            }
        }

        function destroy() {

        }

        return {
            init:init,
            destroy:destroy
        };
    }
});
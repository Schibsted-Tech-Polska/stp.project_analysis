mno.core.register({
    id:'widget.notifications.notificationList',
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
                    lisaLevel: this.lisaLevel,
                    items:shuffleAds(records, count)
                };

                if (sandbox.container) {
                    sandbox.render('widgets.notifications.views.notificationList', item, function (html) {
                        sandbox.container.append(html);
                    });
                }
            }
        }

        function shuffleAds(allRecords, countAds) {
            var filteredAds = [];
            for(var i=0; i<countAds; i++){
                var numAds = allRecords.length;
                if(numAds>0){
                    var rand = Math.floor(Math.random()*numAds);
                    filteredAds.push(allRecords.splice(rand, 1)[0]);
                }
            }
            return filteredAds;
        }

        callbackNotificationList = function (data) {
            callback.call(that.instance, data);
        };

        function init() {
            sandbox.getScript({
                url:this.jsonUrlNotifications + 'list.json'
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

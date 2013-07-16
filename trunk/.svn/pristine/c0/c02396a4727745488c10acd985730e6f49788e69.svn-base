mno.core.register({
            id:'widget.propertyAds.list',
            extend:['mno.utils.rubrikk'],
            creator: function (sandbox) {
                var that = this;

                function formatCurrency(num) {
                    num = Math.floor(num * 100 + 0.50000000001);
                    num = Math.floor(num / 100).toString();
                    for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
                        num = num.substring(0, num.length - (4 * i + 3)) + '.' + num.substring(num.length - (4 * i + 3));
                    return(num);
                }

                // TODO Fjern denne fra globalt scope
                function callback(data) {
                    if (data.message.records) {
                        var paramCount = sandbox.model[0].adCount,
                        records=data.message.records,
                        count = (records.length >= paramCount) ? paramCount : records.length,
                        item = {
                            adUrl: sandbox.model[0].adUrl,
                            //lisaLevel: that.lisaLevel,
                            lisaLevel: "lisacache",
                            items:shuffleAds(records, count)
                        };

                    if (sandbox.container) {
                        sandbox.render('widgets.propertyAds.views.list', item, function (html) {
                            sandbox.container.append(html);
                        });
                    }
                }
            }

        function shuffleAds(allRecords, countAds) {
            var filteredAds = [];
            for (var i = 0; i < countAds; i++) {
                var numAds = allRecords.length;
                if (numAds > 0) {
                    var rand = Math.floor(Math.random() * numAds);
                    filteredAds.push(allRecords.splice(rand, 1)[0]);
                }
            }
            return filteredAds;
        }

        cbPropertyAdsList = function (data) {
            callback.call(that.instance, data);
        };

        function init() {
            sandbox.getScript({
                // todo: legg til categoryid i url dersom angitt
                url:this.jsonUrlBolig + 'propertyAds.json'
            });
        }

        function destroy() {}

        return  {
            init: init,
            destroy: destroy
        };
    }
});

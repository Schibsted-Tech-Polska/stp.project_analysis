mno.core.register({
    id:'widget.jobAdListings.frontpageCompanies',
    extend:['mno.utils.rubrikk'],
    creator: function (sandbox) {
        var that = this;

        function callback(data) {
            if (data.message.records) {
                var records = data.message.records,
                    countCompanies = sandbox.model[0].countCompanies,
                    countAds = sandbox.model[0].countAds,
                    item = {
                        adUrl: sandbox.model[0].jobAdUrl,
                        rubrikkUrl:this.rubrikkUrl,
                        lisaLevel:this.lisaLevel,
                        items:filterAds(records, countCompanies, countAds),
                        jobSectionUrl:sandbox.model[0].jobSectionUrl
                    };
                if (sandbox.container) {
                    sandbox.render('widgets.jobAdListings.views.frontpageCompanies', item, function (html) {
                        sandbox.container.append(html);
                    });
                }
            }
        }

        cbFrontpageCompanies = function (data) {
            callback.call(that.instance, data);
        };

        function filterAds(allRecords, countCompanies, countAds) {
            var filteredRecords = [];
            for (var r = 0; r < countCompanies; r++) {
                var numRecords = allRecords.length;
                var randRecord = Math.floor(Math.random() * numRecords);
                var record = allRecords.splice(randRecord, 1)[0];
                var filteredAds = [];
                var jobAds = record.jobAds;
                filteredRecords.push(record);
                for (var i = 0; i < countAds; i++) {
                    var numAds = jobAds.length;
                    if (numAds > 0) {
                        var rand = Math.floor(Math.random() * numAds);
                        var ad = jobAds.splice(rand, 1)[0];
                        filteredAds.push(ad);
                    }
                }
                record.jobAds = filteredAds;
            }
            return filteredRecords;
        }

        function init() {
            sandbox.getScript({
                url:this.jsonUrl + 'frontpageCompanies.json'
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
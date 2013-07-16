mno.core.register({
    id:'widget.jobAdListings.mgmt',
    extend:['mno.utils.rubrikk'],
    creator: function (sandbox) {
        var that = this;

        // TODO Fjern denne fra globalt scope
        function callback(data) {
            if (data.message.records) {
                var records = data.message.records,
                    paramCount = sandbox.model[0].adCount,
                    count = (records.length >= paramCount) ? paramCount : records.length,
                    jobAd,
                    that = this,
                    item = {
                        adUrl: sandbox.model[0].jobAdUrl,
                        lisaLevel:that.lisaLevel,
                        items:shuffleAds(records, count),
                        allJobsUrl:sandbox.model[0].allJobsUrl
                    };
                if (sandbox.container) {
                    sandbox.render('widgets.jobAdListings.views.mgmt', item, function (html) {
                        sandbox.container.append(html);
                    });
                }
            }
        }

        cbProfiledMgmtJobs = function (data) {
            callback.call(that.instance, data);
        };

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

        function init() {
            sandbox.getScript({
                url:this.jsonUrl + 'profiledMgmtJobs.json'
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

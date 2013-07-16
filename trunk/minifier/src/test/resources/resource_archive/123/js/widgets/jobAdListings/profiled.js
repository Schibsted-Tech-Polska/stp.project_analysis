mno.core.register({
    id:'widget.jobAdListings.profiled',
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
                    if(sandbox.model[0].noImages == 'true'){
                        sandbox.render('widgets.jobAdListings.views.latest', item, function (html) {
                            sandbox.container.append(html);
                        });
                    }else{
                        sandbox.render('widgets.jobAdListings.views.profiled', item, function (html) {
                            sandbox.container.append(html);
                        });
                    }
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


        cbProfiledJobs = function (data) {
            callback.call(that.instance, data);
        };

        function init() {
            sandbox.getScript({
                url:this.jsonUrl + 'profiledJobs.json'
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

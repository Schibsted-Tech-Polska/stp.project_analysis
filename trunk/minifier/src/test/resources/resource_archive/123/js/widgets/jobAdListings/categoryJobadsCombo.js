mno.core.register({
    id:'widget.jobAdListings.categoryJobadsCombo',
    extend:['mno.utils.rubrikk'],
    creator: function (sandbox) {
        var that = this;

        function callback(data) {
            // TODO Hvordan kan jeg vite hvilken kategori dette er så riktig overskrift kan legges på???
            if (data.message.records) {
                var records = data.message.records,
                    paramCount = sandbox.model[0].adCount,
                    count = (records.length >= paramCount) ? paramCount : records.length,
                    jobAd,
                    that = this,
                    item = {
                        adUrl: sandbox.model[0].jobAdUrl,
                        lisaLevel:that.lisaLevel,
                        rubrikkUrl:this.rubrikkUrl,
                        items:shuffleAds(records, count),
                        allJobsUrl:sandbox.model[0].allJobsUrl
                    };
                if (sandbox.container) {
                    sandbox.render('widgets.jobAdListings.views.categoryJobadsCombo', item, function (html) {
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

        cbCategoryJobads = function (data) {
            callback.call(that.instance, data);
        };

        function init() {
            if(sandbox.model[0].categories){
                var categoryArr = sandbox.model[0].categories;
                for(var i=0; i<categoryArr.length;i++){
                    sandbox.getScript({
                        url:this.jsonUrl + 'categoryJobads_'+ categoryArr[i].categoryId+'.json'
                    });
                }
            }
        }

        function destroy() {
        }

        return  {
            init: init,
            destroy: destroy
        };
    }
});

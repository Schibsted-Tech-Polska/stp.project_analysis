mno.core.register({
    id:'widget.jobAdListings.recruiting',
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
                        statAppend: (mno.publication.name != 'ap')? '_'+mno.publication.name.toUpperCase():'',
                        items:filterAds(records, countCompanies, countAds),
                        jobSectionUrl:sandbox.model[0].jobSectionUrl
                    };
                if (sandbox.container) {
                    sandbox.render('widgets.jobAdListings.views.recruiting', item, function (html) {
                        sandbox.container.append(html);
                    });
                }
            }
        }

        cbRecruitingCompanies = function (data) {
            callback.call(that.instance, data);
        };

        function filterAds(allRecords, countCompanies, countAds) {
            var filteredRecords = allRecords,
                    numRecords = filteredRecords.length;
            if(numRecords > countCompanies){
                filteredRecords.splice(countCompanies, numRecords-countCompanies);
            }
            numRecords = filteredRecords.length;
            for(var r=0; r<numRecords; r++){
                var filteredAds = [],
                record = filteredRecords[r],
                jobAds = record.jobAds;
                for(var i=0; i<countAds; i++){
                    var numAds = jobAds.length;
                    if(numAds>0){
                        var rand = Math.floor(Math.random()*numAds);
                        filteredAds.push(jobAds.splice(rand, 1)[0]);
                    }
                }
                record.jobAds = filteredAds;
            }
            return filteredRecords;
        }

        function init() {
            sandbox.getScript({
                url:this.jsonUrl + 'recruitingCompanies.json'
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
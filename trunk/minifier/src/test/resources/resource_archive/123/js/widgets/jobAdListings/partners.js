mno.core.register({
    id:'widget.jobAdListings.partners',
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
                        rubrikkUrl:this.rubrikkUrl,
                        xitiId: sandbox.model[0].xitiId,
                        items:records.slice(0,count),
                        onlyLinks:sandbox.model[0].onlyLinks,
                        allJobsUrl:sandbox.model[0].allJobsUrl
                    };
                if (sandbox.container) {
                    sandbox.render('widgets.jobAdListings.views.partners', item, function (html) {
                        sandbox.container.append(html);
                    });
                }
            }
        }

        cbPartners = function (data) {
            callback.call(that.instance, data);
        };

        function init() {
            sandbox.getScript({
                url:this.jsonUrl + 'partners.json'
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

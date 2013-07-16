mno.core.register({
    id:'widget.jobAdSearch.jobad',
    extend:['mno.utils.rubrikk'],
    creator: function (sandbox) {
        var $ = sandbox.$;
        var that = this;

        function callback(data) {
            var jobad = data.message.success && typeof data.message.records !== "undefined";

            if (jobad !== false && data.message.records.length > 0) {
                jobad = data.message.records[0];
                var applicationTypeName = jobad.applicationType.applicationTypeName;
                var applicationTypeText = (applicationTypeName == 'MORE_INFO') ? 'Mer informasjon om stillingen' : 'S&oslash;k p&aring; stillingen';
                var mobile = (sandbox.model[0].isMobile==true) ? '_MOBILE':'';
                mobile = (sandbox.model[0].isMobile==true && mno.publication.name == 'ap') ? '_MOBILE_AP' : mobile;
                var imgWidth = (sandbox.model[0].isMobile==true) ? sandbox.model[0].max_image_width:466;
                var item = {
                    jobad: jobad,
                    applicationTypeText: applicationTypeText,
                    adUrl: sandbox.model[0].jobbUrl,
                    rubrikkUrl: this.rubrikkUrl,
                    lisaLevel: this.lisaLevel,
                    imgWidth: imgWidth,
                    publicationNameUC: (mno.publication.name == 'ap') ? mobile + '' : mobile + '_' + mno.publication.name.toUpperCase(),
                    country: typeof jobad.company.companyAddress !== 'undefined' ?  jobad.company.companyAddress.country.name.toLowerCase() : 'norge',
                    time: new Date().getTime()
                };

                if (sandbox.container) {
                    sandbox.render('widgets.jobAdSearch.views.jobad', item, function (html) {
                        sandbox.container.empty();
                        sandbox.container.append(html);
                    });
                }

            }
        }

        cbJobAd = function(data) {
            callback.call(that.instance, data);
        };

        function init() {
            if (sandbox.container) {
                var params = mno.utils.params,
                    jsonUrl = 'jobad.json?renderType=public&jobAdId=' + params.getParameter('jobAdId') + '&cb=cbJobAd',
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
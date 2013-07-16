mno.core.register({
    id:'widget.mobileAd.smb',
    creator:function (sandbox) {
        var $ = sandbox.$;

        function init() {
            if (sandbox.container) {
                var runInitSmbAd = this.initSmbAd;

                sandbox.container.each(function(i, element){
                      runInitSmbAd(sandbox,element, sandbox.model[i]);
                });
            }
        }

        function initSmbAd(sandbox, cont, mod){
            var element = cont;
            var model = mod;

            if(model.layout == 'full'){
                cbFull  = function (data) {
                    if(data.ads){
                        var item = buildItem(data,model);
                        sandbox.render('widgets.mobileAd.views.smb_full', item, function (html) {
                            sandbox.container.find('.smbContainer').empty().html(html);
                        });
                    }
                };
                sandbox.getScript({
                    url:model.jsonUrl
                });
            }

            if(model.layout == 'half'){
                cbHalf  = function (data) {
                    if(data.ads){
                        var item = buildItem(data,model);
                        sandbox.render('widgets.mobileAd.views.smb_half', item, function (html) {
                            sandbox.container.find('.smbContainer').empty().html(html);
                        });
                    }
                };
                 sandbox.getScript({
                     url:model.jsonUrl
                 });
            }
        }
        function getImageName(imageUrl){
            if(imageUrl != undefined){
               var tmpLogo = imageUrl.split('/');
               return(tmpLogo[tmpLogo.length -1]);
            }
        }

        function buildItem(data,model){
            if(data.ads){
                var ad = shuffleAds(data.ads,data.limit);
                var item = {
                    adUrl: ad[0].url,
                    adId: ad[0].nid,
                    title: ad[0].title,
                    text: ad[0].text,
                    adImage: getImageName(ad[0].image),
                    oldPrice: ad[0].price_before ? ad[0].price_before.replace(".00", "") : ad[0].price_before,
                    newPrice: ad[0].price_now ? ad[0].price_now.replace(".00", "") : ad[0].price_now,
                    discount: ad[0].price_discount ? '-' + ad[0].price_discount + '%' : ad[0].price_discount,
                    company: ad[0].company_name,
                    compLogo: getImageName(ad[0].company_logo),
                    siteLogo: mno.publication.url + 'skins/global/gfx/marked/lgo_' + mno.publication.name + '_nyttig1.png',
                    lisaLevel: "lisacache",
                    imgUrl: model.imgUrl,
                    logoUrl: model.imgUrl + "logos/",
                    maxWidth: model.max_image_width
                };
                return item;
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

        function destroy() {
            $ = null;
        }

        return {
            init:init,
            destroy:destroy,
            initSmbAd:initSmbAd
        }
    }
});


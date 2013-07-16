mno.core.register({
    id:'widget.mobileAppShow.automatic',
     extend:['widget.mobileAppShow.default'],
    creator:function (sandbox) {
        var $ = sandbox.$,
            isIphone,
            isAndroid,
            loadCarousel;

        function init() {
            if (sandbox.container) {
                var that = this;
                isIphone = that.isIphone;
                isAndroid = that.isAndroid;
                loadCarousel = that.loadCarousel;
                sandbox.container.each(function(i, element){
                    initAppShow(sandbox,sandbox.model[i]);

                });                                                                                                                                                              //
            }
        }

        function _getImageName(imageUrl){
            if(imageUrl != undefined){
               var tmpLogo = imageUrl.split('/');
               return(tmpLogo[tmpLogo.length -1]);
            }
        }

        function initAppShow(sandbox,model){

         cbAppFarm = function (data) {
            if(data.objects.items.length > 0){
                for(var i=0; i<data.objects.items.length; i++){
                    if(data.objects.items[i].imgurl !== ''){
                        data.objects.items[i].imgurl = _getImageName(data.objects.items[i].imgurl);
                    }
                }
                var item = {
                    title: sandbox.model[0].appshowtitle,
                    items:data.objects.items,
                    lisaLevel: "lisacache",
                    iconsize: sandbox.model[0].iconsize
                };
                sandbox.render('widgets.mobileAppShow.views.automatic', item, function (html) {
                    sandbox.container.find('div#appFarm').empty().html(html);
                    loadCarousel();
                });

                }
            };
            sandbox.getScript({
                url:model.jsonUrl

            });



        }

        function destroy() {
            $ = null;
        }
         return {
            init:init,
            destroy:destroy
        }
    }
});



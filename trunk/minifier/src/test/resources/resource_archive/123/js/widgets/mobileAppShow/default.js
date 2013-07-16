mno.core.register({
    id:'widget.mobileAppShow.default',
    creator:function (sandbox) {
        var $ = sandbox.$;

        function isAndroid() {
            return (navigator.userAgent.toLowerCase().search('android') > -1);
        }

        function isIphone(){
            return (navigator.userAgent.toLowerCase().search('iphone') > -1);
        }

        function loadCarousel() {

            /* cycle infinite */
            var autoscrolling = true;
            var triggerFromTimer = false;

            // Disable autoscrolling if the user clicks the prev or next button.
            function appFarmCallback(appfarm) {
                // Disable autoscrolling if the user clicks the prev or next button.
                appfarm.buttonNext.bind('click', function() {
                    if(!triggerFromTimer) autoscrolling = false;
                    triggerFromTimer = false;
                });

                appfarm.buttonPrev.bind('click', function() {
                    if(!triggerFromTimer) autoscrolling = false;
                    triggerFromTimer = false;
                });
            }

            if(isAndroid() === true || isIphone() === true) {
                // first remove DOM elements that doesn't relate to the current smartphone version
                if(isIphone() === true) {
                    jQuery('.appfarm-android').remove();
                } else if(isAndroid() === true) {
                    jQuery('.appfarm-iphone').remove();
                }

                // Load carousel
                jQuery('#appfarm').jcarousel({
                    wrap: 'circular',
                    scroll: 1,
                    visible: 2,
                    initCallback: appFarmCallback
                });

                // Disable autoscrolling if user clicks on a link
                var apps = jQuery('ul#appfarm > li');
                var appLinks = apps.find('a');

                appLinks.bind('click', function() {
                    autoscrolling = false;
                });

                // Auto scroll carousel
                if(apps.size() >= 3) {
                    setInterval(function () {
                        if (autoscrolling) {
                            triggerFromTimer = true;
                            jQuery('.jcarousel-next').trigger('click');
                        }
                    }, 2000);
                }
            }
        }

        function init() {
            if (sandbox.container) {
                 var that = this;


                sandbox.container.each(function(i, element){
                    _renderCarouselList(element,sandbox.model[i]);

                });                                                                                                                                                              //
            }
        }



        function _renderCarouselList(element,model){
            var appList = '';
            if(isAndroid() === true || isIphone() === true) {
                var annonse1;
                var annonse2;
                var annonse3;
                var annonse4;

                if(($('#url1').val() != null ) && $('#url1img').val()){
                    annonse1 = {
                        url:$('#url1').val(),
                        img: $('#url1img').val()
                    };
                }

                 if(($('#url2').val() != null ) && $('#url2img').val()){
                    annonse2 = {
                        url:$('#url2').val(),
                        img: $('#url2img').val()
                    };
                }
                 if(($('#url3').val() != null ) && $('#url3img').val()){
                    annonse2 = {
                        url:$('#url3').val(),
                        img: $('#url3img').val()
                    };
                }
                 if(($('#url4').val() != null ) && $('#url4img').val()){
                    annonse2 = {
                        url:$('#url4').val(),
                        img: $('#url4img').val()
                    };
                }

                appList = '<h1 class="appfarmHeading">'+ model.appshowtitle +'</h1><ul id="appfarm" class="jcarousel-skin-tango">';
                if((typeof annonse1 != 'undefined')){
                    appList += '<li><a title="Annonse" href="'+annonse1.url+'" target="_blank"><img src="http://lisacache.aftenposten.no/utils/img.php?src=' + annonse1.img + '&width='+model.iconsize+'"/><br />'+ model.raw1text+'</a></li>';
                }
                if((typeof annonse2 != 'undefined')){
                    appList += '<li><a title="Annonse" href="'+annonse2.url+'" target="_blank"><img src="http://lisacache.aftenposten.no/utils/img.php?src=' + annonse2.img + '&width='+model.iconsize+'"/><br />'+ model.raw2text+'</a></li>';
                }
                if((typeof annonse3 != 'undefined')){
                    appList += '<li><a title="Annonse" href="'+annonse3.url+'" target="_blank"><img src="http://lisacache.aftenposten.no/utils/img.php?src=' + annonse3.img + '&width='+model.iconsize+'"/><br />'+ model.raw3text+'</a></li>';
                }
                if((typeof annonse4 != 'undefined')){
                    appList += '<li><a title="Annonse" href="'+annonse4.url+'" target="_blank"><img src="http://lisacache.aftenposten.no/utils/img.php?src=' + annonse4.img + '&width='+model.iconsize+'"/><br />'+ model.raw4text+'</a></li>';
                }
                appList += '</ul>';
                //document.getElementById('appFarm').innerHTML = appList;
                $("div#appFarm").append($(appList));
                loadCarousel();
            }
        }

        function destroy() {
            $ = null;
        }
         return {
            init:init,
            destroy:destroy,
            loadCarousel:loadCarousel,
             isAndroid:isAndroid,
             isIphone:isIphone
        }
    }
});



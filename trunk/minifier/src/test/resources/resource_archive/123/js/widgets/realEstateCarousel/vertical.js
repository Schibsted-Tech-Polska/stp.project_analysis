/**
 * RealEstateList Widget Vertical view
 *
 * @copyright Schibsted
 * @package mno.widgets
 * @subpackage realEstateList
 * @author michal.skinder@medianorge.no
 * @description
 * Vertical view of randomized nonDHTML list of ads.
 *
 */
mno.core.register({
    id: 'widget.realEstateCarousel.vertical',

    creator: function (sandbox) {
        var commonData = {
            publication: sandbox.publication.name,
            serviceUrl: "http://ocacache.medianorge.no/oca/s/v1/getList/",
            landingUrl: "http://www.finn.no/"
        };

        function init() {
            if (sandbox.container) {
                sandbox.container.each(function (widgetIndex, element) {
                        var model = sandbox.model[widgetIndex],
                            dataGB = [],
                            $carousel = $(element);
                        var $adList = $carousel.find('.resultListBox');

                        var categories = [];
                        var categoriesList = [];
                        var categoryId;

                        var lisaSettings = {
                            useCache: true,
                            useCacheForBrokers: true,
                            properties: {
                                'height': 120
                            },
                            brokerProperties: {
                                'width': 180,
                                'height': 17
                            },
                            serviceUrl: 'http://' + model.lisaLevel + '.aftenposten.no/utils/img.php'
                        };

                        if (model.lisaLevel !== '') {
                            lisaSettings.useCache = true;
                            lisaSettings.useCacheForBrokers = true;
                        }

                        if (model.priceDisplay !== undefined && model.priceDisplay !== 'default') {
                            $carousel.addClass(model.priceDisplay);
                        }


                        if (model.serviceUrl !== undefined) {
                            if (model.serviceUrl !== '') {
                                commonData.serviceUrl = model.serviceUrl;
                            }
                        }



                        if (model.landingUrl !== undefined) {
                            if (model.landingUrl !== '') {
                                commonData.landingUrl = model.landingUrl;
                            }
                        }

                        fetchAds();

                        function fetchAds() {
                            var url = commonData.serviceUrl;
                            var data = {
                                publicationId: commonData.publication,
                                channelId: model.channel,
                                carouselId: model.carouselId,
                                maxAds: model.adsMax
                            };
                            var key;
                            var data_array = [];
                            for (key in data) {
                                data_array.push(data[key]);
                            }
                            url += data_array.join('/');

                            sandbox.getScript({
                                url: url,
                                callbackVar: 'callback',
                                callbackName: 'reVertical' + widgetIndex,
                                jsonP: onAdsLoaded,
                                error: onError
                            });
                        }

                        function onAdsLoaded(data) {
                            if (data !== undefined) {
                                if (data.ads !== undefined) {
                                    dataGB = data.ads;
                                    var i;
                                    var dataGBLength = dataGB.length;

                                    if (dataGBLength > 0) {

                                        var newData = [];
                                        getCategories(dataGB);

                                        if (lisaSettings.useCacheForBrokers) {
                                            var imageResizer = new mno.utils.ImageResizer(lisaSettings.brokerProperties, lisaSettings.serviceUrl);
                                        }

                                        for (i = 0; i < dataGBLength; i++) {

                                            var url = commonData.landingUrl + dataGB[i].objectId;
                                            if (typeof(dataGB[i].url) === "string") {
                                                if (dataGB[i].url.length > 0) {
                                                    url = dataGB[i].url;
                                                }
                                            }
                                            if (/^https?|ftp:\/\//.test(url) === false) {
                                                url = 'http://' + url;
                                            }
                                            dataGB[i].url = url;

                                            if (dataGB[i].defaultImageUrl) {
                                                dataGB[i].defaultImageUrl = dataGB[i].defaultImageUrl.replace("_xl.", ".");
                                            }

                                            if (dataGB[i].defaultLogo !== null) {
                                                if (lisaSettings.useCacheForBrokers) {
                                                    // why is it returned without protocol?
                                                    var resizedImageUrl = imageResizer.getImage('http:' + dataGB[i].defaultLogo);
                                                    dataGB[i].defaultLogo = resizedImageUrl;
                                                }
                                            }

                                            if (dataGB[i].membership[0].id == categoryId) {
                                                newData.push(dataGB[i]);
                                            }

                                        }

                                        dataGB = newData;
                                        render();
                                    } else {
                                        $carousel.detach();
                                    }
                                } else {
                                    $carousel.detach();
                                }
                            } else {
                                $carousel.detach();
                            }
                        }

                        function getCategoryId() {
                            var max = categoriesList.length-1;
                            var r = Math.round(Math.random() * max);
                            categoryId = categoriesList[r > max ? max : r];
                        }

                        function getCategories(data) {
                            for (var i = 0; i < data.length; i++) {
                                if (categories[data[i].membership[0].id] === undefined) {
                                    categories[data[i].membership[0].id] = data[i].membership[0].name;
                                    categoriesList.push(data[i].membership[0].id);
                                }

                            }
                            getCategoryId();
                            renderCategories();
                        }

                        function renderCategories() {
                            if (categories.length > 0) {
                                var html = '';
                                var $container = $carousel.find('.categoryLinks');
                                for (var i in categories) {
                                    if (categories.hasOwnProperty(i)) {
                                        html += '<a href="' + model.carouselLinkToAds + '?realEstateCarouselId=' + model.carouselId + '&realEstateCategoryId=' + i + '">' + categories[i] + '</a><br />';
                                    }
                                }
                                $container.html(html);
                            }
                        }

                        function onError(e) {
                            if (dataGB !== undefined && dataGB.length) {

                            }
                            else {
                                $carousel.detach();
                            }
                        }

                        function render() {
                            sandbox.render('widgets.realEstateCarousel.views.verticalRealEstates', {
                                items: dataGB,
                                widgetIndex: widgetIndex,
                                landingUrl: commonData.landingUrl
                            }, function (html) {
                                $adList.html(html);

                                $adList.find('a.resultItemLink').each(function(index) {
                                    $(this).bind('click', function(event) {
                                        if (typeof _gaq !== 'undefined') {
                                            _gaq.push(['rEC._trackEvent', model.carouselId, model.sectionName.denationalize(), dataGB[index].objectId]);
                                        }
                                    });
                                });

                                if (lisaSettings.useCache) {
                                    var resizedImageUrl;
                                    var imageResizer = new mno.utils.ImageResizer(lisaSettings.properties, lisaSettings.serviceUrl);

                                    $adList.find('img.resultItemThumb').each(function(index) {
                                        resizedImageUrl = imageResizer.getImage(dataGB[index].defaultImageUrl);
                                        $(this).attr('src', resizedImageUrl);
                                    });
                                }
                            });
                        }

                        function gotError() {
                            mno.core.log(3, "An error has occurred, we're terribly sorry. Try again later.");
                        }
                    }
                );
            }
        }

        function destroy() {
            $carousel.detach();
        }

        return {
            init: init,
            destroy: destroy
        }
    }
});
/**
 * RealEstateList Widget Horizontal view
 *
 * @copyright Schibsted
 * @package mno.widgets
 * @subpackage realEstateList
 * @author michal.skinder@medianorge.no
 * @description
 * Horizontal view of randomized nonDHTML list of ads.
 *
 */

mno.core.register({
    id: 'widget.realEstateCarousel.overview',

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
                                'width': 350
                            },
                            brokerProperties: {
                                'width': 288,
                                'height': 27
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

                        var customListId = getURLParameter('realEstateCarouselId');
                        if (customListId !== null) {
                            model.carouselId = customListId;
                        }

                        categoryId = getURLParameter('realEstateCategoryId');

                        fetchAds();

                        function getURLParameter(name) {
                            return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g, '%20'))||null;
                        }

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

                            try {
                            sandbox.getScript({
                                url: url,
                                callbackVar: 'callback',
                                callbackName: 'reOverview' + widgetIndex,
                                jsonP: onAdsLoaded,
                                error: onError
                            });
                            } catch (e) {

                            }
                        }


                        function onAdsLoaded(data) {
                            if (data !== undefined) {
                                if (data.ads !== undefined) {
                                    dataGB = data.ads;
                                    var dataGBLength = dataGB.length;

                                    if (dataGBLength > 0) {
                                        var newData = [];
                                        getCategories(dataGB);

                                        if (lisaSettings.useCacheForBrokers) {
                                            var imageResizer = new mno.utils.ImageResizer(lisaSettings.brokerProperties, lisaSettings.serviceUrl);
                                        }

                                        var i;
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

                                            if (categoryId !== null) {
                                                if (dataGB[i].membership[0].id == categoryId) {
                                                    newData.push(dataGB[i]);
                                                }
                                            }
                                        }
                                        if (categoryId !== null) {
                                            dataGB = newData;
                                        }

                                        render();
                                    } else {
                                        noResults();
                                    }
                                } else {
                                    noResults();
                                }

                            } else {
                                noResults();
                            }
                        }

                        function noResults() {
                            $adList.html('<span class="error">Dessverre er det ikke noe resultat for ditt søk, sjekk søkekriterierne.</span>');
                        }

                        function getCategories(data) {
                            for (var i = 0; i < data.length; i++) {
                                if (categories[data[i].membership[0].id] === undefined) {
                                    categories[data[i].membership[0].id] = data[i].membership[0].name;
                                    categoriesList.push(data[i].membership[0].id);
                                }
                            }
                            renderCategories();
                        }

                        function renderCategories() {
                            if (categories.length > 0) {
                                if (categoryId) {
                                    var $header = $carousel.find('header h2');
                                    $header.html(categories[categoryId]);
                                    $header.parent().parent().show();
                                }
                            }
                        }

                        function onError(e) {
                            if (dataGB !== undefined && dataGB.length) {

                            } else {
                                $carousel.detach();
                            }
                        }

                        function render() {
                            sandbox.render('widgets.realEstateCarousel.views.tiledRealEstates', {
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
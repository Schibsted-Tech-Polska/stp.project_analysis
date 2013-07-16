/**
 * classifiedBox Widget common library
 *
 * @copyright Schibsted
 * @package mno.widgets
 * @subpackage classifiedBox/common.js
 * @author michal.skinder@medianorge.no
 * @description
 * Library to do common and shared stuff for the box.
 *
 */

mno.core.register({
    id: 'widget.classifiedBox.common',

    creator: function (sandbox) {

        // default parameters if something in Escenic is broken
        var defaults = {
            publication:                sandbox.publication.name,
            serviceUrl:                 'http://ocacache.medianorge.no/oca/s/v1/getList/',
            channel:                    'default',
            tracker:                    'rEC',
            itemsPerPage:               4,
            itemsMax:                   20,
            listMagnifier:              'hover',        // none|hover|click
            listHoverDelay:             1,
            skinColor:                  'default',
            carouselLinkToItems:        null,
            carouselLinkToItemsName:    'Vis alle boliger',
            exitUrl:                    'direct',       // direct|landing
            categoriesStructure:        'all',          // all|merged|none
            categoriesLabel:            'show',         // show|hide
            categoriesDisplay:          'tabs',         // tabs|links|dropdown|none
            categoriesClick:            'redirect',     // redirect|refresh
            priceDisplay:               'default',      // default|badge
            parameterCarouselId:        'classifiedBoxCarouselId',
            parameterCategoryId:        'classifiedBoxCategoryId',
            page:                       1
        };


        /**
         * method helper
         *
         * @access public
         * @param [Object] sandbox
         * @param [String] widgetIndex
         * @param [callback] onReady executed when data is received
         * @return [Object] all processed data
         * @desc does the stuff for child view
         */
        function helper(sandbox, widgetIndex, onReady) {
            // create config object
            var config = new Configuration(sandbox.model[widgetIndex]);
            var output;
            // widget-view unique callback name
            var callback = 'cb' + config.view + widgetIndex;

            // prepare lisa settings
            var lisa = {
                cache: config.lisaLevel,
                dimensions: {
                    ap: {
                        overview: {logo: {width: 288, height: 27}, photo: {width: 350, height: null}},
                        vertical: {logo: {width: 180, height: 17}, photo: {width: 120, height: null}},
                        horizontal: {logo: {width: 350, height: 33}, photo: {width: 350, height: null}}
                    },
                    bt: {
                        overview: {logo: {width: null, height: 25}, photo: {width: null, height: 205}},
                        vertical: {logo: {width: null, height: 17}, photo: {width: 200, height: 125}
                        },
                        horizontal: {logo: {width: null, height: 25}, photo: {width: 350, height: null}}
                    }
                },
                service: 'http://' + config.lisaLevel + '.' + sandbox.publication.name + '/utils/img.php'
            };

            // check for URL params
            var customListId = getURLParameter(defaults.parameterCarouselId);
            if (customListId !== null) {
                config.carouselId = customListId;
            }

            // check for page, just for overview purposes
            var page = getURLParameter('page');
            if (page !== null) {
                config.page = page;
            }

            // fetch and process ads
            getData(function (output) {
                categoryId = getURLParameter(defaults.parameterCategoryId);
                if (categoryId !== null) {
                    config.categoryId = categoryId;
                } else {
                    // if not present, pick a random category
                    var max = output.categoriesIds.length - 1;
                    var r = Math.round(Math.random() * max);
                    config.randomCategoryId = output.categoriesIds[r > max ? max : r];
                }
                if (typeof (onReady) === "function") {
                    onReady(
                        output,
                        new Shared()
                    );
                }
            });

            /**
             * method getURLParameter
             *
             * @access private
             * @param [String] name of expected GET parameter
             * @return [String] value of expected GET parameter
             * @desc method returns value of a GET parameter or null
             */
            function getURLParameter(name) {
                return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search) || [, ""])[1].replace(/\+/g, '%20')) || null;
            }// end of method getURLParameter

            /**
             * method getData
             *
             * @access private
             * @desc fetches ads from the server through JSONP, callback onAdsLoaded is fired afterwards
             */
            function getData(onReady) {
                var url = config.serviceUrl,
                    key,
                    data = {
                        publicationId: sandbox.publication.name,
                        channelId: config.channel,
                        carouselId: config.carouselId,
                        maxAds: config.itemsMax
                    },
                    parameters = [];

                for (var key in data) {
                    if (data.hasOwnProperty(key)) {
                        parameters.push(data[key]);
                    }
                }
                url += parameters.join('/') + ".jsonp?full=true";

                try {
                    sandbox.getScript({
                        url: url,
                        callbackVar: 'callback',
                        callbackName: callback,
                        jsonP: onAdsLoaded(onReady),
                        error: onAdsLoadingFailed
                    });
                } catch (Exception) {
                    // something here maybe?
                }
            }// end of method getAds

            /**
             * method onAdsLoaded generates a success callback
             *
             * @access private
             * @param [Array] array of ads from a group
             * @return [Array] array of fetched and processed ads (ImageResizer, URLs, etc.)
             * @desc processes raw ads
             */
            function onAdsLoaded(callback) { return function (data) {
                // elses should raise some error/detach something
                if (data !== undefined) {
                    if (data.adListContainer !== undefined) {
                        if (data.adListContainer.ads !== undefined) {
                            var ads = data.adListContainer.ads;

                            if (ads.length > 0) {
                                var categoryId,
                                    categories = {},
                                    categoriesIds = [],
                                    i;

                                categories['all'] = {ads: []};

                                for (i = 0; i < ads.length; i++) {

                                    categoryId = ads[i].membership[0].id;
                                    if (categories[categoryId] === undefined) {
                                        categoriesIds.push(categoryId);

                                        categories[categoryId] = {
                                            name: ads[i].membership[0].name,
                                            ads: []
                                        };
                                    }
                                    categories[categoryId].ads.push(new Item(ads[i]));
                                    categories['all'].ads.push(new Item(ads[i]));

                                }

                                output = {
                                    categories: categories,
                                    categoriesIds: categoriesIds,
                                    config: config
                                };
                                callback(output);
                            }
                        }
                    }

                }
            }}//end of method onAdsLoaded


            /**
             * method
             * @param Exception
             */
            function onAdsLoadingFailed(Exception) {
                //here be demons, like invoke destroy maybe?
            }



            function preparePicture(picture, width, height) {
                if (picture !== null) {
                    if (lisa.cache !== null) {
                        var resizer = new mno.utils.ImageResizer({
                            width: width,
                            height: height
                        }, 'http://' + config.lisaLevel + '.aftenposten.no/utils/img.php');
                        return resizer.getImage(picture);
                    }
                }
                return null;
            }

            function Item(data) {
                this.type = data.typeName || 'realEstate';

                if (config.type === null) {
                    config.type = this.type;
                }


                switch (this.type) {
                case 'realEstate':
                    this.id = data.objectId;
                    this.title = data.title;

                    var id;
                    if (config.exitUrl === 'direct') {
                        id = data.objectId;
                    } else {
                        id = data.id;
                    }
                    this.url = typeof data.url === 'string' ? data.url : config.landingUrl + id;
                    this.price = data.price;
                    this.heading = data.heading;
                    this.organisation = data.organisation !== undefined ? data.organisation : null;
                    this.photo = preparePicture(
                        data.defaultImageUrl.replace("_xl.", "."),
                        lisa.dimensions[config.publication][config.view].photo.width,
                        lisa.dimensions[config.publication][config.view].photo.height
                    );
                    if (data.defaultLogo !== null) {
                        this.logo = preparePicture(
                            'http:' + data.defaultLogo,
                            lisa.dimensions[config.publication][config.view].logo.width,
                            lisa.dimensions[config.publication][config.view].logo.height
                        );
                        this.logo = this.logo.replace('//ocacache.', '//oca.');
                        if (this.logo === 'http://') {
                            this.logo = null;
                        }
                    } else {
                        this.logo = null;
                    }
                    break;
                }

                if (data['propertyLinks'] !== undefined) {
                    var i;
                    this.properties = {};
                    for (var i in data['propertyLinks']) {
                        if (data['propertyLinks'].hasOwnProperty(i)) {
                            this.properties[data['propertyLinks'][i].property.name] = data['propertyLinks'][i].value;
                        }
                    }
                }

            }

            function Shared() {

                this.CLICK = 1;

                this.VIEW = 2;


                this.overviewUrl = config.carouselLinkToItems;
                if (config.carouselLinkToItems.indexOf('?') !== -1) {
                    this.overviewUrl += '&';
                } else {
                    this.overviewUrl += '?';
                }
                this.overviewUrl += config.parameterCarouselId + '=' + config.carouselId + '&' + config.parameterCategoryId + '=';

                this.renderCategories = function (type, data, callback) {
                    if ($(data).length > 0) {
                        if (config.categoriesStructure !== 'none') {
                            if (config.categoriesDisplay !== 'none') {

                                var show = config.categoriesLabel == 'show' ? true : false;

                                sandbox.render('widgets.classifiedBox.views.shared.' + type, {
                                    url: this.overviewUrl,
                                    categories: data,
                                    show: show,
                                    config: config
                                }, function (html) {
                                    callback(html);
                                });
                            }
                        }
                    }
                };

                this.setSelectedCategory = function (params) {
                    if (params.type === 'dropdown') {
                        var selecteds = 0;
                        params.container.find('option').each(function (index) {
                            // has to be weak type check, because param from URL is string, param from option is integer
                            if ($(this).val() == params.selected) {
                                params.container.find('select').val( $(this).val() );
                                selecteds++;
                            }
                        });

                        if (selecteds === 0) {
                            params.container.find('select').val('all');
                        }

                    } else if (params.type === 'links' || params.type === 'tabs') {
                        params.container.find('a').each(function (index) {
                            if ($(this).attr('categoryId') == params.selected) {
                                $(this).parent().addClass('selected');
                            } else {
                                $(this).parent().removeClass('selected');
                            }
                        });
                    }
                };

                this.bindTrackEvent = function (id, trackType) {
                    if (typeof _gaq !== 'undefined') {
                        _gaq.push([ config.tracker + '._trackEvent', config.carouselId, config.sectionName.denationalize(), id + '-' + trackType]);
                    }
                };

                this.bindCategoriesEvents = function (container, callback) {
                    var parent = this;

                    if (config.categoriesClick === 'redirect') {
                        if (config.categoriesDisplay === 'dropdown') {
                            $(container).find('select').on('change', function (event) {
                                event.preventDefault();

                                var url;
                                if (!!parent.overviewUrl.match(/^https?:\/\//)) {
                                    url = parent.overviewUrl + $(this).val();
                                } else {
                                    url = location.protocol + '//' + document.domain + parent.overviewUrl + $(this).val();
                                }
                                window.location.replace(url);

                            });
                        }
                    } else if (config.categoriesClick === 'refresh') {
                        if (config.categoriesDisplay === 'dropdown') {
                            $(container).find('select').on('change', function (event) {
                                event.preventDefault();

                                callback(parent.getAdsFromCategory(
                                    $(this).val()
                                ));
                            });
                        } else if (config.categoriesDisplay === 'tabs' || config.categoriesDisplay === 'links') {

                            container.find('a').on('click', function (event) {
                                event.preventDefault();

                                if ($(this).parent().hasClass('selected')) {
                                    return false;
                                }

                                container.find('a').each(function (index) {
                                    $(this).parent().removeClass('selected');
                                });

                                $(this).parent().addClass('selected');
                                callback(parent.getAdsFromCategory(
                                    $(this).attr('categoryId')
                                ));
                            });
                        }
                    }
                };

                this.filterAdsByCategory = function () {

                    // haxor for BT
                    if (config.view === 'horizontal' && config.publication === 'bt') {
                        config.currentCategoryId = 'all';
                    } else {
                        if (config.randomCategoryId !== null) {
                            config.currentCategoryId = config.randomCategoryId;
                        } else {
                            config.currentCategoryId = config.categoryId;
                        }
                    }

                    return {
                        category: output.categories[config.currentCategoryId],
                        categoryId: config.currentCategoryId
                    };

                };

                this.getAdsFromCategory = function (categoryId) {
                    return output.categories[categoryId];
                };
            }

            function Configuration(model) {
                this.publication                    = defaults.publication;
                this.channel                        = model.channelId || defaults.channel;
                this.tracker                        = defaults.tracker;
                this.lisaLevel                      = model.lisaLevel || null;
                this.priceDisplay                   = model.priceDisplay || defaults.priceDisplay;
                this.serviceUrl                     = model.serviceUrl || defaults.serviceUrl;
                this.landingUrl                     = model.landingUrl || null;
                this.carouselId                     = model.carouselId || null;
                this.categoryId                     = null;
                this.randomCategoryId               = null;
                this.currentCategoryId              = null;
                this.itemsPerPage                   = model.itemsPerPage || defaults.itemsPerPage;
                this.itemsMax                       = model.itemsMax || defaults.itemsMax;
                this.listMagnifier                  = model.listMagnifier || defaults.listMagnifier;
                this.listHoverDelay                 = model.listHoverDelay || defaults.listHoverDelay;
                this.skinColor                      = model.skinColor || defaults.skinColor;
                this.capabilitiesModelName          = model.capabilitiesModelName;
                this.carouselLinkToItems            = model.carouselLinkToItems || defaults.carouselLinkToItems;
                this.carouselLinkToItemsName        = model.carouselLinkToItemsName;
                this.exitUrl                        = model.exitUrl || defaults.exitUrl;
                this.categoriesStructure            = model.categoriesStructure || defaults.categoriesStructure;
                this.categoriesLabel                = model.categoriesLabel || defaults.categoriesLabel;
                this.categoriesDisplay              = model.categoriesDisplay || defaults.categoriesDisplay;
                this.categoriesClick                = model.categoriesClick || defaults.categoriesClick;
                this.view                           = model.view;
                this.sectionName                    = model.sectionName.denationalize();
                this.parameterCarouselId            = defaults.parameterCarouselId;
                this.parameterCategoryId            = defaults.parameterCategoryId;
                this.type                           = null;
                this.page                           = defaults.page;
            }

            return true; // all went well. Well, we can't return anything better.
        }//end of method helper

        /**
         * method init
         *
         * @access public
         */
        function init() {
            // this isn't even called by child
        }//end of method init

        /**
         * method destroy
         *
         * @access public
         */
        function destroy() {
            // nothing to do here
        }//end of method destroy

        return {
            init: init,
            helper: helper,
            destroy: destroy
        };
    }
});
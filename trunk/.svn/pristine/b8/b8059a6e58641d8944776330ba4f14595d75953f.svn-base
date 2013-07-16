mno.core.register({
    id:'widget.realEstateCarousel.default',
    creator:function (sandbox) {
        // this object is shared between instances,
        // so we can prepare (cache) some data here
        var commonData = {
            publication:sandbox.publication.name,
            serviceUrl:"http://ocacache.medianorge.no/oca/s/v1/getList/",
            landingUrl:"http://www.finn.no/"
        };

        function init() {
            if (sandbox.container) {
                // loop through instances of the widget
                sandbox.container.each(function (widgetIndex, element) {
                    // assign locally a model variable for the current instance
                    var model = sandbox.model[widgetIndex];
                    /* cached object references: */
                    var $carousel = $(element);
                    var $carouselHolder = $carousel.find('.carouselHolder');
                    var $adList = $carousel.find('.adList');
                    var adsList = [];
                    var firstItem = 0;
                    var imgRefs = [];
                    var logoRefs = [];
                    var listDelayTimer;
                    var $zoomed = $("<div />").css('display', 'none');
                    var zoomedIndex = 0;
                    var listScroller = null;

                    var lisaSettings = {
                        useCache:true,
                        useCacheForBrokers:true,
                        properties:{
                            'width':350
                        },
                        brokerProperties:{
                            'width':350,
                            'height':33
                        },
                        serviceUrl:'http://' + model.lisaLevel + '.aftenposten.no/utils/img.php'
                    };

                    if (model.lisaLevel !== '') {
                        lisaSettings.useCache = true;
                        lisaSettings.useCacheForBrokers = true;
                    }

                    var categories = [];
                    var categoriesList = [];
                    var categoryId;

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

                    $carousel.addClass('itemsCount_' + model.adsPerPage);
                    $carousel.append($zoomed);

                    $zoomed.bind('mouseleave', function () {
                        if (listDelayTimer) {
                            clearTimeout(listDelayTimer);
                            listDelayTimer = null;
                        }
                        zoomOut(this);
                    });

                    // attach the events:
                    $carousel.find('.listScrollLeft').click(clickPrev);
                    $carousel.find('.listScrollRight').click(clickNext);

                    //--TODO: show that we're "loading..."--
                    // well, we made it invisible until it loads...
                    fetchAds();

                    // private instance-aware methods:
                    function fetchAds() {
                        var url = commonData.serviceUrl;
                        var data = {
                            publicationId:commonData.publication,
                            channelId:model.channel,
                            carouselId:model.carouselId,
                            maxAds:model.adsMax
                        };
                        var data_array = [];
                        for (var key in data) {
                            data_array.push(/*key + '=' + */data[key]);
                        }
                        url += /*'?' + */data_array.join('/');

                        sandbox.getScript({
                            url:url,
                            callbackVar:'callback',
                            callbackName:'reCarousel' + widgetIndex,
                            jsonP:onAdsLoaded,
                            error:onError
                        });
                    }

                    /**
                     * Triggered on JSON load
                     * @param data JSON data :)
                     */
                    function onAdsLoaded(data) {
                        if (data !== undefined) {
                            if (data.ads !== undefined) {
                                adsList = data.ads;

                                if (adsList.length > 0) {

                                    var adsFiltered = [];
                                    filterByCategories(adsList);

                                    // for now we overwrite model with this config from the server, which should make it safe to remove it from model
                                    if (typeof(data.configuration) !== 'undefined') {
                                        if (typeof(data.configuration.DELAY) !== 'undefined') {
                                            model.listHoverDelay = parseFloat(data.configuration.DELAY);
                                        }
                                        if (typeof(data.configuration.COLOR) !== 'undefined') {
                                            model.skinColor = data.configuration.COLOR.toLowerCase() + "Theme";
                                        }
                                    }

                                    if (model.skinColor !== undefined && model.skinColor !== 'default') {
                                        $carousel.addClass(model.skinColor);
                                    }

                                    if (lisaSettings.useCacheForBrokers) {
                                        var logoResizer = new mno.utils.ImageResizer(lisaSettings.brokerProperties, lisaSettings.serviceUrl);
                                    }
                                    if (lisaSettings.useCache) {
                                        var imageResizer = new mno.utils.ImageResizer(lisaSettings.properties, lisaSettings.serviceUrl);
                                    }

                                    for (var i = 0; i < adsList.length; i++) {
                                        if ("undefined" !== typeof adsList[i].propertyLinks && null !== adsList[i].propertyLinks) {
                                            var propertyLinks = adsList[i].propertyLinks;
                                            adsList[i]['properties'] = {};
                                            for (var j = 0; j < propertyLinks.length; j++) {
                                                adsList[i]['properties'][propertyLinks[j].property.name] = propertyLinks[j].aNode || propertyLinks[j].value;
                                            }

                                        }

                                        if (adsList[i].defaultLogo !== null) {
                                            if (lisaSettings.useCacheForBrokers) {
                                                var resizedImageUrl = logoResizer.getImage('http:' + adsList[i].defaultLogo);
                                                adsList[i].defaultLogo = resizedImageUrl.replace('//ocacache.', '//oca.');
                                            }
                                        }
                                        if (adsList[i].defaultImageUrl !== null) {
                                            if (lisaSettings.useCache) {
                                                var resizedImageUrl = imageResizer.getImage(adsList[i].defaultImageUrl);
                                                adsList[i].defaultImageUrl = resizedImageUrl;
                                            }
                                        }

                                        if (adsList[i].membership[0].id == categoryId) {
                                            adsFiltered.push(adsList[i]);
                                        }
                                    }

                                    render(adsFiltered, update);
                                    adsList = adsFiltered;
                                    $carousel.css('visibility', 'visible');  // now that the carousel is set up and can be displayed can eventually show it
                                    $carousel.find('.themeHeadline').css('visibility', 'visible');
                                } else {
                                    $carousel.detach();
                                }
                            } else {
                                $carousel.detach();
                            }

                        } else {
                            $carousel.detach();
                            mno.core.debug("CAROUSEL ERROR: No ads received from the server");
                        }
                    }

                    /**
                     * @return a valid and random index in the category list
                     */
                    function getRandomCategoryIdx() {
                        var max = categoriesList.length-1;
                        var r = Math.round(Math.random() * max);
                        return r > max ? max : r;
                    }


                    function setCategoryId(idx) {
                        if (typeof(idx) !== "number") {
                            idx = getRandomCategoryIdx();
                        }
                        categoryId = categoriesList[idx];
                    }

                    function filterByCategories(data) {
                        for (var i = 0; i < data.length; i++) {
                            if (categories[data[i].membership[0].id] === undefined) {
                                categories[data[i].membership[0].id] = data[i].membership[0].name;
                                categoriesList.push(data[i].membership[0].id);
                            }

                        }
                        setCategoryId();
                        renderCategories();
                    }

                    function renderCategories() {
                        if (categories.length > 0) {
                            var html = '';
                            var $container = $carousel.find('ul.categories');
                            for (var i in categories) {
                                if (categories.hasOwnProperty(i)) {
                                    html += '<li ';
                                    if (i == categoryId) {
                                        html += ' class="selected" ';
                                    }
                                    html += '><a href="' + model.carouselLinkToAds + '?realEstateCarouselId=' + model.carouselId + '&realEstateCategoryId=' + i + '">' + categories[i] + '</a></li>';
                                }
                            }
                            $container.html(html);

                            /*
                            var $carouselLink = $carousel.find('.carouselLink');
                            var href = $carouselLink.attr('href');
                            href += '&realEstateCategoryId=' + categoryId;
                            $carouselLink.attr('href', href);
                            */
                        }
                    }

                    /**
                     * Triggered if JSON fails
                     */
                    function onError(e) {
                        if (adsList !== undefined && adsList.length) {
                            /* this is a bug in the error handling, nothing really happened */
                        }
                        else {
                            $carousel.detach();
                        }
                    }

                    /**
                     * Get single ad landing page URL
                     * @param ad The desired ad's object
                     */
                    function getAdLink(ad) {

                        var url;

                        url = commonData.landingUrl + ad.objectId;
                        if (typeof(ad.url) === "string") {
                            if (ad.url.length > 0) {
                                url = ad.url;
                            }
                        }

                        if (/^https?|ftp:\/\//.test(url) === false) {
                            url = 'http://' + url;
                        }

                        return url;
                    }

                    /**
                     * Get single ad landing page URL
                     * @param adIndex The desired ad's index in the carousel
                     */
                    function getAdLinkByIndex(adIndex) {
                        var ad = adsList[adIndex];
                        return getAdLink(ad);
                    }

                    /**
                     * switch to the next N ads (all preloading and animation starts here)
                     */
                    function showNext(delta) {
                        firstItem = (isZoomVisible())
                            ? firstItem + delta
                            : Math.min(firstItem + delta, adsList.length - model.adsPerPage);
                        zoomedIndex = Math.min(zoomedIndex + delta, adsList.length - 1);
                        update(true);
                    }

                    /**
                     * switch to the previous N ads (all preloading and animation starts here)
                     */
                    function showPrev(delta) {
                        firstItem = (isZoomVisible())
                            ? firstItem - delta
                            : Math.max(firstItem - delta, 0);
                        zoomedIndex = Math.max(zoomedIndex - delta, 0);
                        update(true);
                    }

                    /**
                     * handle right/next arrow click (both zoomed and carousel)
                     * @param event
                     */
                    function clickNext(event) {
                        event.preventDefault();
                        if (zoomedIndex == adsList.length) {
                            return;
                        }
                        var $target = $(event.currentTarget);
                        var delta = ($target.is(".listScrollSingle")) ? 1 : model.adsPerPage;
                        showNext(delta);
                    }

                    /**
                     * handle left/previous arrow click (both zoomed and carousel)
                     * @param event
                     */
                    function clickPrev(event) {
                        event.preventDefault();
                        if (zoomedIndex == 0) {
                            return;
                        }
                        var $target = $(event.currentTarget);
                        var delta = ($target.is(".listScrollSingle")) ? 1 : model.adsPerPage;
                        showPrev(delta);
                    }


                    /**
                     * get current page count (how many ad pages do we have)
                     * @return number of pages available
                     */
                    function getPageCount() {
                        return Math.ceil(adsList.length / model.adsPerPage);
                    }


                    /**
                     * Get the object for the destination style of .adWrap after zooming in
                     * @returns Object ready to get passed to .css or .animate
                     */
                    function zoomedAdWrapStyle() {
                        return {
                            paddingLeft:'31px',
                            paddingTop:'5px',
                            paddingBottom:'5px',
                            paddingRight:'31px',
                            borderRadius:'3px',
                            width:'360px',
                            left:'-116px', /* or -61, or -181 */
                            top:'-30px',
                            height:'260px'
                        }
                    }

                    /**
                     * Get the object for the destination style of .adInner after zooming in
                     * @returns Object ready to get passed to .css or .animate
                     */
                    function zoomedAdInnerStyle() {
                        return {
                            borderTopWidth:'5px',
                            borderRightWidth:'5px',
                            borderBottomWidth:'5px',
                            borderLeftWidth:'5px',
                            width:'350px',
                            height:'250px',
                            opacity:1
                        }
                    }


                    /**
                     * Initiate the zoomed-in gallery-like viewer for an ad
                     * @param index Which of the ads should be zoomed in?
                     */
                    function zoomIn(index) {
                        var item = $adList.children().get(index);
                        if (!item) {
                            /* if we're here, something went very wrong */
                            return;
                        }

                        /* before we replace the zoomed div contents, let's check if it has anything that we'd like to preserve */

                        var wrapperStyle = {};
                        var innerStyle = {};

                        zoomedIndex = index;
                        $zoomed.html($(item).html());

                        var $item = $zoomed.find('.adWrap');

                        $item.prepend('<a class="listScrollSingle listScrollLeft listNav"><span></span></a>');
                        $item.append('<a class="listScrollSingle listScrollRight listNav"><span></span></a>');

                        var gaDataId = $item.find('.adInner').attr('ga-data-id');
                        $item.find('.adInner').attr('id', gaDataId);

                        $item.find('.adInner').click(getClickHandler(index));

                        if (isZoomVisible()) {
                            var innerStyle = zoomedAdInnerStyle();
                            innerStyle['opacity'] = 0;
                            $item.css(zoomedAdWrapStyle());
                            $item.find('.adInner').css(innerStyle);
                        }
                        else {
                            /* hackidy hack */
                            var itemOffset = $(item).offset();
                            var zoomedOffset = $zoomed.parent().offset();
                            var zoomedLeft = itemOffset.left - zoomedOffset.left
                                // but, if we use hardware acceleration, position stays the same...
                                // and we have a jQuery/Webkit bug: http://bugs.jquery.com/ticket/8362
                                // so we do additional calc only for non-webkits
                                + ((canHardwareAccelerate() !== false && (!jQuery.browser.webkit)) ? getHorizontalOffset() : 0);
                            var zoomedTop = itemOffset.top - zoomedOffset.top;
                            $zoomed.css({
                                position:"absolute",
                                left:zoomedLeft,
                                top:zoomedTop,
                                display:"block"
                            }).animate({
                                    opacity:1
                                })
                        }

                        $item.find('.listScrollLeft').click(clickPrev);
                        $item.find('.listScrollRight').click(clickNext);

                        $item.addClass('zoom');

                        $item.stop(true, true).animate(zoomedAdWrapStyle(), 500);

                        $item.children('.adInner').stop(true, true).animate(zoomedAdInnerStyle(), 500);

                        $item.children('.adInner').children('.listPrice').stop(true, true).animate({
                            fontSize:'15px',
                            height:'30px',
                            lineHeight:'30px'
                        }, 500);

                        $item.children('.adInner').children('.adOrganization').children('img').stop(true, true).animate({
                            width:'350px'
                        }, 500);


                        var $arrow = $zoomed.find('.listScrollLeft');
                        if (zoomedIndex < 1) {
                            // disable the arrow
                            $arrow
                                .addClass('disabled')
                                .unbind('click');
                        } else {
                            $arrow.removeClass('disabled');
                        }

                        var $arrow = $zoomed.find('.listScrollRight');
                        if (zoomedIndex >= adsList.length - 1) {
                            // disable the arrow
                            $arrow
                                .addClass('disabled')
                                .unbind('click');
                        } else {
                            $arrow.removeClass('disabled');
                        }
                    }

                    /**
                     * Hide the magnified view
                     */
                    function zoomOut() {
                        var $item = $zoomed.find('.adWrap');
                        $item.removeClass('zoom');

                        $item.stop(true, true).animate({
                            paddingLeft:'0px',
                            paddingTop:'0px',
                            paddingBottom:'0px',
                            paddingRight:'0px',
                            borderRadius:'0px',
                            height:'208px',
                            left:'0px',
                            top:'0px',
                            width:'210px'
                        }, 250);

                        $item.children('.adInner').stop(true, true).animate({
                                borderTopWidth:'1px',
                                borderRightWidth:'1px',
                                borderBottomWidth:'1px',
                                borderLeftWidth:'1px',
                                height:'208px',
                                width:'210px'
                            }, 250,
                            function () {
                                $zoomed.css('display', 'none');
                            });

                        $item.find('.adInner .listPrice')
                            .stop(true, true)
                            .css('display', 'block')
                            .animate({
                                fontSize:'12px',
                                height:'24px',
                                lineHeight:'24px'
                            }, 250);

                        $item.find('.adInner .adOrganization img').stop(true, true).animate({
                            width:'210px'
                        }, 250);

                        var oldFirst = firstItem;
                        firstItem =
                            Math.max(0, Math.min(firstItem, adsList.length - model.adsPerPage));
                        if (oldFirst != firstItem) {
                            update();
                        }
                    }

                    /**
                     * Preload images for a particular ad (prepare the ad for displaying)
                     * @param index which one (index in the overall array)
                     */

                    function prefetchAd(index) {
                        // lazy-load images for the selected ad if lazyload plugin fails
                        imgRefs.eq(index).attr('src', adsList[index].defaultImageUrl);
                        logoRefs.eq(index).attr('src', adsList[index].defaultLogo);
                    }

                    /**
                     * Generate a click handler function for n-th image
                     * @param index which ad is it.
                     */
                    function getClickHandler(index) {
                        return function () {
                            if (typeof _gaq !== "undefined") {
                                _gaq.push(['rEC._trackEvent', model.carouselId, model.sectionName.denationalize(), adsList[index].objectId]);
                                mno.core.log(1, "Sent 'RE carousel ad click' event to Google Analytics with ID: " + adsList[index].objectId);
                            } else {
                                mno.core.log(2, "Google Analytics object not found");
                            }
                            window.open(getAdLinkByIndex(index), "_blank");
                        }
                    }

                    /**
                     * Get a single page (eg. 5 ads), build its DOM, wait for it to load* and notify
                     * @param options.pageNo which page should we render?
                     * @param options.onDone function(jqDiv) Will get executed when the div is ready to be injected,
                     * with the div build as the parameter
                     */
                    function prefetchPage(options) {
                        var newDiv = $('<div/>');
                        var idxFrom = Math.max(0, firstItem);
                        var idxTo = Math.min(idxFrom + model.adsPerPage, adsList.length);

                        for (var i = idxFrom; i < idxTo; i++) {
                            prefetchAd(i);
                        }
                        try {
                            if (options !== undefined && options != null && typeof options.onDone === 'function') {
                                options.onDone(newDiv);
                            } else {
                                mno.core.debug("CAROUSEL: page preloaded, but invalid callback received");
                            }
                        } catch (e) {

                        }
                    }


                    /**
                     * Tells if we support hovers and clicks, or maybe touch only
                     */
                    function isTouchOnly() {
                        return (mno.features.touch === true);
                    }


                    /**
                     * Rebuild widget's displayed content. Creates the HTML, attaches events
                     * for scrolling, clicks, hovers and stuff.
                     * @param dataToDisplay Object ads to show (filtered, pre-processed, whatever)
                     * @param callback Function to execute after everything is done
                     */
                    function render(dataToDisplay, callback) {
                        // rebuild the DOM tree.

                        sandbox.render('widgets.realEstateCarousel.views.adTile', {ads:dataToDisplay, widgetIndex:widgetIndex}, function (html) {
                            $adList.html(html);
                            $adList.find('img.lazy').lazyload({ threshold:200 });
                            // fix ul size
                            $adList.css({ width:getItemWidth() * dataToDisplay.length });

                            // attach events
                            $adList.find('.listScrollLeft').click(clickPrev);
                            $adList.find('.listScrollRight').click(clickNext);

                            imgRefs = $adList.find('img.adThumb');
                            logoRefs = $adList.find('img.adLogo');

                            // setting list wrapper width
                            var $listWrapper = $carousel.find('.headlineWrap');
                            $listWrapper.children('.categoriesList').css('width', $listWrapper.width() - 60);

                            // calculating category list width for iScroll
                            var addWidth = 0;
                            var $categoryList = $carousel.find('.categories');
                            var parseIntSafely = function (maybeInt) {
                                var val = parseInt(maybeInt);
                                return (isNaN(val)) ? 0 : val;
                            };
                            $categoryList.children('li').each(function () {
                                addWidth += ($(this).width() + 5)
                                    + parseIntSafely($(this).css('borderRightWidth'))
                                    + parseIntSafely($(this).css('borderLeftWidth'))
                                    + parseIntSafely($(this).css('paddingRight'))
                                    + parseIntSafely($(this).css('paddingLeft'))
                                    + parseIntSafely($(this).css('marginRight'))
                                    + parseIntSafely($(this).css('marginLeft'));
                            });
                            $categoryList.css('width', addWidth);


                            // iScroll feature binding for category list
                            var $categListContainer = $carousel.find('.categoriesList');

                            if ($categListContainer.length > 0) {

                                // check if list of categories is wider than outer element - if so then create arrows for left/right navigation
                                var categoryListWidth = $categoryList.width();
                                var categListContainerWidth = $categListContainer.width();
                                if (categListContainerWidth < categoryListWidth) {
                                    try {
                                        var $leftScroll = $('<a class="scrollLeft" href="#">&#9664;</a>');
                                        $leftScroll.css({opacity:'0', visibility:'hidden'});
                                        $listWrapper.prepend($leftScroll);
                                        $listWrapper.append('<a class="scrollRight" href="#">&#9654;</a>');

                                        var scrollPosition = 0;
                                        var lastItemIndex = $categoryList.children('li').length - 1;

                                        // dynamic scroll time for "from 1st to last" element scrolling
                                        // var scrollTime = Math.round($categoryList.children('li').length*(categoryListWidth*2/categListContainerWidth)*200);

                                        var scrollTime = 500;

                                        $arrLeft = $listWrapper.children(".scrollLeft");
                                        $arrRight = $listWrapper.children(".scrollRight");
                                        var hideShowArrows = function () {
                                            var l = (this.x < -4);
                                            var r = (this.x > (this.maxScrollX + 6));
                                            $arrLeft.stop(true, true).css({ visibility:'visible' }).animate({opacity:(l ? 1 : 0)}, 500, function () {
                                                $arrLeft.css({visibility:(l ? 'visible' : 'hidden')});
                                            });
                                            $arrRight.stop(true, true).css({ visibility:'visible' }).animate({opacity:(r ? 1 : 0)}, 500, function () {
                                                $arrRight.css({visibility:(r ? 'visible' : 'hidden')});
                                            });
                                        };

                                        var categoryScroll = new iScroll($categListContainer.get(0), {
                                            vScroll:false,
                                            snap:'li',
                                            hScrollbar:false,
                                            onScrollStart:hideShowArrows,
                                            onScrollEnd:hideShowArrows
                                        });
                                        $categListContainer.on("mouseup touchend", function (e) {
                                            if (categoryScroll.moved) {
                                                // "disable next click event" trick provided by Marek
                                                $categListContainer.one("click", function (e) {
                                                    e.preventDefault();
                                                });
                                            }
                                        });

                                        $arrLeft.click(function (event) {
                                            event.preventDefault();
                                            categoryScroll.scrollToPage(categoryScroll.currPageX - 1, 0, scrollTime);
                                            scrollPosition = 0;
                                        });
                                        $arrRight.click(function (event) {
                                            event.preventDefault();
                                            categoryScroll.scrollToPage(categoryScroll.currPageX + 1, 0, scrollTime);
                                            scrollPosition = lastItemIndex;
                                        });

                                        //scroll to selected category element
                                        categoryScroll.scrollToElement('li.selected', scrollTime);
                                        $categoryList.css('position', 'relative');

                                    } catch (e) {
                                        mno.core.log(2, "realEstate carousel category scroll init failed");
                                    }
                                }
                            }

                            // forget zooming, touch support requires different behavior
                            if (isTouchOnly()) {
                                $adList.wrap('<div class="listHolder" />');
                                listScroller = new iScroll($carousel.find('.listHolder').get(0), {
                                    snap:"li",
                                    vScroll:false
                                });

                                $carousel.find('.adInner').each(function (i, el) {
                                    $(el).click(getClickHandler(i));
                                });

                            } else {
                                // mouse hover instant zoom effect
                                if (model.listMagnifier === 'hover') {
                                    $carousel.find('.adWrap').hover(function (event) {
                                        var that = this;
                                        listDelayTimer = setTimeout(function () {
                                            var index = $adList.children().index($(that).closest('li'));
                                            zoomIn(index);
                                        }, (model.listHoverDelay) * 1000);
                                    }, function (e) {
                                        if (listDelayTimer) {
                                            clearTimeout(listDelayTimer);
                                            listDelayTimer = null;
                                        }
                                    });
                                } else if (model.listMagnifier == 'click') {
                                    $carousel.find('.adWrap').click(function (event) {
                                        var index = $adList.children().index($(this).closest('li'));
                                        zoomIn(index);
                                    });
                                }
                            }
                            prefetchPage();
                            $carousel.css('display', 'block'); // unhide
                            if (typeof(callback) === 'function') {
                                callback();
                            }
                        });

                    }

                    /**
                     * is an image zoomed in, right now?
                     * @returns Boolean
                     */
                    function isZoomVisible() {
                        return ($zoomed.css('display') !== 'none');
                    }


                    /**
                     * Checks for hardware acceleration (with CSS transforms) support in the browser, by its engine+version
                     * @return '3d', '2d' or false if no CSS transforms are available
                     */
                    function canHardwareAccelerate() {
                        if (mno.features.transition && mno.features.transform) {
                            var b = jQuery.browser;
                            // moz is too buggy
                            if (b.mozilla) return false;
                            return ((b.webkit && b.version > 530)
                                || (b.mozilla && b.version > 9)
                                || (b.msie && b.version > 9)) ?
                                '3d' : '2d';
                        } else {
                            return false;
                        }
                    }

                    /**
                     * @returns pixel width of one tile
                     */
                    function getItemWidth() {
                        var $item = $carousel.find('.carouselItem');
                        return $item.width() + parseInt($item.css('marginRight'));
                    }

                    function getHorizontalOffset() {
                        // measure single line's height
                        var itemWidth = getItemWidth();
                        var destLeft = -1 * (itemWidth * firstItem);
                        return destLeft;
                    }

                    /**
                     * Just update the display - make sure that the right page is displayed
                     * @param updateZoomed do we need to update the magnified one as well?
                     */
                    function update(updateZoomed) {
                        if (isTouchOnly()) {
                            // all of this is being handled by iScroll
                            listScroller.scrollToPage(firstItem);
                            prefetchPage();
                            return;
                        }
                        prefetchPage({
                            onDone:function (newDiv) {
                                var destLeft = getHorizontalOffset();
                                // zium... :)
                                var acc = canHardwareAccelerate();
                                if ((acc !== false)) {
                                    var b = jQuery.browser;
                                    var translate = (acc == '3d') ?
                                        'translate3d(' + destLeft + 'px, 0, 0)'
                                        : 'translateX(' + destLeft + 'px)';
                                    $adList
                                        .css(mno.features.transitionProperty, 'all 500ms ease-in-out')
                                        .css(mno.features.transform, translate);
                                } else {
                                    $adList.stop(true, false)
                                        .animate({
                                            left:destLeft
                                        })
                                }
                            }
                        });

                        /* update the zoomed */
                        if (updateZoomed && isZoomVisible()) {
                            // if visible.
                            $zoomed.find('.listScrollSingle').animate({
                                opacity:0
                            });
                            $zoomed.find('.adInner').animate({
                                opacity:0
                            }, function () {
                                zoomIn(zoomedIndex);
                            });

                        }
                    }


                });
            }
        }

        function destroy() {
        }


        return {
            init:init,
            destroy:destroy
        }
    }
});
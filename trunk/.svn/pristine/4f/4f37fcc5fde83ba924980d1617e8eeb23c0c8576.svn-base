mno.core.register({
    id:'widget.classifiedBox.horizontal',
    extend:['widget.classifiedBox.common'],
    creator:function (sandbox) {

        function init() {
            var parent = this;
            if (sandbox.container) {
                // loop through instances of the widget
                sandbox.container.each(function (widgetIndex, element) {
                    parent.helper(sandbox, widgetIndex, function (result, shared) {

                        /* cached object references: */
                        var $carousel = jQuery(element);
                        var $adList = $carousel.find('.itemList'),
                            firstItem = 0,
                            imgRefs = [],
                            logoRefs = [],
                            zoomInTimer,
                            $zoomed = jQuery("<div />").css('display', 'none'),
                            zoomedIndex = 0,
                            listScroller = undefined;

                        if (typeof (result.categories.configuration) !== 'undefined') {
                            if (typeof (result.categories.configuration.DELAY) !== 'undefined') {
                                result.config.listHoverDelay = parseFloat(result.categories.configuration.DELAY);
                            }
                            if (typeof (result.categories.configuration.COLOR) !== 'undefined') {
                                result.config.skinColor = result.categories.configuration.COLOR.toLowerCase() + "Theme";
                            }
                        }

                        if (result.config.skinColor !== undefined && result.config.skinColor !== 'default') {
                            $carousel.addClass(result.config.skinColor);
                        }

                        $carousel.addClass('itemsCount_' + result.config.itemsPerPage);
                        $carousel.append($zoomed);

                        $zoomed.bind('mouseleave', function () {
                            if (zoomInTimer) {
                                clearTimeout(zoomInTimer);
                                zoomInTimer = null;
                            }
                            zoomOut(this);
                        });

                        // attach the events:
                        $carousel.find('.listScrollLeft').click(clickPrev);
                        $carousel.find('.listScrollRight').click(clickNext);

                        var filtered = shared.filterAdsByCategory();
                        var data = filtered.category;
                        var categoryId = filtered.categoryId;
                        shared.renderCategories(
                            result.config.categoriesDisplay,
                            result.categories,
                            function (html) {
                                var $categories = $carousel.find('.categories');
                                $categories.html(html);
                                shared.bindCategoriesEvents($categories, renderAds);

                                shared.setSelectedCategory({
                                    container:$categories,
                                    type:result.config.categoriesDisplay,
                                    selected:categoryId
                                });
                            }
                        );
                        renderAds(data);

                        function renderAds(customData) {
                            var i,
                                j;
                            zoomedIndex = 0;
                            firstItem = 0;

                            for (i = 0; i < customData.ads.length; i++) {
                                if ("undefined" !== typeof customData.ads[i].propertyLinks && null !== customData.ads[i].propertyLinks) {
                                    var propertyLinks = customData.ads[i].propertyLinks;
                                    customData.ads[i].properties = {};
                                    for (j = 0; j < propertyLinks.length; j++) {
                                        customData.ads[i].properties[propertyLinks[j].property.name] = propertyLinks[j].aNode || propertyLinks[j].value;
                                    }
                                }
                            }
                            data = customData;
                            render(data.ads, update);

                        }


                        /**
                         * Get single ad landing page URL
                         * @param ad The desired ad's object
                         */
                        function getAdLink(ad) {
                            if (typeof (ad.url) === "string") {
                                if (ad.url.length > 0) {
                                    return ad.url;
                                }
                            }
                            return result.config.landingUrl + ad.objectId;
                        }

                        /**
                         * Get single ad landing page URL
                         * @param adIndex The desired ad's index in the carousel
                         */
                        function getAdLinkByIndex(adIndex) {
                            var ad = data.ads[adIndex];
                            return getAdLink(ad);
                        }

                        /**
                         * switch to the next N ads (all preloading and animation starts here)
                         */
                        function showNext(delta) {
                            firstItem = (isZoomVisible())
                                ? firstItem + delta
                                : Math.min(firstItem + delta, data.ads.length - result.config.itemsPerPage);
                            zoomedIndex = Math.min(zoomedIndex + delta, data.ads.length - 1);
                            checkPagination($carousel);
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
                            checkPagination($carousel);
                            update(true);
                        }

                        /**
                         * handle right/next arrow click (both zoomed and carousel)
                         * @param event
                         */
                        function clickNext(event) {
                            event.preventDefault();
                            if (zoomedIndex === data.ads.length || result.config.itemsPerPage >= data.ads.length) {
                                return;
                            }

                            var $target = jQuery(event.currentTarget);
                            var delta = ($target.is(".listScrollSingle")) ? 1 : result.config.itemsPerPage;
                            showNext(delta);
                        }

                        /**
                         * handle left/previous arrow click (both zoomed and carousel)
                         * @param event
                         */
                        function clickPrev(event) {
                            event.preventDefault();
                            if (zoomedIndex === 0) {
                                return;
                            }

                            var $target = jQuery(event.currentTarget);
                            var delta = ($target.is(".listScrollSingle")) ? 1 : result.config.itemsPerPage;
                            showPrev(delta);
                        }

                        function checkPagination(list) {
                            if (zoomedIndex === 0) {
                                list.find('.carouselHolder .listScrollLeft').addClass('disabled');
                            } else {
                                list.find('.carouselHolder .listScrollLeft').removeClass('disabled');
                            }
                            if (zoomedIndex + 1 === data.ads.length || result.config.itemsPerPage >= data.ads.length) {
                                list.find('.carouselHolder .listScrollRight').addClass('disabled');
                            } else {
                                list.find('.carouselHolder .listScrollRight').removeClass('disabled');
                            }
                        }


                        /**
                         * get current page count (how many ad pages do we have)
                         * @return number of pages available
                         */
                        function getPageCount() {
                            return Math.ceil(data.ads.length / result.config.itemsPerPage);
                        }


                        /**
                         * Get the object for the destination style of .carouselItem after zooming in
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
                            };
                        }

                        /**
                         * Get the object for the destination style of .itemInner after zooming in
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
                            };
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
                            zoomedIndex = index;
                            $zoomed.html(jQuery(item).html());

                            var $item = $zoomed.find('.itemWrap');

                            $item.prepend('<a class="listScrollSingle listScrollLeft listNav"><span></span></a>');
                            $item.append('<a class="listScrollSingle listScrollRight listNav"><span></span></a>');

                            var gaDataId = $item.find('.itemInner').attr('ga-data-id');
                            $item.find('.itemInner').attr('id', gaDataId);

                            $item.find('.itemInner').click(getClickHandler(index));

                            if (isZoomVisible()) {
                                var innerStyle = zoomedAdInnerStyle();
                                innerStyle.opacity = 0;
                                $item.css(zoomedAdWrapStyle());
                                $item.find('.itemInner').css(innerStyle);
                            } else {
                                /* hackidy hack */
                                var itemOffset = jQuery(item).offset();
                                var carouselOffset = $zoomed.parent().offset();
                                var zoomedLeft = itemOffset.left - carouselOffset.left
                                    // but, if we use hardware acceleration, position stays the same...
                                    // and we have a jQuery/Webkit bug: http://bugs.jquery.com/ticket/8362
                                    // so we do additional calc only for non-webkits
                                    + ((canHardwareAccelerate() !== false && (!jQuery.browser.webkit)) ? getHorizontalOffset() : 0);
                                var zoomedTop = itemOffset.top - carouselOffset.top;
                                $zoomed.css({
                                    position:"absolute",
                                    left:zoomedLeft,
                                    top:zoomedTop,
                                    display:"block"
                                }).animate({
                                        opacity:1
                                    });
                            }

                            $item.find('.listScrollLeft').click(clickPrev);
                            $item.find('.listScrollRight').click(clickNext);

                            $item.addClass('zoom');

                            $item.stop(true, true).animate(zoomedAdWrapStyle(), 500);

                            $item.children('.itemInner').stop(true, true).animate(zoomedAdInnerStyle(), 500);

                            $item.children('.itemInner').children('.listPrice').stop(true, true).animate({
                                fontSize:'15px',
                                height:'30px',
                                lineHeight:'30px'
                            }, 500);

                            $item.children('.itemInner').children('.itemOrganization').children('img').stop(true, true).animate({
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

                            $arrow = $zoomed.find('.listScrollRight');
                            if (zoomedIndex >= data.ads.length - 1) {
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
                            var $item = $zoomed.find('.itemWrap');
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

                            $item.children('.itemInner').stop(true, true).animate({
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

                            $item.find('.itemInner .listPrice')
                                .stop(true, true)
                                .css('display', 'block')
                                .animate({
                                    fontSize:'12px',
                                    height:'24px',
                                    lineHeight:'24px'
                                }, 250);

                            $item.find('.itemInner .itemOrganization img').stop(true, true).animate({
                                width:'210px'
                            }, 250);

                            var oldFirst = firstItem;
                            firstItem =
                                Math.max(0, Math.min(firstItem, data.ads.length - result.config.itemsPerPage));
                            if (oldFirst !== firstItem) {
                                update();
                            }
                        }

                        /**
                         * Preload images for a particular ad (prepare the ad for displaying)
                         * @param index which one (index in the overall array)
                         */

                        function prefetchAd(index) {
                            // lazy-load images for the selected ad if lazyload plugin fails
                            imgRefs.eq(index).attr('src', data.ads[index].photo);
                            logoRefs.eq(index).attr('src', data.ads[index].logo);
                        }

                        /**
                         * Generate a click handler function for n-th image
                         * @param index which ad is it.
                         */
                        function getClickHandler(index) {
                            return function () {
                                shared.bindTrackEvent(
                                    data.ads[index].objectId,
                                    shared.VIEW
                                );

                                window.open(getAdLinkByIndex(index), "_blank");
                            };
                        }

                        /**
                         * Get a single page (eg. 5 ads), build its DOM, wait for it to load* and notify
                         * @param options.pageNo which page should we render?
                         * @param options.onDone function(jqDiv) Will get executed when the div is ready to be injected,
                         * with the div build as the parameter
                         */
                        function prefetchPage(options) {
                            var i,
                                idxFrom = Math.max(0, firstItem),
                                idxTo = Math.min(idxFrom + result.config.itemsPerPage, data.ads.length);

                            for (i = idxFrom; i < idxTo; i++) {
                                prefetchAd(i);
                            }

                            try {
                                if (options !== undefined && options !== null && typeof options.onDone === 'function') {
                                    options.onDone();
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
                            sandbox.render('widgets.classifiedBox.views.layouts.' + result.config.type + '.' + result.config.publication + '.horizontal', {
                                items:dataToDisplay,
                                widgetIndex:widgetIndex,
                                skinColor:result.config.skinColor
                            }, function (html) {

                                jQuery(dataToDisplay).each(function (index) {
                                    shared.bindTrackEvent(
                                        jQuery(dataToDisplay)[index].id,
                                        shared.VIEW
                                    );
                                });

                                $carousel.css('visibility', 'visible');  // now that the carousel is set up and can be displayed can eventually show it
                                $carousel.find('.themeHeadline h1').css('visibility', 'visible');

                                $adList.html(html);
                                $adList.find('img.lazy').lazyload({
                                    threshold:200
                                });
                                // fix ul size
                                //alert(getItemWidth());
                                $adList.css({
                                    width:getItemWidth() * dataToDisplay.length
                                });

                                // attach events
                                $adList.find('.listScrollLeft').click(clickPrev);
                                $adList.find('.listScrollRight').click(clickNext);

                                imgRefs = $adList.find('img.itemThumb');
                                logoRefs = $adList.find('img.itemLogo');

                                // setting list wrapper width
                                var $listWrapper = $carousel.find('.headlineWrap');
                                $listWrapper.children('.categoriesList').css('width', $listWrapper.width() - 60);

                                if (result.config.categoryDisplay === 'tabs' && result.config.categoryStructure !== 'none') {
                                    // calculating category list width for iScroll
                                    var addWidth = 0;
                                    var $categoryList = $carousel.find('.categories ul');
                                    var parseIntSafely = function (maybeInt) {
                                        var val = parseInt(maybeInt, 10);
                                        return (isNaN(val)) ? 0 : val;
                                    };
                                    $categoryList.children('li').each(function () {
                                        $this = jQuery(this);
                                        addWidth += ($this.width() + 5)
                                            + parseIntSafely($this.css('borderRightWidth'))
                                            + parseIntSafely($this.css('borderLeftWidth'))
                                            + parseIntSafely($this.css('paddingRight'))
                                            + parseIntSafely($this.css('paddingLeft'))
                                            + parseIntSafely($this.css('marginRight'))
                                            + parseIntSafely($this.css('marginLeft'));
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
                                                var $leftScroll = jQuery('<a class="scrollLeft" href="#">&#9664;</a>');
                                                $leftScroll.css({
                                                    opacity:'0',
                                                    visibility:'hidden'
                                                });
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
                                                    $arrLeft.stop(true, true).css({visibility:'visible'}).animate({opacity:(l ? 1 : 0)}, 500, function () {
                                                        $arrLeft.css({visibility:(l ? 'visible' : 'hidden')});
                                                    });
                                                    $arrRight.stop(true, true).css({visibility:'visible'}).animate({opacity:(r ? 1 : 0)}, 500, function () {
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
                                                mno.core.log(2, "classifiedBox carousel category scroll init failed");
                                            }
                                        }
                                    }
                                }

                                if (result.config.listMagnifier === 'none' && !isTouchOnly()) {
                                    $carousel.find('.itemInner').each(function (i, el) {
                                        jQuery(el).click(getClickHandler(i));
                                    });
                                }

                                // forget zooming, touch support requires different behavior
                                if (isTouchOnly()) {
                                    $adList.wrap('<div class="listHolder" />');
                                    listScroller = new iScroll($carousel.find('.listHolder').get(0), {
                                        snap:"li",
                                        vScroll:false
                                    });
                                    // iScroll is incompatible with lazy-loading images, so load them all.
                                    var len = $adList.children().length;
                                    for (i = 0; i < len; i++) {
                                        prefetchAd(i);
                                    }

                                    $carousel.find('.itemInner').each(function (i, el) {
                                        jQuery(el).click(getClickHandler(i));
                                    });

                                    var touchScrollFrom;
                                    var touchScrollTo;
                                    var startY;

                                    jQuery('.itemList').on("touchstart", function (event) {
                                        event.preventDefault();
                                        touchScrollFrom = event.originalEvent.touches[0].clientY;
                                        startY = touchScrollFrom;
                                    });

                                    $carousel.find('.itemList').on("touchmove", function (event) {
                                        event.preventDefault();

                                        touchScrollTo = event.originalEvent.touches[0].clientY;
                                        var diffSinceStart = (touchScrollTo - startY);
                                        if (Math.abs(diffSinceStart) > 20) {
                                            var diffY = (touchScrollFrom - touchScrollTo);
                                            jQuery(window).scrollTop(jQuery(window).scrollTop() + diffY);
                                        }
                                        touchScrollFrom = touchScrollTo;
                                    });

                                } else {
                                    // mouse hover instant zoom effect
                                    if (result.config.listMagnifier === 'hover') {
                                        $carousel.find('.carouselItem').hover(function (event) {
                                            var that = this;
                                            zoomInTimer = setTimeout(function () {
                                                var index = $adList.children().index(jQuery(that));
                                                zoomIn(index);
                                            }, (result.config.listHoverDelay) * 1000);
                                        }, function (e) {
                                            if (zoomInTimer) {
                                                clearTimeout(zoomInTimer);
                                                zoomInTimer = null;
                                            }
                                        });
                                    } else if (result.config.listMagnifier === 'click') {
                                        $carousel.find('.carouselItem').click(function (event) {
                                            var index = $adList.children().index(jQuery(this).closest('li'));
                                            zoomIn(index);
                                        });
                                    }
                                }
                                prefetchPage();

                                $carousel.find('.carouselHolder .listScrollLeft').addClass('disabled');
                                if (zoomedIndex === data.ads.length || result.config.itemsPerPage >= data.ads.length) {
                                    $carousel.find('.carouselHolder .listScrollRight').addClass('disabled');
                                }

                                $carousel.css('display', 'block'); // unhide
                                if (typeof (callback) === 'function') {
                                    callback();
                                }

                                jQuery(window).unbind('resize.carouselSize').bind('resize.carouselSize', function() { adjustSizes(dataToDisplay) } );
                                adjustSizes(dataToDisplay);
                            });
                        }

                        /**
                         * is an image zoomed in, right now?
                         * @returns Boolean
                         */
                        function isZoomVisible() {
                            return ($zoomed.css('display') !== 'none');
                        }


                        /** adjust sizes (mostly for mobile) */
                        function adjustSizes(dataToDisplay) {
                            $adList.css({
                                width:getItemWidth() * dataToDisplay.length
                            });
                            if (typeof (mnoMobile) !== 'undefined') {
                                $carousel.find('.carouselHolder .itemList li').css('width', (window.innerWidth) / 2);
                            }
                            if (typeof (listScroller) !== 'undefined') {
                                listScroller.refresh();
                            }
                        }

                        /**
                         * Checks for hardware acceleration (with CSS transforms) support in the browser, by its engine+version
                         * @return '3d', '2d' or false if no CSS transforms are available
                         */
                        function canHardwareAccelerate() {
                            if (mno.features.transition && mno.features.transform) {
                                var b = jQuery.browser;
                                // moz is too buggy
                                if (b.mozilla) {
                                    return false;
                                }
                                return ((b.webkit && b.version > 530)
                                    || (b.mozilla && b.version > 9)
                                    || (b.msie && b.version > 9)) ?
                                    '3d' : '2d';
                            }
                            return false;
                        }

                        /**
                         * @returns pixel width of one tile
                         */
                        function getItemWidth() {
                            var $item = $carousel.find('.carouselItem');
                            return $item.width() + parseInt($item.css('marginRight'), 10);
                        }

                        function getHorizontalOffset() {
                            // measure single line's height
                            var itemWidth = getItemWidth();
                            return -1 * (itemWidth * firstItem);
                        }

                        /**
                         * Just update the display - make sure that the right page is displayed
                         * @param updateZoomed do we need to update the magnified one as well?
                         */
                        function update(updateZoomed) {
                            if (isTouchOnly()) {
                                // all of this is being handled by iScroll
                                // moreover, no prefetching is needed, we've dropped lazyloading for ipad
                                listScroller.scrollToPage(firstItem);
                                return;
                            }
                            prefetchPage({
                                onDone:function () {
                                    var destLeft = getHorizontalOffset();
                                    // zium... :)
                                    var acc = canHardwareAccelerate();
                                    if ((acc !== false)) {
                                        var b = jQuery.browser;
                                        var translate = (acc === '3d') ?
                                            'translate3d(' + destLeft + 'px, 0, 0)'
                                            : 'translateX(' + destLeft + 'px)';
                                        $adList
                                            .css(mno.features.transitionProperty, 'all 500ms ease-in-out')
                                            .css(mno.features.transform, translate);
                                    } else {
                                        $adList.stop(true, false)
                                            .animate({
                                                left:destLeft
                                            });
                                    }
                                }
                            });

                            /* update the zoomed */
                            if (updateZoomed && isZoomVisible()) {
                                // if visible.
                                $zoomed.find('.listScrollSingle').animate({
                                    opacity:0
                                });
                                $zoomed.find('.itemInner').animate({
                                    opacity:0
                                }, function () {
                                    zoomIn(zoomedIndex);
                                });

                            }
                        }
                    });
                });
            }
        }

        function destroy() {
            $carousel.detach();
        }

        return {
            init:init,
            destroy:destroy
        };
    }
});
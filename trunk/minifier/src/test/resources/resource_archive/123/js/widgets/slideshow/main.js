mno.core.register({
    id:'widget.slideshow.main',
    creator:function (sandbox) {
        var features = mno.features,
            $ = sandbox.$,
            easing = (jQuery.easing.easeInOutCubic !== undefined) ? 'easeInOutCubic' : 'swing',
            slideshowArray = [];

        function Slideshow($this, $container, config) {
            var that = this, /* ensure correct scope */
                scrollStart = 0;

            that.config = config;
            that.$container = $container;
            that.$slideshow = $this;
            that.$items = $this.find('li');
            that.$list = $this.find('.slideshow-list');
            that.index = 0;
            that.speed = 250;
            that.active = false;

            /* Check if transfor is supported and silverlight is not present (bug with silverlight and transform. See: mnobeta.no) */
            if (features.transform === false && features.transition === false || this.$items.find('object[type="application/x-silverlight-2"]').length !== 0) {
                that.adjustHeight = that.adjustHeightFallback;
                that.gotoIndex = that.gotoIndexFallback;
            }

            /* Setup dimensions */
            that.setDimensions();

            /* Create buttons */
            that.createButtons();

            $container.addClass('mnoSlideshow');

            if (that.$list.find('img').length > 0) {
                that.$list.find('img').each(function (i, el) {
                    if (el.complete || el.readyState === 4) {
                        if (config.markOrientation === true) {
                            that.addOrientationClass(el);
                            that.triggerSizeFixes();
                        }
                        else {
                            that.triggerSizeFixes();
                            return false;
                        }
                    } else {
                        jQuery(el).bind('load', function () {
                            if (config.markOrientation === true) {
                                that.addOrientationClass(el);
                            }
                            that.triggerSizeFixes.call(that);
                        });
                    }
                });
            }

            that.$slideshow.on('click.slideshowA', 'a', function (e) {
                if (that.active === true) {
                    e.preventDefault();
                }
            });

            if (that.size !== 1) {
                $this.gestures({
                    accuracy:5,
                    timeout:false,
                    onStart:function () {
                        scrollStart = that.index * that.itemWidth * that.config.numVisible;
                        that.active = true;
                    },
                    onMove:function () {
                        if (features.transform !== false && features.transition !== false) {
                            return function (pos) {
                                that.$list.css(features.transform, 'translateX(-' + (scrollStart - pos.x) + 'px)');
                            }
                        } else {
                            return function (pos) {
                                if ((scrollStart + that.itemWidth) <= that.listTotalItemWidth) {
                                    $this.scrollLeft(scrollStart - pos.x);
                                }
                            }
                        }
                    }(),
                    onCancel:function () {
                        that.gotoIndex();
                    },
                    callback:function (gesture) {
                        that.speed = gesture.speed(that.width);
                        if (gesture.horizontal === 'left' && that.size > that.index + 1) {
                            that.index++;
                        } else if (gesture.horizontal === 'right' && that.index > 0) {
                            that.index--;
                        }
                        that.gotoIndex();
                        setTimeout(function () {
                            that.active = false;
                        }, 500);
                    }
                });
            }

            /* Rescale on orientationchange */
            jQuery(window).bind('orientationchange resize', function () {
                that.setDimensions();
                that.adjustHeight();
            });
        }

        Slideshow.prototype = {
            /* Adjust height */
            adjustHeight:function () {
                var cache;
                return function () {
                    if (this.$items.eq(this.index).find('.slideShowItemContainer').height() !== cache) {
                        cache = this.$items.eq(this.index).find('.slideShowItemContainer').height();
                        this.$list.css('height', cache + 'px');
                    }
                }
            }(),
            adjustHeightFallback:function () {
                var cache;
                return function () {
                    if (this.$items.eq(this.index).find('.slideShowItemContainer').height() !== cache) {
                        cache = this.$items.eq(this.index).find('.slideShowItemContainer').height();
                        this.$list.stop();
                        this.$list.animate({height:cache + 'px'}, 250, easing);
                    }
                }
            }(),
            /* Setup layout */
            setDimensions:function () {
                this.width = this.$slideshow.width();
                this.itemWidth = (this.width / this.config.numVisible) - this.config.padding;
                this.size = Math.ceil(this.$items.length / this.config.numVisible);
                this.listTotalItemWidth = this.size * this.width;

                this.$slideshow.css({
                    height:this.$list.height() + 'px',
                    position:'relative'
                });

                this.$items.css({
                    overflow:'hidden',
                    paddingRight:this.config.padding + 'px',
                    width:this.itemWidth + 'px'
                });
                this.$list.css({
                    position:'absolute',
                    top:0,
                    left:0,
                    width:this.listTotalItemWidth + 'px'
                });
            },
            /* Setup/Update counter to set current Index*/
            updateCounter:function () {
                var that = this;
                /* "this" is taken by jquery each */

                if (this.config.thumbnails === true) {
                    this.$counter.find('a').each(function (i) {
                        $(this).attr('class', (i === that.index) ? 'active' : '');
                    });
                } else {
                    this.$counter.find('a').each(function (i) {
                        if (i === that.index) {
                            $(this).html('\u25CF');
                        } else {
                            $(this).html('\u25CB');
                        }
                    });
                }
            },
            /* Set up slideshow buttons */
            createButtons:function () {
                if (this.size !== 1) {
                    var that = this;
                    var isAndroid = navigator.userAgent.toLowerCase().indexOf("android") > -1;
                    if (isAndroid) {
                        this.$prevEl = jQuery('<div class="slideShowPrev"><img src="/skins/global/gfx/slideshow/prev.png" style="width:21px;height:21px;margin-top:9px;margin-left:9px;"></div>');
                        this.$nextEl = jQuery('<div class="slideShowNext enabled"><img src="/skins/global/gfx/slideshow/next.png" style="width:21px;height:21px;margin-top:9px;margin-left:9px;"></div>');

                    } else {
                        this.$prevEl = jQuery('<div class="slideShowPrev">\u25C4</div>');
                        this.$nextEl = jQuery('<div class="slideShowNext enabled">\u25BA</div>');
                    }

                    this.$counterWrapper = jQuery('<div class="counterWrapper"><div class="counter"></div></div>');
                    this.$counter = this.$counterWrapper.find('.counter');

                    var resizer;
                    if (that.config.thumbnails === true) {
                        this.$counter.addClass("thumbnails");
                        this.$counterWrapper.addClass("hasThumbnails");
                        resizer = new mno.utils.ImageResizer(that.config.thumbnailConfig);
                    }

                    if (this.size !== 1) {
                        for (var i = 0; i < this.size; i++) {
                            (function (i) {
                                var $single = jQuery('<a href="#"></a>').bind('click', function (e) {
                                    e.preventDefault();
                                    that.index = i;
                                    that.gotoIndex(i);
                                });
                                if (that.config.thumbnails === true) {
                                    var img = that.$items.eq(i).find('img');
                                    if (img.length > 0) {
                                        var $newImg = jQuery('<img />');
                                        $newImg.attr({
                                            src:resizer.getImage(img.attr('src')),
                                            width:that.config.thumbnailConfig.width,
                                            height:that.config.thumbnailConfig.height
                                        });

                                        $single.html($newImg);
                                    }
                                }
                                $single.appendTo(that.$counter);
                            }(i));
                            this.updateCounter();
                        }

                        if (typeof(iScroll) !== "undefined" && this.config.thumbnails === true) {
                            this.$counter.css({
                                width:that.config.thumbnailConfig.width * 1.1 * that.size,
                            });
                        } // else we're fucked
                    } else {
                        this.$counter.css('display', 'none');
                    }

                    this.$prevEl.bind('click', function () {
                        that.index--;
                        that.gotoIndex();
                        return false;
                    });

                    this.$nextEl.bind('click', function () {
                        that.index++;
                        that.gotoIndex();
                        return false;
                    });

                    this.$slideshow.after(this.$prevEl, this.$nextEl, this.$counterWrapper);
                    // iScroll needs to have stuff already in DOM
                    if (this.size !== 1) {
                        if (typeof(iScroll) !== "undefined" && this.config.thumbnails === true) {
                            this.$counterWrapper.before('<div class="thumbsNext"><div>&#x25b6;</div></div>', '<div class="thumbsPrev"><div>&#x25c0;</div></div>')
                            this.$container.find('.thumbsNext,.thumbsPrev').css({ height:this.config.thumbnailConfig.height });
                            this.scroller = new iScroll(this.$counterWrapper.get(0), {
                                vScroll:false,
                                snap:"a",
                                hScrollbar:true
                            });
                            var that = this;
                            var pageSize = Math.floor((this.$counterWrapper.width()) / (this.config.thumbnailConfig.width));
                            /* next n thumbnails */
                            this.$container.find('.thumbsNext').click(function () {
                                that.scroller.scrollToPage(that.scroller.currPageX + pageSize, 0, 200);
                            });
                            /* prev n thumbnails */
                            this.$container.find('.thumbsPrev').click(function () {
                                that.scroller.scrollToPage(that.scroller.currPageX - pageSize, 0, 200);
                            });
                        } // else we're fucked
                    }
                }
            },
            toggleButtons:function () {
                if (this.index === 0) {
                    this.$prevEl.removeClass('enabled');
                } else {
                    this.$prevEl.addClass('enabled');
                }
                if (this.index === this.size - 1) {
                    this.$nextEl.removeClass('enabled');
                } else {
                    this.$nextEl.addClass('enabled');
                }
            },
            /* Move slideshow to index position */
            gotoIndex:function (i) {
                var that = this, /* for setTimeout */
                    css = {};

                css[features.transform] = 'translateX(-' + this.index * this.width + 'px)';
                css[features.transitionProperty] = 'all ease-out ' + that.speed + 'ms';

                this.index = (i !== undefined) ? i : this.index;
                if (this.config.alwaysDisplayButtons === false) {
                    this.$container.removeClass('load');
                }

                // Lazy load images
                this.$list.find('.slideShowItemContainer').each(function () {
                    var $this = $(this);
                    if ($this.find('img.xlazy').length > 0) {
                        $this.find('img.xlazy').lazyload().css('height', '100%');
                        // Initialize all image elements
                        $this.find('img').attr('src',$this.find('img').attr('data-original'));
                        // remove the lazy class preventing the operation to run more than once
                        $this.find('img.xlazy').removeClass('lazy');
                    }
                });

                this.adjustHeight();
                this.$list.css(css);
                setTimeout(function () {
                    that.$list.css(features.transitionProperty, 'none');
                    that.updateCounter();
                    that.toggleButtons();
                }, that.speed + 200);
            },
            gotoIndexFallback:function (i) {
                var that = this;
                this.index = (i !== undefined) ? i : this.index;
                if (this.config.alwaysDisplayButtons === false) {
                    this.$container.removeClass('load');
                }
                // Lazy load images
                this.$list.find('.slideShowItemContainer').each(function () {
                    var $this = $(this);
                    if ($this.find('img.xlazy').length > 0) {
                        $this.find('img.xlazy').lazyload().css('height', '100%');
                        // Initialize all image elements
                        $this.find('img').attr('src',$this.find('img').attr('data-original'));
                        // remove the lazy class preventing the operation to run more than once
                        $this.find('img.xlazy').removeClass('lazy');
                    }
                });
                this.adjustHeight();
                this.$slideshow.stop();
                this.$slideshow.animate({
                    scrollLeft:(this.index * this.width) + 'px'
                }, 250, easing, function () {
                    that.updateCounter();
                    that.toggleButtons();
                });
            },
            /* Webkit doesn't give height before image load */
            triggerSizeFixes:function () {
                if (this.config.markOrientation !== true) {
                    this.$list.find('img').unbind('load');
                }
                else {
                    /* if we're marking orientation,
                     therefore having various sizes,
                     wait for the last image to load */
                    this.leftToLoad = (this.leftToLoad || this.size) - 1;
                    if (this.leftToLoad !== 0) {
                        return;
                    }
                }
                this.$slideshow.css({
                    height:this.$list.height() + 'px'
                });
                this.adjustHeight();
                /* fix the scroller, by the way */
                if (typeof(this.scroller) !== "undefined") {
                    this.scroller.refresh();
                }
            },
            /* detects if the image is portrait or landscape and adds a CSS class
             */
            addOrientationClass:function (el) {
                var $el = jQuery(el);
                if ($el.width() >= $el.height()) {
                    $el.addClass('landscape');
                } else {
                    $el.addClass('portrait');
                }
            }
        };

        function init() {
        }

        function destroy() {
        }

        function slideshow($container, settings) {
            var config = {
                alwaysDisplayButtons:false,
                numVisible:1,
                markOrientation:false,
                thumbnails:false,
                thumbnailConfig:{
                    width:100,
                    height:60,
                    resize:'crop'
                },
                padding:0
            };

            for (var i in settings) {
                if (settings.hasOwnProperty(i)) {
                    config[i] = settings[i];
                }
            }

            if (config.numVisible !== 1 && config.padding !== 0) {
                config.padding = 20;
            }

            $container.each(function () {
                var $this = $(this);
                $container.find('.slideshow-wrapper').each(function (i) {
                    slideshowArray.push(new Slideshow($(this), $this, config));
                });
            });
        }

        /*@remove*/
        function QUnitTest() {
            test("Slideshow exists", function () {
                var $markup = window.jQuery('<section class="widget slideshow main"><div class="slideshow-wrapper"><ul class="slideshow-list"><li class="slideshow-element"><img src="about:blank" alt="" /></li></ul></div></section>'),
                    $wrapper = $markup.find('.slideshow-wrapper');

                window.jQuery('#qunit-fixture').append($markup);
                var slideshow = new Slideshow($markup, $wrapper, {alwaysDisplayButtons:false});

                strictEqual((slideshow instanceof Slideshow), true, 'passes, Slideshow object is created');
            });
        }

        /*/@remove*/

        return {
            init:init,
            slideshow:slideshow,
            slideshowArray:slideshowArray,
            destroy:destroy
            /*@remove*/, QUnitTest:QUnitTest/*/@remove*/
        };
    }
});
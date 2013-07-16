/**
 * Created by IntelliJ IDEA.
 * User: ARISINAB
 * Date: 03.des.2010
 * Time: 16:17:59
 * To change this template use File | Settings | File Templates.
 */
mno.core.register({
    id: 'widget.mobileSlideShow.default',
    /*require:['mno.utils.gestures'],*/
    creator: function (sandbox) {
        function init(){

                var $slideshow = $('.mobileSlideShow');

                $slideshow.each(function () {
                    var $this = $(this),
                            itemWidth = $this.width(),
                            items = $this.find('li'),
                            $list = $this.find('.slideshow-list'),
                            easing,
                            scrollStart,
                            speed = 500;

                    $list.append('<div id="mobileSlideShowPrev"><span>\u25C4</span></div><div id="mobileSlideShowNext"><span>\u25BA</span></div>');

                    var prevEl = $('#mobileSlideShowPrev'),
                        nextEl = $('#mobileSlideShowNext');

                    items.css({
                        overflow:'hidden',
                        width:itemWidth + 'px'
                    });

                    $list.css({
                        width:items.size()*itemWidth + 'px'
                    });

                    function setEasing() {
                        if($.easing.easeInOutElastic !== undefined) {
                            easing = 'easeInOutCubic';
                            return true;
                        } else {
                            easing =  'swing';
                            return false;
                        }
                    }

                    function repositionController() {
                        scrollStart = $this.scrollLeft();
                        prevEl.css('left', scrollStart).show();
                        nextEl.css('left', scrollStart +itemWidth - 30).show();

                        if (scrollStart === 0) {
                            prevEl.hide();
                        } else if (scrollStart === $list.width() - itemWidth ) {
                            nextEl.hide();
                        }
                    }

                    repositionController();

                    function hideController() {
                        prevEl.hide();
                        nextEl.hide();
                    }

                    var next = function () {
                        if (setEasing() === true) {
                            next = function() {
                                $this.animate({scrollLeft: scrollStart + itemWidth},speed, easing, repositionController);
                            };
                            next();
                        } else {
                            $this.animate({scrollLeft: scrollStart + itemWidth},speed, easing, repositionController);
                        }
                    };

                    var prev = function () {
                        if (setEasing() === true) {
                            prev = function() {
                                $this.animate({scrollLeft: scrollStart - itemWidth},speed, easing, repositionController);
                            };
                            prev();
                        } else {
                            $this.animate({scrollLeft: scrollStart - itemWidth},speed, easing, repositionController);
                        }
                    };

                    var cancel = function () {
                        if (setEasing() === true) {
                            cancel = function() {
                                $this.animate({scrollLeft: scrollStart},500, easing, repositionController);
                            };
                            cancel();
                        } else {
                            $this.animate({scrollLeft: scrollStart},500, easing, repositionController);
                        }
                    };

                    prevEl.live('click', function () {
                        hideController();
                        prev();
                    });

                    nextEl.live('click', function () {
                        hideController();
                        next();
                    });

                    $this.gestures({
                    	onStart: function () {
                    		scrollStart = $this.scrollLeft();
                    	},
                    	onMove: function(pos) {
                    		$this.scrollLeft(scrollStart - pos.x);
                    	},
                    	onCancel: function () {
                    		cancel();
                    	},
                        callback:function(gesture) {
                            speed = gesture.time;
                            if(gesture.horizontal === 'left'){
                                next();
                            } else if(gesture.horizontal === 'right'){
                                prev();
                            } else {
                            	cancel();
                            }

                        }

                    });
                });


            }

        function destroy() {
            $ = null;
        }

        return {
            init: init,
            destroy: destroy
        };
    }
});
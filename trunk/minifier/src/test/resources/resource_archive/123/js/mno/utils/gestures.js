(function ($) {
    $.fn.gestures = function(settings){
        var x=0,
            y=0,
            diffx,
            diffy,
            timer,
            moveEvent,
            moveTimer,
            gestureID = 'gesture' + Math.random() * 10000;

        settings = $.extend({
            distance:45,
            accuracy: 5,
            textSelection:false,
            timeout: true,
            preventDefault:false,
            stopPropagation:false,
            callback: function () {},
            onMove:function() {},
            onStart:function() {},
            onEnd: function () {},
            onCancel: function() {}
        }, settings);

		var touch = mno.features.touch,
            mousedown = (touch === true ? 'touchstart.' + gestureID : 'mousedown.' + gestureID),
			mousemove = (touch === true ? 'touchmove.' + gestureID : 'mousemove.' + gestureID),
			mouseup = (touch === true ? 'touchend.' + gestureID : 'mouseup.' + gestureID + ' mouseleave.' + gestureID);

        this.each(function() {
            var $this = $(this),
            	gestureActive = false;

            if (settings.textSelection === false) {
                this.onselectstart = function() { return false; };
                this.unselectable = "on";
                $this.addClass('disableSelect');
                $this.find('img').bind('mousedown', function (e) {
                    e.preventDefault();
                });
            }
            $this.attr('data-gestures','enabled');

            function touchStart(e) {
                moveEvent = (e.originalEvent.changedTouches !== undefined) ? e.originalEvent.changedTouches[0] : e;
           	    x = moveEvent.pageX;
                y = moveEvent.pageY;
                diffx = 0;
                diffy = 0;
                timer = new Date().getTime();
            }

            function touchCancel() {
                gestureActive = false;
                $this.unbind(mousemove).unbind(mouseup);
                if (mno.features.touch === true) {
                    $this.unbind('touchcancel.' + gestureID);
                }
                settings.onCancel();
            }

            function touchMove(e) {
                moveEvent = e.originalEvent.changedTouches !== undefined ? e.originalEvent.changedTouches[0] : e;
                diffx = moveEvent.pageX-x;
                diffy = moveEvent.pageY-y;
                if (gestureActive === true) {
                    settings.onMove({
                        x:diffx,
                        y:diffy
                    });
                } else {
                    if (diffx > settings.accuracy || diffx < -settings.accuracy) { //  || (Math.abs(diffy) > settings.accuracy)
                        settings.onStart({
                            x:x,
                            y:y
                        });
                        gestureActive = true;
                        if (settings.timeout === true) {
                            setTimeout(function () {
                                touchCancel();
                            }, 1000);
                        }

                        mno.event.triggerEvent({
                            type:'slideStart',
                            data:true
                        });
                    }
                }
            }

            function touchStop(e) {
             	if(($this.attr('data-gestures') === 'enabled') && gestureActive === true) {
                    e = (e.originalEvent.changedTouches !== undefined) ? e.originalEvent.changedTouches[0] : e;
                    var time = new Date().getTime() - timer,
                        dir = {
                            horizontal:false,
                            vertical:false,
                            speed:function () {
                                return 0;
                            },
                            time:time
                        };
            	 	diffx = e.pageX-x || 0;
                 	diffy = e.pageY-y || 0;

                    if (diffx <= -settings.distance) {
                        dir.horizontal = 'left';
                    }
                    if (diffx >= settings.distance) {
                        dir.horizontal = 'right';
                    }
                    if (diffy <= -settings.distance) {
                        dir.vertical = 'up';
                    }
                    if (diffy >= settings.distance) {
                        dir.vertical = 'down';
                    }

                    if (dir !== undefined) {
                        dir.speed = function (dist) {
                            var swipedDistance =  Math.sqrt((diffx *diffx) + (diffy*diffy));
                            return (dist-swipedDistance) * time / swipedDistance;
                        }
                    }

                    if (dir.horizontal !== false || dir.vertical !== false) {
                        settings.callback(dir);
                    } else {
                    	touchCancel();
                    }
					gestureActive = false;
                    settings.onEnd({
                        x:diffx,
                        y:diffy,
                        speed:dir.speed,
                        time:time
                    });
                     mno.event.triggerEvent({
                         type:'slideEnd',
                         data:true
                     });
                }
            }

            $this.bind('dragstart drag dragend drop', function(e) {
                e.preventDefault();
                e.stopPropagation();
            });

            $this.bind(mousedown, function(e) {
                touchStart(e);
                if (settings.preventDefault === true) {
                    e.preventDefault();
                }
                if (settings.stopPropagation === true) {
                    e.stopPropagation();
                }
                $this.bind(mousemove, function(e) {
                    touchMove(e);
                    if (settings.preventDefault === true) {
                        e.preventDefault();
                    }
                    if (settings.stopPropagation === true) {
                        e.stopPropagation();
                    }
                }).bind(mouseup, function(e) {
            	    touchStop(e);
                    $this.unbind(mousemove).unbind(mouseup);
                    if (mno.features.touch === true) {
                        $this.unbind('touchcancel.' + gestureID);
                    }
                });
                if (mno.features.touch === true) {
                    $this.bind('touchcancel.' + gestureID, function () {
                        touchCancel();
                    });
                }
                return true;
            });

            return this;

        });
    };

}(window.jQuery));
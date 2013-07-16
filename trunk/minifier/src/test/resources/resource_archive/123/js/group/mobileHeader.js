mno.core.register({
    id:'group.mobileHeader',
    creator:function (sandbox) {
        var closed = false,
            containerHeight,
            transform = mno.features.transform;

        function toggle() {
            closed = !closed;
            sandbox.container.addClass('animate').css('bottom', ((closed === false) ? 0 : -containerHeight) + 'px');
        }

        sandbox.container.find('.link').bind('click.scrubber', function () {
            window.location.href=$(this).attr('data-menu-href');
        });

//        var toggle = (function () {
//            if (typeof transform === 'string') {
//                return function toggle() {
//                    closed = !closed;
//                    sandbox.container.addClass('animate').css(transform, 'translateY(' + ((closed === false) ? 0 : containerHeight) + 'px)');
//                }
//            } else {
//                return function toggle() {
//                    closed = !closed;
//                    sandbox.container.addClass('animate').css('margin-top', ((closed === false) ? 0 : containerHeight) + 'px');
//                }
//            }
//        }());

        function _scrubber() {
            sandbox.container.wrapInner('<div class="innerWrapper" />');
            var w = 0,
                menuLeft = 0,
                transform = mno.features.transform,
                menuRight,
                inner = sandbox.container.find('.innerWrapper');

            sandbox.container.addClass('scrubber isLeft');
            sandbox.container.find('.mobileTabbedMenu li').each(function () {
                w += $(this).outerWidth();
            });
            sandbox.container.find('.searchField').each(function () {
                w += $(this).outerWidth();
            });
            w += 20; //safety

            menuRight =  -(w - $(window).width());
            inner.width(w);
            inner.scrollLeft('0');

            function _preventDefault(flag) {
                if (flag === true) {
                    $(document).bind('touchstart.scrubber touchmove.scrubber', function (e) {
                        e.originalEvent.preventDefault();
                    });
                    inner.find('.link').unbind('click.scrubber');
                    inner.find('input').bind('focus.scrubber', function (e) {
                        e.originalEvent.preventDefault();
                    });
                } else {
                    $(document).unbind('touchstart.scrubber touchmove.scrubber');
                    sandbox.container.find('.link').bind('click.scrubber', function () {
                        window.location.href=$(this).attr('data-menu-href');
                    });
                    inner.find('input').unbind('focus.scrubber');
                }
            }

            jQuery.extend( jQuery.easing, {
                easeOutSine: function (x, t, b, c, d) {
                    return c * Math.sin(t/d * (Math.PI/2)) + b;
                }
            });

            inner.gestures({
                accuracy:1,
                timeout:false,
                onStart: function () {
                    _preventDefault(true);
                    inner.stop();
                },
                onMove:(function () {
                        return function (coor) {
                            if (menuLeft+coor.x < 0 && menuLeft + coor.x > menuRight) {
                                inner.css('margin-left', ((menuLeft + coor.x) + 'px'));
                                sandbox.container.removeClass('isLeft isRight');
                            }
                        }
                }()),
                onEnd: function (coor) {
                    _preventDefault(true);
                    setTimeout(function () {_preventDefault(false)},200);
                    if (coor.time < 1000) {
                        coor.x = coor.x + Math.floor((coor.x/(coor.time*.01)));
                    }

                    if (menuLeft + coor.x < 0 && menuLeft + coor.x > menuRight) {
                        menuLeft += coor.x;
                        sandbox.container.removeClass('isLeft isRight');
                    } else if (coor.x < 0) {
                        menuLeft = menuRight;
                        sandbox.container.addClass('isRight');
                    } else if (coor.x > 0) {
                        menuLeft = 0;
                        sandbox.container.addClass('isLeft');
                    }

                    if (coor.time < 1000) {
                        inner.animate({marginLeft:(menuLeft) + 'px'}, coor.time, 'easeOutSine');
                    } else {
                        inner.css({marginLeft:(menuLeft) + 'px'});
                    }
                }
            });
        }

        function _show() {
            function load () {
                sandbox.container.css({
                    display:'block',
                    bottom:0
                });
                toggle();
                window.setTimeout(function () {
                    window.scrollTo(0, window.pageYOffset+1);
                }, 100);
            }

            if (mno.states.windowLoad === true) {
                load();
            } else {
                $(window).bind('load', load);
            }
        }

        function init() {
            var handle = $('<div class="handle">Meny</div>');
            containerHeight = sandbox.container.height();
            handle.bind('mouseup', function () {
                toggle();
            });

            sandbox.container.prepend(handle);
/*
            if (mno.features.touch === true) {
                mno.features.positionFixed( function (fixed) {
                    if (fixed === true) {
                        _show();
                    } else {
                        _scrubber();
                    }
                });
            } else {
                _scrubber();
            }
            */
            _scrubber();

            /* Gestures */
            /*
            $(document).bind('touchstart', function (e) {
                var orgE = e.originalEvent;
                e = (e.originalEvent.touches !== undefined) ? e.originalEvent.touches[0] : e;
                if (e.target === handle.get(0)) {
                    orgE.preventDefault();
                }
            });
            */

            handle.gestures({
                accuracy:1,
                timeout:false,
                preventDefault:true,
                stopPropagation:true,
                onStart: function () {
                    sandbox.container.removeClass('animate');
                },
                onMove: function (coor) {
                            var cy = (closed === true) ? containerHeight + coor.y : coor.y ;
                            if (cy > 0 && cy < containerHeight) {
                                sandbox.container.css('bottom', -cy + 'px');
                            }
                        },
                onEnd: function (coor) {
                    if ((containerHeight - Math.abs(coor.y) > containerHeight/2) && coor.y !== 0) {
                        closed = !closed;
                    }
                    toggle();
                }
            });

        }
        function destroy() {}

        return {
            init:init,
            destroy:destroy
        }
    }
});
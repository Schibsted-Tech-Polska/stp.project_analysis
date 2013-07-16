mno.core.register({
    id: 'utils.scroll',
    forceStart:true,
    creator:function (sandbox) {
        var $window = $(document),
                $header = $('#header'),
                annotations,
                annotationsElement,
                x,
                y,
                touchStopTimer = null;

        /**
         * Special scroll events
         */

//        function _touchScrollStart(e) {
//            if (touchStopTimer) {
//                window.clearTimeout(touchStopTimer);
//            }
//            sandbox.notify({
//                type:'scrollstart',
//                data: {
//                    x:x,
//                    y:y
//                }
//            });
//        }
//
//        function _touchScrollEnd(e) {
//            touchStopTimer = window.setTimeout(function () {
//                x = window.pageXOffset;
//                y = window.pageYOffset;
//                sandbox.notify({
//                    type:'scrollstop',
//                    data: {
//                        x:x,
//                        y:y
//                    }
//                });
//                touchStopTimer = null;
//            },500);
//        }

        function _checkScroll() {
            var scrollX = $window.scrollLeft(),
                scrollY = $window.scrollTop(),
                type = 'scrollstop';

            if (scrollY !== y || scrollX !== x) {
                type = 'scrollmove';
                setTimeout(_checkScroll, 150);
            } else {
                _scrollIdle();
            }

            sandbox.notify({
                type:type,
                data: {
                    x:scrollX,
                    y:scrollY
                }
            });

            y = scrollY,
            x = scrollX;
        }

        function _scrollIdle(){
            $window.bind('scroll.mno', function (e) {
                sandbox.notify({
                    type:'scrollstart',
                    data:{x:x,y:y}
                });

                $window.unbind('scroll.mno');
                setTimeout(_checkScroll, 150);
            });
        }

        return {
            init:function () {
                var id;
                x = $window.scrollLeft();
                y = $window.scrollTop();
                _scrollIdle();

//                sandbox.listen({
//                    'scrollstart': function (e) {
//                        annotations = sandbox.getData('module-position');
//                        annotationsElement = $('<div></div>').css( {
//                            position:'fixed',
//                            right:0,
//                            height:'100%',
//                            width:'1px'
//                        })
//                        .appendTo('body');
//                        for (id in annotations) {
//                            if(annotations.hasOwnProperty(id)) {
//                                jQuery('<span />').html(annotations[id].title +'&nbsp;\u27A4').css({
//                                        position:'absolute',
//                                        right:0,
//                                        lineHeight:'10px',
//                                        fontSize:'10px',
//                                        verticalAlign:'middle',
//                                        height:'10px',
//                                        whiteSpace:'nowrap',
//                                        top:annotations[id].position.pageY/jQuery(document).height() * jQuery(window).height() +'px'
//                                        })
//                                    .appendTo(annotationsElement);
//                            }
//                        }
//                    },
//                    'scrollstop': function () {
//                        if (annotationsElement) {
//                            annotationsElement.remove();
//                        }
//                        annotations = null;
//                    }
//                });
            },
            destroy:function () {
                $window = null;
                $header = null;
                annotations = null;
                annotationsElement = null;
            }
        };
    }
});
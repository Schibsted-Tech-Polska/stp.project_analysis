mno.core.register({
    id:'widget.pagePreview.default',
    creator:function(sandbox) {
        var container = sandbox.container;
        function getThumb() {
            var el = $('<img src="" class="floatRight"/>'),
                small='http://www.bt.no/external/btfrontthumb/small_bt.png',
                large='http://www.bt.no/external/btfrontthumb/large_bt.png',
                transition = mno.features.transition,
                orgSize=container.width();


                el.attr('src', small)
                    .bind('click', function (e) {
                        if (el.hasClass('largeImg')) {
                            if (transition !== false) {
                                el.removeClass('largeImg')
                                    .css('width', orgSize + 'px')
                                    .attr('src',small);
                            } else {
                                el.stop()
                                    .removeClass('largeImg')
                                    .animate({width:orgSize + 'px'}, 500, 'easeInOutElastic', function () {
                                        el.attr('src',small);
                                    });
                            }
                        }else  {
                            var img = new Image();
                            img.src = large;
                            if (transition !== false) {
                                el.addClass('largeImg animate').css('width', '980px');
                                jQuery(img).bind('load',function () {
                                    el.attr('src', large);
                                })
                            } else {
                                el.stop()
                                    .addClass('largeImg')
                                    .animate({width:'980px'}, 250, 'easeInOutElastic', function () {
                                        el.attr('src',large);
                                        img=null;
                                    });
                            }
                        }
                        return false;
                    });

                    container.append(el);
                    container.append('<a class="previewLink" href="http://www.bt.no">G&aring; til siden</a>');

        }

        function init() {
            getThumb(); /* TODO Lage denne generisk */
        }

        function destroy() {

        }

        return {
            init:init,
            destroy:destroy
        }
    }
});
mno.core.register({
    id:'widget.relatedContents.flyout',
    creator: function (sandbox) {
        var windowHeight = $(window).height(),
            windowWidth = $(window).width(),
            footerOffset = $('#footer').offset();

        function slide(el, active) {
            var x = $(window).width()+40;
            if (active === true) {
                x = x - el.outerWidth()-40;
            }

            el.animate({left:x + 'px'}, 250);
        }
        function init() {
            var y = {};
            sandbox.container.each(function(i) {
                var $this = $(this),
                    yPos = $(this).position().top,
                    close = $('<span class="close">X</span>');


                y[yPos] = {
                    el:$this,
                    active:false
                };

                close.bind('click', function () {
                    $this.remove();
                    sandbox.ignore('scrollmove');
                });

                $this.prepend(close);

                $this.appendTo('body').css({
                    left:(windowWidth+40) + 'px'
                }).addClass('active');
            });

            sandbox.listen({
                'scrollmove': function (data) {
                    for (var i in y) {
                        if ((data.y > i-(windowHeight/2)) && (data.y < footerOffset.top)) {
                            if (y[i]['active'] === false) {
                                slide(y[i]['el'], true);
                            }
                            y[i]['active'] = true;
                        } else if (y[i]['active'] === true) {
                            slide(y[i]['el'], false);
                            y[i]['active'] = false;
                        }
                    }
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
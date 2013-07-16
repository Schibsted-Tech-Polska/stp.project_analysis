mno.core.register({
    id: 'widget.slideshow.mobileSlideshowList',
    extend: ['widget.slideshow.mobileSlideshow'],
    creator: function (sandbox) {
        var $ = sandbox.$;
        return {
            init: function(){
                this.helper(sandbox);
            },
            destroy: function(){
                var $ = null;

            }
        };
    }
});

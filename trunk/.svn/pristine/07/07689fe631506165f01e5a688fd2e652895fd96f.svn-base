mno.core.register({
    id:'widget.slideshow.mobileSlideshow',
    extend:['widget.slideshow.main'],
    creator: function (sandbox) {
        function init() {
            this.slideshow(sandbox.container);
            if(sandbox.container){
                sandbox.container.each(function(i,element){
                    var $element = $(element);
                    $element.find('span.caption-inner').each(function(i,captionInnerElement){
                        var $captionInnerElement = $(captionInnerElement),
                            capHeight = $captionInnerElement.outerHeight(),
                            capWidth = $captionInnerElement.outerWidth();
                        $captionInnerElement.next('.background').css({
                            height: (capHeight + 5) + 'px',
                            width: (capWidth + 10) + 'px'
                        });
                    });
                });
            }
        }

        function destroy () {

        }

        return {
            init:init,
            destroy:destroy
        }
    }
});
mno.core.register({
    id:'widget.slideshow.default',
    extend:['widget.slideshow.main','mno.utils.flash'],
    creator: function (sandbox) {
        function init() {
            var runFlash = this.showFlash;
            if(sandbox.container){
                sandbox.container.each(function(i, element){
                    var model = sandbox.model[i];
                    if(model.flashArticles !== undefined) {
                        jQuery.each(model.flashArticles, function(j, flash){
                            if($('#'+flash.elementId)!==undefined){
                                $('#'+flash.elementId).parent().height(flash.height);
                                runFlash(flash);
                                if(flash.caption!==undefined && flash.caption!==''){
                                    sandbox.render('widgets.slideshow.view.caption', {caption:flash.caption}, function(html){
                                        $('#'+flash.elementId).parent().append(html);
                                    });
                                }
                            }
                        });
                    }
                });
                this.slideshow(sandbox.container);
            }
        }

        function destroy() {

        }

        return {
            init:init,
            destroy:destroy
        }
    }
});
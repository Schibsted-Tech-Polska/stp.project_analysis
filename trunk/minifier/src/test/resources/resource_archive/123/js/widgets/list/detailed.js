
mno.core.register({
    id:'widget.list.detailed',
    extend:['mno.utils.flash'],
    creator: function (sandbox) {
        var $ = sandbox.$;
        var runFlash;

        function init(){
            runFlash = this.showFlash;

            if (sandbox.container) {
                sandbox.container.each(function(i, element){
                    var model = sandbox.model[i];

                    if(model.storiesWithFlash !== undefined) {
                        jQuery.each(model.storiesWithFlash, function(j, article){
                            jQuery.each(article, function(k, flash){
                                runFlash(flash[0]);
                            });
                        });
                    }
                });                                                                                                                                                                 //
            }
        }

        function destroy() {
            $ = null;
        }

        return  {
            init: init,
            destroy: destroy
        };

    }
});
mno.core.register({
    id:'widget.relatedContents.pictures',
    extend:['mno.utils.flash'],
    creator: function (sandbox) {
        var $ = sandbox.$;

        function init() {
            var runThis = this.showFlash;
            if (sandbox.container) {
                sandbox.container.each(function(i, element){
                    var model = sandbox.model[i];
                    if(model.flashArticles !== undefined) {
                        jQuery.each(model.flashArticles, function(j, flash){
                           runThis(flash);
                        });
                    }

                    /*$('.photo').mnoExpand({ -------buggy. ingenting skjer i ff, og i chrome blir bildeteksten for liten ved pageload og rare ting skjer på klikk (expand) ---
                        content: {
                            location:{
                                attr:'data-picture-original'
                            },
                            type:'image'
                        },
                        direction:'left',
                        originalWidth: 4,
                        expandedWidth: 10
                    });*/
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
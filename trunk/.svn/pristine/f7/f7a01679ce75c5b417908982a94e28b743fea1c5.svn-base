mno.core.register({
    id:'widget.multimediaContent.default',
    extend:['mno.utils.flash'],
    creator: function (sandbox) {
        function init() {
            var runFlash = this.showFlash;
            if(sandbox.container){
                sandbox.container.each(function(i, element){
                    var model = sandbox.model[i];
                    if(model.flashContent !== undefined) {
                        if($('#'+model.flashContent.elementId)!==undefined){
                            $('#'+model.flashContent.elementId).parent().height(model.flashContent.height);
                            runFlash(model.flashContent);
                        }
                    }
                });
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
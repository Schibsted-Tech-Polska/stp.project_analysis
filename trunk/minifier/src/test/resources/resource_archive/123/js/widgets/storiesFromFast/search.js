mno.core.register({
    id:'widget.storiesFromFast.search',
    extend:['widget.stories.default'],
    creator: function (sandbox) {
        var $ = sandbox.$;

        function init() {
            var runThis = this.helper;
            if(sandbox.container){
                runThis(sandbox);
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
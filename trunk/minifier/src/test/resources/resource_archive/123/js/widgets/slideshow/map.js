mno.core.register({
    id:'widget.slideshow.map',
    extend:['widget.map.default'],
    creator:function (sandbox) {

        function init() {
            var that = this;

            sandbox.listen({
                'gapiReady':function () {
                    if(sandbox.container != null){
                        setTimeout(function () {
                            sandbox.container.each(function (i) {
                                that.helper($(this), sandbox.model[i]);
                            });
                        },15);
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
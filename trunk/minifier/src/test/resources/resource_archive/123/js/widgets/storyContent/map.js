mno.core.register({
    id:'widget.storyContent.map',
    extend:['widget.map.default'],
    creator:function (sandbox) {

        function init() {
            var that = this;
            sandbox.listen({
                'gapiReady':function () {
                    setTimeout(function () {
                        that.helper(sandbox);
                    }, 15);
                }
            });
        }

        function destroy() {}

        return {
            init:init,
            destroy:destroy
        };
    }
});
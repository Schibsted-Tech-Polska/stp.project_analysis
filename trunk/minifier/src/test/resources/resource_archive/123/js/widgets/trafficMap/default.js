mno.core.register({
    id:'widget.trafficMap.default',
    extend:['widget.map.default'],
    creator:function (sandbox) {

        function init() {
            var that = this;

            sandbox.listen({
                'gapiReady':function () {
                    setTimeout(function () {

                        that.helper(sandbox);
                    },15);
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
mno.core.register({
    id:'widget.currencyCalc.frontpage',
    extend: ['widget.currencyCalc.calculator'],
    creator: function (sandbox) {
        return {
            init: function() {
                if(sandbox.container){
                    this.helper(sandbox);
                }
            },

            destroy: function() {
                $ = null;
            }
        };
    }
});
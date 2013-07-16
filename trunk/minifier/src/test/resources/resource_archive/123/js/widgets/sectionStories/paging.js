mno.core.register({
    id:'widget.sectionStories.paging',
    creator: function (sandbox) {

        function init() {
            var $ = sandbox.$;
            sandbox.container.find("a").bind("click",function(e){
                e.stopPropagation();
                e.preventDefault();
                // Send a notification to load more data..
                sandbox.notify({
                    type:'section-navigator-loadmore',
                    data:{
                        param1:'more',
                        e:e
                    }
                });
            });
            // Load the list upon init...
        }

        return {
            init: init,
            destroy: function() {
            }
        };
    }
});
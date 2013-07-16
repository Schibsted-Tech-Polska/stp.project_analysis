mno.core.register({
    id:'widget.contentSearch.navigators',
    /*require:['mno.utils.tree'],*/
    creator: function(sandbox) {
        function init() {
            var $ = sandbox.$;

            if(sandbox.container){
                sandbox.container.find('li.leaf a').click(function(e){
                    var $this = $(this);
                    e.preventDefault();
                    sandbox.notify({
                        type:'contentSearch-navigator-change',
                        data:{
                            param1:$this.attr('data-navigate-param1'),
                            param2:$this.attr('data-navigate-param2'),
                            e:e
                        }
                    });

                    return false;
                });
            }

            sandbox.container.find('.navigator').mnoTree();
            sandbox.container.show(250);
        }

        function destroy() {

        }

        return {
            init:init,
            destroy:destroy
        };
    }
});
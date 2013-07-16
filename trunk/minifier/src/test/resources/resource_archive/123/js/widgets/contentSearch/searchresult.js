mno.core.register({
    id: 'widget.contentSearch.searchresult',
    creator: function (sandbox) {
        function init() {
            var $ = sandbox.$;



            $('a[data-paging-param]').click(function(){
                var $this = $(this);
                sandbox.notify({
                    type:'contentSearch-paging-change',
                    data:{
                        param1:$this.attr('data-paging-param')

                    }
                });
                return false;
            });

            sandbox.container.find('.paging').mnoTree();
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

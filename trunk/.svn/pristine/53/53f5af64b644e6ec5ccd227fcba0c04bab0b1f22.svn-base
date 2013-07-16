mno.core.register({
    id:'widget.list.tabList',
    creator: function (sandbox) {

        var $ = sandbox.$;

        function init() {
            if(sandbox.container){
                sandbox.container.each(function(i,element){
                    var element = $(element);
                    element.find('ul.tabs a').click(function(e){
                        e.preventDefault();
                        var $this = $(this),
                            anchorAttr = $this.attr('href'),
                            tabClass = '.' + anchorAttr.replace('#', '');
                        element.find('ul.tabs li').removeClass("ui-state-active");
                        $this.closest('li').addClass("ui-state-active");
                        element.find('.content').addClass('ui-tabs-hide');
                        element.find(tabClass).removeClass('ui-tabs-hide');

                    });
                });
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
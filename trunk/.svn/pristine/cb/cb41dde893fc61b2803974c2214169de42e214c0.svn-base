mno.core.register({
    id:'widget.list.accordionList',
    creator: function (sandbox) {

        var $ = sandbox.$;

        function init() {
            $('.accordionContent').hide(0);

            sandbox.container.each(function () {
                var $this= $(this);
                $this.find('.accordionContent:eq(0)').show(0);
                $('.accordionHandle').bind('click', function () {
                    var active = $(this).next();
                    $this.find('.accordionContent').not(active).slideUp(250);
                    active.slideDown(250);
                });
            });
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
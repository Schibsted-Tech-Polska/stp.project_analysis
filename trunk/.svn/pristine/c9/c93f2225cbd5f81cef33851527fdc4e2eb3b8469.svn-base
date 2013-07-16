mno.core.register({
    id:'widget.sprekSearch.default',
    creator:function (sandbox) {
        function init() {
            sandbox.container.find('.helpText a').bind('click', function () {
                sandbox.container.find('.search').val($('this').text());
                sandbox.container.submit();
                return false;
            });
        }

        function destroy() {

        }

        return {
            init:init,
            destroy:destroy
        }
    }
});
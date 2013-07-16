mno.core.register({
    id:'widget.code.template.common.taxSearch.taxSearch.jsp',
    creator: function (sandbox) {
        return {
            init: function() {
                sandbox.container.each(function(i, element){
                       $('#doTaxSearchX').parents('form').bind('submit',function () {
                           if($('.givenname').val() == 'Fornavn'){
                               $('.givenname').val('');
                           }
                           if($('.surname').val() == 'Etternavn'){
                               $('.surname').val('');
                           }
                       });
                })
            },

            destroy: function() {
                $ = null;
            }
        };
    }
});


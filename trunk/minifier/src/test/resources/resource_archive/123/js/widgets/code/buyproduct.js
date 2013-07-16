mno.core.register({
    id:'widget.code.template.common.paywall.buyproduct.jsp',
    creator: function (sandbox) {
        return {
            init: function() {
                sandbox.listen({
                    'access-change': function(data) {
                        if(data.status === 'true'){
                            // Call rewriteAnchorTag when an stored article is modified
                            $('#productList').addClass('hasAccess')
                        } else {
                            // Call rewriteAnchorTag when an stored article is modified
                            $('#productList').addClass('hasNotAccess')
                        }
                        // Turn of dialog when loggedIn.
                        if(VGS.getSession() != null){
                               $('.mobileLogin').html('');
                               $('.webLogin').html('');
                        }
                    }
                });

                // If Google analytics is defined, - we push the url to the GA array
//                if(typeof _gaq !== 'undefined'){
//                    $('.productList li a').each(function(){
//                        $(this).bind('click', function(e){
//                            e.preventDefault();
//                            e.stopPropagation();
//                            _gaq.push('_link',$(this).attr('href'));
//                            window.location.href=$(this).attr('href');
//                        } );
//                    });
//                }
            },
            destroy: function() {
                $ = null;
            }
        };
    }
});
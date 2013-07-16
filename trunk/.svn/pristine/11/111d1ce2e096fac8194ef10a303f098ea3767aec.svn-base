mno.core.register({
    id:'widget.sectionStories.sectionNavigator',
    creator: function (sandbox) {

        function init() {
            var $ = sandbox.$;
            var hostPublicationUrl = sandbox.model[0].hostPublicationUrl;

            // Load the list upon init...
            sandbox.container.find('a').each(
                    function(e) {
                        // Extracting the section unique name from the href
                        var anchor = $(this).attr('href').replace(hostPublicationUrl, '').replace(/\//g,'');
                        $(this).attr('href','').attr('target', '').attr('data-section-name',anchor).bind('click',
                                function(e) {
                                    e.stopPropagation();
                                    e.preventDefault();
                                    sandbox.notify({
                                        type:'section-navigator-change',
                                        data:{
                                            param1:anchor,
                                            e:e
                                        }
                                    });
                                    sandbox.container.find('li').each(function(e){
                                        $(this).removeClass('activeSection');
                                    });
                                    $(this).parent().addClass('activeSection');
                                });
                    });
            // Make the initial loaded section selected
            sandbox.listen({
                'sectionstories-section-init': function(data) {
                    sandbox.container.find('a').each(
                            function(e){
                                $(this).parent().removeClass('activeSection');
                                if($(this).attr('data-section-name') === data.section){
                                    $(this).parent().addClass('activeSection');
                                }
                            }
                    );
                }
            });

        }

        return {
            init: init,
            destroy: function() {
                //var $ = null;
            }
        };
    }
});
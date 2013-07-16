mno.core.register({
    id:'widget.storedArticles.listArticles',
    creator: function (sandbox) {
        var mndApiEndpoint, dropDown = false;
        mndApiEndpoint = sandbox.model[0].mndApiEndpoint;

        // Listen to nofification when click on Vis lagrede artikler is issued.
        sandbox.listen({
            'showarticles-change': function(data) {
                mno.core.log(1, data);

                if (typeof(data.e) == 'object') {
                    data.e.stopPropagation();
                    data.e.preventDefault();
                }
                $.ajax({
                    type:'get',
                    url: '/?service=widget&widget=storedArticles&view=listArticles&contentId=2180986' +
                            '&ajax=true&rnd=' + Math.floor(Math.random() * 1111111111111) + '&uid=' + VGS.getSession().userId,
                    success:function (html) {
                        var $html = $(html);
                        if (html.length > 0) {
                            // Bind a click event to the delete urls in the article list
                            $html.find('.delete').bind('click', function () {
                                // Resolve the articleId
                                var id = $(this).attr('data-article-id');
                                sandbox.notify({
                                    type:'delete-article',
                                    data:{id:id
                                    }
                                });
                            });

                            if (dropDown === false && data.trigger !== undefined) {
                                dropDown = mno.utils.dropdown({
                                    content: $html,
                                    close:true,
                                    trigger:data.trigger,
                                    autoOpen:true
                                });
                            } else if (dropDown !== false) {
                                dropDown.update($html);
                                if (data.trigger !== undefined) {
                                    dropDown.toggle();
                                }
                            }

                            sandbox.notify({
                                type:'dialog-close',
                                data:{
                                    id:sandbox.moduleId
                                }
                            });
                            // Close any open lightbox
                            sandbox.listen({
                                'dialog-close': function(data) {
                                    if (data.id !== sandbox.moduleId && dropDown !== false) {
                                        dropDown.close();
                                    }
                                }
                            });
                        } else {
                            if (dropDown !== false) {
                                dropDown.close();
                            }
                        }
                    }
                });
            }
        });

        function init() {
            var $ = sandbox.$;
            //
        }

        return {
            init: init,
            destroy: function() {
                //var $ = null;
            }
        };
    }
});
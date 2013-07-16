mno.core.register({
    id:'widget.storedArticles.storedArticlesTrigger',
    creator: function (sandbox) {
        var paywallEnabled,mndApiEndpoint, hasAccess = false;

        sandbox.listen({
            'access-change': function(data) {
                // Call rewriteAnchorTag when an stored article is modified
                if (data.status == 'true') {
                    storedArticlesHandler()
                } else {
                    sandbox.container.find('a').unbind('click');
                    sandbox.container.find('a').bind('click', function(e) {
                        e.preventDefault();
                        e.stopPropagation();
                        alertMessage("Du må være <span class=\"f-bold\">innlogget</span> og <span class=\"f-bold\">abonnent</span> for å få tilgang til lagrede artikler <span class=\"icon f-blue\">f</span>");
                    });
                }
            }
        });

        /**
         * Resolves Schibsted Payment id and displayname.
         *
         * @param response http response
         */
        function storedArticlesHandler() {
            rewriteAnchorTag();
            // Initialize listeners when the user is logged in..
            if (sandbox.container) {
                sandbox.container.find('a').unbind('click');
                sandbox.container.find('a').bind('click', function(e) {
                    var $this = $(this);
                    e.preventDefault();
                        sandbox.notify({
                            type:'showarticles-change',
                            data:{
                                param1:1,
                                e:e,
                                trigger:$this
                            }
                        });
                    return false;
                });
                sandbox.ignore('showarticles-change');
                sandbox.listen({
                    'showarticles-change': function(data) {
                        rewriteAnchorTag();
                    }
                });
                sandbox.ignore('save-article');
                sandbox.listen({
                    'save-article': function(data) {
                        saveArticle(data.id);
                    }
                });
                sandbox.listen({
                    'delete-article': function(data) {
                        deleteArticle(data.id);
                    }
                });
            }
        }

        function rewriteAnchorTag() {
            // Fetch any stored articles from the db with json
            if(paywallEnabled == 'true'){
                sandbox.getScript({
                    url:mndApiEndpoint + "/user/" + VGS.getSession().userId + ".jsonp?rnd=" + Math.floor(Math.random() * 1111111111111),
                    jsonP: function(data) {
                        handleJsonResponse(data);
                    }
                });
            }
        }

        /**
         * Modify the "Vis x lagrede artikler" when changes happens to the stored articles db.
         *
         * @param data the json feed
         */
        function handleJsonResponse(data) {
            if (VGS.getSession() != null) {
                if (data.user != undefined && data.user.storageItem != undefined && data.user.storageItem.length >= 0) {
                    sandbox.container.find('.count').text(data.user.storageItem.length);
                }
            }
        }


        /**
         * Save article
         *
         * @param articleId
         */
        function saveArticle(articleId) {
            sandbox.getScript({
                url: mndApiEndpoint + "/user/" + VGS.getSession().userId + "/storage/articles.jsonp?articleid=" + articleId + "&action=save&rnd=" + Math.floor(Math.random() * 1111111111111),
                jsonP: function (data) {
                    if (data.integer == 2) {
                        // The article is already save, show an info box.
                        //showAlreadySavedBox(sandbox.model);
                    } else {
                        sandbox.container.find('.saveArticle').addClass('saved');
                    }
                    // Notifies listeners to update any info.
                    sandbox.notify({
                        type:'showarticles-change',
                        data:{param1:0
                        }
                    });

                    if (data.integer == 3) {
                        sandbox.container.find('a').addClass('active animate alert');
                    } else {
                        sandbox.container.find('a').removeClass('alert').addClass('active animate');
                    }

                    setTimeout(function(){
                        sandbox.container.find('a').removeClass('active');
                    },600);
                }
            })
        }

        function deleteArticle(articleId) {
            sandbox.getScript({
                url: mndApiEndpoint + "/user/" + VGS.getSession().userId + "/storage/" + articleId + ".jsonp?action=delete&rnd=" + Math.floor(Math.random() * 1111111111111),
                jsonP: function(data) {
                    // Notify to update the url.
                    sandbox.notify({
                        type:'showarticles-change',
                        data:{param1:0
                        }
                    });
                }
            });

        }

        function alertMessage(text) {
            var item = {text: text};
            sandbox.render('widgets.storedArticles.views.alert', item, function (html) {
                var dialog;
                // Register a listener to catch the confirm from the popup window.
                html.find('.ok').on('click', function () {
                    // Do nothing
                    html.remove();
                    dialog.close();
                });
                dialog = mno.utils.dialog({content:html});
            });
        }

        function init() {
            var $ = sandbox.$;
            mndApiEndpoint = sandbox.model[0].mndApiEndpoint;
            paywallEnabled = sandbox.model[0].paywallEnabled;
            // Subscribe to events from the Schibsted Payment API (SP)
//            VGS.Event.subscribe('auth.sessionChange', processUserInfo);
            if (sandbox.container) {
                sandbox.container.find('a').bind('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    alertMessage("Du må være <span class=\"f-bold\">innlogget</span> og <span class=\"f-bold\">abonnent</span> for å få tilgang til lagrede artikler <span class=\"icon f-blue\">f</span>");
                });
            }
        }

        return {
            init: init,
            destroy: function() {
                //var $ = null;
            }

        };
    }
});
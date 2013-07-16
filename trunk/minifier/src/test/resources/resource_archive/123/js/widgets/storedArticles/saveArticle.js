/**
 * Handles processing of the "Lagre artikkel" url
 */
mno.core.register({
    id:'widget.storedArticles.saveArticle',
    creator: function (sandbox) {
        var uid, displayname, mndApiEndpoint;

        /**
         * Fetch the uid and displayname when a Schibsted Payment session is detected.
         *
         * @param response
         */
        function processUserInfo(response) {
            if (response != undefined && typeof (response.session) != 'undefined' && response.session != null && response.session != false) {
                uid = VGS.getSession().userId;
                displayname = VGS.getSession().displayName;
                sandbox.container.html("Lagre");
                // Handling click on the save article url
                sandbox.container.bind('click',function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    sandbox.notify({
                        type:'save-article',
                        data:{
                            id:mno.model.article.id,
                            e:e
                        }
                    });
                    $(this).addClass('saved');
                    sandbox.container.html("Lagret");
                });
            }
        }

        function showAlreadySavedBox(model) {
            // Renders a popup confirm window with Jquery templates.
            sandbox.render('widgets.storedArticles.views.saveWindow', {artId: mno.model.article.id}, function (html) {
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
            // Subscribe to events from the Schibsted Payment API (SP)
            VGS.Event.subscribe('auth.sessionChange', processUserInfo);
        }

        return {
            init: init,
            destroy: function() {
                //var $ = null;
            }

        };
    }
});
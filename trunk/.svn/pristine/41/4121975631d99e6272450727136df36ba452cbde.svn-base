mno.core.register({
    id:'widget.paywall.actionList',
    creator: function (sandbox) {
        var hostPublicationUrl = sandbox.model[0].hostPublicationUrl,
            paywallServerUrl = sandbox.model[0].paywallServerUrl,
            dropDown = false, accessState = -1; // -1 = not logged in, 0 = logged in not access, 1 = logged in and access

        function init() {
            // Assign the value of the selectbox upon change.
            sandbox.container.find('select').on('change', function () {
                if ($(this).val()) {
                    window.location.href= $(this).val();
                }
            });

            // If we receive a username-clicked notification
            sandbox.listen({
                'username-clicked': function(data) {
                    sandbox.notify({
                        type:'dialog-close',
                        data:{
                            id:sandbox.moduleId
                        }
                    });

                    if (dropDown === false) {
                        if(accessState === 0){
                            // If the user is logged on, - but has not access.

                        } else if(accessState === 1){
                            // If the user is logged on, - and has access, - we remove the message
                            sandbox.container.find('h3').text(VGS.getSession().displayName);

                            // Add an upgrade subscription button as the user has already access.
                            sandbox.container.find('.existingAccount').removeClass('hidden').addClass('block');
                            sandbox.container.find('a.upgrade').bind('click',function(e){
                                e.preventDefault();
                                e.stopPropagation();
                                document.location.href=$(this).attr('data-href');
                            });
                            mno.utils.form.select(sandbox.container);
                        }

                        dropDown = mno.utils.dropdown({
                            trigger: data.trigger,
                            close:true,
                            content: sandbox.container
                        });
                    }
                    dropDown.setTrigger(data.trigger);
                    dropDown.toggle();
                }
            });
            sandbox.listen({
                'access-change': function(data) {
                    if(data.status === 'false'){
                        sandbox.container.removeClass("hasAccess").addClass("hasNotAccess");
                        hasAccess = false;
                    } else {
                        sandbox.container.removeClass("hasNotAccess").addClass("hasAccess");
                        hasAccess = true;
                    }
                }
            });

            // Close any open lightbox
            sandbox.listen({
                'dialog-close': function(data) {
                    if(data.id !== sandbox.moduleId && dropDown !== false){
                        dropDown.close();
                    }
                }
            });
            // Listen to events when the user logs in.
            sandbox.listen({
                'access-change': function(data) {
                    if(data.status === 'true'){
                        accessState = 1; // has access
                    } else {
                        accessState = 0; // has not access
                    }
                }
            });

            /*sandbox.container.find(".profile").unbind('click.profile');
            sandbox.container.find(".profile").bind('click.profile', function (e) {
                window.location = VGS.getAccountURI().replace(window.location.toString(), hostPublicationUrl + '/paywall/pwrd.jsp?redirect=' + Base64.encode(window.location.toString()));
                e.preventDefault();
            });*/
            sandbox.container.find(".register").bind('click.register');
            sandbox.container.find(".register").bind('click.register', function (e) {
                window.location = VGS.getSignupURI().replace(window.location.toString(), hostPublicationUrl + '/paywall/pwrd.jsp?redirect=' + Base64.encode(window.location.toString()));
                e.preventDefault();
            });
            sandbox.container.find(".login").unbind('click.login');
            sandbox.container.find(".login").bind('click.login', function (e) {
                // Putting a random parameter on the end of the current page url, provoking retrieval of a unique page
//                window.location.href = VGS.getLoginURI();
                window.location = VGS.getLoginURI().replace(window.location.toString(), hostPublicationUrl + '/paywall/pwrd.jsp?redirect=' + Base64.encode(window.location.toString()));
                e.preventDefault();
            });
            sandbox.container.find(".logout").bind('click', function (e) {
                mno.core.log(1, 'Logout button clicked');
                // Resetting the cookie
//                VGS.Cookie.set(null);
                VGS.Cookie.clear();
                // Upon logout, - the user is redirected to the current page
                window.location.href=paywallServerUrl+'/logout?redirect_uri='+hostPublicationUrl+'/paywall/logout.jsp?redirect=' + Base64.encode('/');
                e.preventDefault();
            });
        }

        return {
            init: init,
            destroy: function() {
            }
        };
    }
});
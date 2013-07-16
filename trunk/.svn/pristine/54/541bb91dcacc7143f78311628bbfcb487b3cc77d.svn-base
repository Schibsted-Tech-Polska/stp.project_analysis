mno.core.register({
    id:'widget.paywall.default',
    creator: function (sandbox) {
        var paywallEnabled,
            paywallProductCode,
            paywallProductionMode,
            publicationURL,
            hostPublicationUrl,
            paywallClientId,
            paywallApiUrl,
            logging,
            started = false,
            displayName,
            getAccessUrl,
            upgradeSubUrl,
            previewMode,
            paywallServerUrl = sandbox.model[0].paywallServerUrl,
            paywallLaunchUrl = sandbox.model[0].paywallLaunchUrl;

        function cbCheckSubscription(response) {
            var jsDebug = mno.utils.params.getParameter("jsDebug");
            var ready = true;
            // Truncate the displayname if more than 20 characters
            if(displayName.length > 13){
                sandbox.container.find('.userAccount .text').attr('title',displayName).html(displayName.substring(0,10)+'&hellip;');
            } else {
                sandbox.container.find('.userAccount .text').text(displayName);
            }

            if (response.result === true) {
                if (jsDebug === 'true' && $('div').hasClass('debugBar') == false) {
                    sandbox.render('widgets.paywall.views.infoBar', {
                        type:'debug',
                        text:'X-files: Har tilgang',
                        href:'#'
                    }, function ($html) {
                        $('#topArea').append($html);
                    });
                }
                hasAccess();
                sandbox.container.find('.login').addClass('hidden').removeClass('inline');
                if(previewMode === 'true'){
                    ready = false;
                    document.location.href = document.location.href.replace('?service=preview','');
                }
            } else {
                if (jsDebug === 'true' && $('div').hasClass('debugBar') == false) {
                    sandbox.render('widgets.paywall.views.infoBar', {
                        type:'debug',
                        'text':'X-files: Har IKKE tilgang',
                        href:'#'
                    }, function ($html) {
                        $('#topArea').append($html);
                    });
                }

                addInfoBarLocked();
                hasNotAccess();
                sandbox.container.find('.login').removeClass('hidden').addClass('inline');
            }
            sandbox.container.find('.userAccount').unbind('click.userAccount');
            sandbox.container.find('.userAccount').bind('click.userAccount', function(e) {
                var $this = $(this);
                e.preventDefault();
                sandbox.notify({
                    type:'username-clicked',
                    data:{
                        param1:true,
                        trigger : $this
                    }
                });
            });

            if(ready){
                sandbox.notify({
                    type:'paywall-ready',
                    data:{
                        param1:true,
                        trigger : $(this)
                    }
                });
            }
        }

        function hasAccess() {
            sandbox.notify({
                type:'access-change',
                data:{
                    status:'true'
                }
            });
            $('.lockedBar').remove();
            $('.lockedLine').remove();
            $('.customerMenu').find('.mittabonnement a').unbind('click.register');
            $('body').removeClass('hasNotAccess').addClass('hasAccess');
        }

        function hasNotAccess() {
            $('body').removeClass('hasAccess').addClass('hasNotAccess');
            $('.lockedLine').removeClass('hidden');
            $('.articleLine').remove();
            $('.customerMenu').find('.mittabonnement a').bind('click.register', function (e) {
                window.location = getAccessUrl;
                e.preventDefault();
            });

            sandbox.notify({
                type:'access-change',
                data:{
                    status:'false'
                }
            });

            if(VGS.getSession() != null){
                sandbox.container.find('.login').html("Forleng abonnement").bind('click', function(e){
                    e.stopPropagation();
                    e.preventDefault();
                    window.location = upgradeSubUrl;
                });
            }
            sandbox.notify({
                type:'paywall-ready',
                data:{
                    param1:true,
                    trigger : $(this)
                }
            });
        }

        function addInfoBarLocked() {
            if ($(".lockedBar").length <= 0) {
                sandbox.render('widgets.paywall.views.infoBar', {
                    type: 'locked',
                    text: 'F&aring; full tilgang, f&aring; dybden, alle lokalsakene, kommentere artikler, kom innenfor. Les mer...',
                    href: paywallLaunchUrl
                }, function ($html) {
                    $('#topArea').append($html);
                });
            }
        }

        function removeParameter(url, parameter) {
            var urlparts = url.split('?');

            if (urlparts.length >= 3) {
                var urlBase = urlparts.shift(); //get first part, and remove from array
                var queryString = urlparts.join("?"); //join it back up
                var urlredirparts = queryString.split('?'); // Fetch 2nd parameter
                if (urlredirparts.length > 1) {
                    var redirbase = urlredirparts.shift();
                    var redirQueryString = urlredirparts.join("?");   // Stripping away code appearing in in redirect url.
                    var prefix = encodeURIComponent(parameter) + '=';
                    var pars = redirQueryString.split(/[&;]/g);
                    for (var i = pars.length; i-- > 0;)               //reverse iteration as may be destructive
                        if (pars[i].lastIndexOf(prefix, 0) !== -1)   //idiom for string.startsWith
                            pars.splice(i, 1);
                    var parameters = pars.join('&');
                    url = urlBase + '?' + redirbase + ((parameters.length > 0) ? '?' + parameters : '');
                }
            }
            return url;
        }

        function getLoggedInUser(response) {
            //console.log(response);
            if (typeof (response.session) != 'undefined' && response.session != null && response.session != false) {
                // logged in and connected user
                displayName = response.session.displayName;
                sandbox.container.addClass("user");

                $(".actionList").removeClass("logedout").addClass("logedin");

                VGS.hasProduct(paywallProductCode, cbCheckSubscription);//parrent product
            } else {
                displayName = '';

                addInfoBarLocked();
                hasNotAccess();
                sandbox.container.find('.userAccount .text').text('Logg inn');
                sandbox.container.find('.userAccount').bind('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    window.location = VGS.getLoginURI().replace(window.location.toString(), hostPublicationUrl + '/paywall/pwrd.jsp?redirect=' + Base64.encode(window.location.toString()));
                });

                sandbox.container.find('.login').removeClass('hidden').addClass('inline');
                $(".actionList").removeClass("logedin").addClass("logedout");
                // Force access if the paywall is disabled
            }
        }

        function initApi() {
            if (!started) {
                //console.log("Initializing SP-api");
                VGS.Event.subscribe('auth.sessionChange', getLoggedInUser);
                VGS.init({client_id : paywallClientId,prod:paywallProductionMode,logging:logging,cookie:true,status:true});
                started = true;
            }
        }

        function init() {
            //console.log("loading paywall-widget");
            paywallEnabled = sandbox.model[0].paywallEnabled;
            paywallProductCode = sandbox.model[0].paywallProductCode;
            paywallProductionMode = (sandbox.model[0].paywallProductionMode === 'true');
            publicationURL = sandbox.model[0].publicationURL;
            hostPublicationUrl = sandbox.model[0].hostPublicationUrl;
            paywallClientId = sandbox.model[0].paywallClientId;
            paywallApiUrl = sandbox.model[0].paywallApiUrl;
            logging = (sandbox.model[0].logging === 'true');
            getAccessUrl = sandbox.model[0].gotoAccessPage;
            upgradeSubUrl = sandbox.model[0].upgradeSubUrl;
            previewMode = sandbox.model[0].previewMode;

            sandbox.container.find('.login').bind('click', function(e) {
                var $this = $(this);
                /*
                e.preventDefault();
                sandbox.notify({
                    type:'username-clicked',
                    data:{
                        param1:true,
                        trigger : $this
                    }
                });
                */
                if (getAccessUrl === '') getAccessUrl='#';
                $this.attr('href',getAccessUrl);
            });

            sandbox.listen({
                'all-widgets-loaded': function(data) {
                    //console.log("all-widgets-loaded received -------------");
                    if (paywallEnabled == 'true') {
                        initApi();
                    } else {
                        hasAccess();
                    }
                }
            });
            setTimeout(function() {
                initApi();
            }, 200);
        }

        return {
            init: init,
            destroy: function() {
                //var $ = null;
            }
        };
    }
});
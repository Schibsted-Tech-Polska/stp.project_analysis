/* TODO remove global */
/* $status ,netmeetingEndPoint , articleId , adminId , callback , timer , update , startTimer , $form , */

mno.core.register({
    id:'widget.netmeeting.chat',

    creator: function (sandbox) {
        var $form; // The form in the netmeeting. JQuery object
        var $QA; // The place where the chat content lives. Jquery object
        var $status; // The status of the chat on the page. Jquery object
        var $alias; // The field with the alias for the user. Jquery object
        var netmeetingEndPoint; // The url to the server side of the netmeeting
        var posturl; // Path to post comments
        var statusurl; // Path to get the status for the netmeeting
        var adminId; // TODO: What is this
        var articleId; // The articleid for the article where the netmeeting lives
        var publicationtype; // An id identifying the publication. Used when contacting the server
        var uid; // The user's SPID id
        var displayname; // The user's full name to be displayed on page
        var syncEx = false; // Indicates id an update is going on. To prevent two updates at the same time
        var lastOffset; // The offset for the last comment from server
        var template = 'chatDefinitionList';
        var isMobile = false; // Is the client using the mobile wireframe?
        var nick = "", lastUserOffset = 0,justPosted = false, beepFlag = false,notOnInitial = 0, mndApiEndpoint, chatInitMinutes, hostimage, roleId;

        /* Start the widget */
        function init() {
            if (sandbox.container) {
                sandbox.container.each(function(i, element) {
                    var $ = sandbox.$; // The widget's sandbox
                    var $container = $(element); // The widget's container

                    // Set global variables
                    $form = $container.find('.sendQ');
                    $QA = $container.find('.QA');
                    $status = $container.find('.statusTxt');
                    $alias = $container.find('#alias');
                    posturl = '/nettprat/postchat.htm';
                    statusurl = '/nettprat/chat.htm';
                    netmeetingEndPoint = (typeof sandbox.model[i].netmeetingEndpoint !== "undefined" ? sandbox.model[i].netmeetingEndpoint : 'http://nettprat.aftenposten.no'); // prod = http://nettprat.aftenposten.no/
                    adminId = sandbox.model[i].adminId;
                    articleId = mno.model.article.id;
                    publicationtype = switchPublication(mno.publication.name);
                    isMobile = sandbox.model[i].isMobile;

                    // Global variables. TODO: What are these?
                    mndApiEndpoint = sandbox.model[i].mndApiEndpoint;
                    chatInitMinutes = sandbox.model[i].chatInitMinutes;
                    hostimage = sandbox.model[i].hostimage;

                    // Subscribe to changes in the users session, and call function to process that info.
                    VGS.Event.subscribe('auth.sessionChange', function processUserInfo(response) {
                        if (response != undefined && typeof (response.session) != 'undefined' && response.session != null && response.session != false) {
                            uid = VGS.getSession().userId;
                            displayname = VGS.getSession().displayName;
                            fetchAndShowUserInfo();
                        }
                    });

                    // Check the status of the netmeeting
                    checkStatus();

                    $form.live('submit', function (e) {
                        /* Called when the submit-button is called in the chat form */
                        /* I use "live" so the submit event is last in execution order */
                        post( e );
                    });

                    $container.find('textarea').keydown(function (e) {
                        /* Called when a button is clicked in the textarea. */
                        if (e.keyCode == 13 && $container.find('textarea').val().length > 0) {
                            // The user pressed enter and the textares contains data, so we can post its content to server
                            post( e );
                        }
                    });

                    /* Define what happens when the span with chatroules are clicked */
                    var rules_are_clicked = false;
                    $container.find('span#chatregler a').bind('click', function () {
                        var $this = $container.find('div.chatRulesDisplay');
                        if (!rules_are_clicked) {
                            $this.css('display', 'block');
                            rules_are_clicked = true;
                        } else {
                            $this.css('display', 'none');
                            rules_are_clicked = false;
                        }
                    });

                    /* Define what happens when the X in the chatrules are clicked */
                    $container.find('div.chatRulesDisplay img').bind('click', function () {
                        var $this = $container.find('div.chatRulesDisplay');
                        $this.css('display', 'none');
                        rules_are_clicked = false;
                    });

                    /* Define what happens when the Sound/Mute button is clicked. */
                    $container.find('div.beepSwitch').bind('click', function () {
                        if (beepFlag) {
                            $container.find('div.beepSwitch').addClass('soundMute').removeClass('sound');
                            beepFlag = false;
                        } else {
                            $container.find('div.beepSwitch').addClass('sound').removeClass('soundMute');
                            beepFlag = true;
                        }
                    });
                });
            }
        }

        // Returns a id for the publication based on the publicationname
        // Only used when setting up the widget
        function switchPublication(publicationName) {
            var type = 1;
            switch (publicationName) {
                case 'bt':
                    type = 3;
                    break;
                case 'fvn':
                    type = 5;
                    break;
                case 'sa':
                    type = 4;
                    break;
            }
            return type;
        }

        /* Checks the status of the netmeeting */
        function checkStatus() {
            sandbox.getScript({
                url:netmeetingEndPoint + "/nettprat/statusnettprat.htm?eaid=" + articleId + "&id=" + adminId + "&aType=" + publicationtype + "&rnd=" + Math.floor(Math.random() * 1111111111111),
                jsonP: function(data) {
                    mno.core.log(1, "Checkstatus getscript callback started");
                    try {
                        switch (data.status) {
                            case 'OPEN':
                                $status.html('<strong>Hva mener du?</strong><br/>Still sp&oslash;rsm&aring;l n&aring;!');
                                timer(true);
                                break;
                            case 'LIVE':
                                $status.html('P&aring;g&aring;r n&aring;!');
                                update();
                                timer(true);
                                break;
                            case 'PENDING':
                                $form.remove();
                                $status.html('<strong>Se sp&oslash;rsm&aring;l og svar!</strong><br/>Stengt for nye sp&oslash;rsm&aring;l. Nettgjest besvarer fortsatt sp&oslash;rsm&aring;l.');
                                update();
                                timer(true);
                                break;
                            case 'INACTIVE':
                                $form.remove();
                                $status.html('');
                                timer(false);
                                update();
                                break;
                            case 'FINISHED':
                                $form.remove();
                                $status.html("<strong>Se sp&oslash;rsm&aring;l og svar!</strong><br/>Nettpraten er avsluttet.");
                                update();
                                timer(false);
                                break;
                            default:
                                $form.remove();
                        }
                        $status.addClass(data.status.toLowerCase());
                    } catch(e) {
                        mno.core.log(3, e);
                        if (e.stack) mno.core.log(3, e.stack);
                    }
                }
            });
        }

        /**
         * Updates the thread view / the content of the netmeeting
         */
        function update() {
            // Prevent executing when already executing
            if (syncEx === false) {
                syncEx = true;
                var parameter = '';
                if (lastOffset != undefined) {
                    // Only request new messages since last update
                    parameter = "&offset=" + lastOffset;
                } else {
                    parameter = "&minutes=" + chatInitMinutes;
                }
                // Send request to server
                sandbox.getScript({
                    url:netmeetingEndPoint + statusurl + "?id=" + adminId + "&roleid=" + roleId + parameter + "&rnd=" + Math.floor(Math.random() * 1111111111111),
                    jsonP: function(data) {
                        if (displayname !== undefined && data.length > 0 ) {
                            for (i in data) {
                                if ($.trim(data[i].name) != $.trim(displayname) && beepFlag && data[i].name && notOnInitial == 1) {
                                    // Incoming comment from another user. Play sound
                                    if(soundManager.ok() != undefined)soundManager.play("sound0","/resources/audio/button-37.mp3");
                                }
                            }
                            if (justPosted) {
                                for (i in data) {
                                    if ($.trim(data[i].name) == $.trim(displayname)) {
                                        // The update was done because the user posted.
                                        // Hide the spinner
                                        sandbox.container.find('img.spinner').css('display', 'none');
                                        justPosted = false;
                                    }
                                }
                            }
                        }
                        // Render the listview
                        renderResult(data);
                        notOnInitial = 1;
                        syncEx = false;
                    }
                });
            }

        }

        /* Get the information about the user from the server, and display the name on the page. */
        function fetchAndShowUserInfo() {
            sandbox.getScript({
                url:mndApiEndpoint + "/user/" + uid + "/chat.jsonp?displayname=" + escape(displayname) + "&nickname=" + escape(displayname) + "&rnd=" + Math.floor(Math.random() * 1111111111111),
                jsonP: function(data) {
                    if (data.user != undefined && data.user.chat != undefined && data.user.chat.length > 0 && data.user.chat[0].nickname != undefined && data.user.chat[0].nickname != '') {
                        // Apply the nickname to the alias in the form
                        $alias.html(VGS.getSession().displayName);
                        roleId = data.user.roleId;
                    }
                }
            });
        }

        /* Starts a timer that updates the netmeeting. */
        function timer(start) {
            var timerVar;
            if (start) {
                timerVar = setTimeout(function () {
                    // Update the netmeeting on the users page
                    checkStatus();
                }, 500);
            } else {
                if (timerVar !== undefined) {
                    clearTimeout(timerVar);
                }
            }
        }

        /* Render the data returned from server on the users screen  */
        var renderResult = function () {
            var dlList = []; // Array containing JSON objects for every comment recieved from server
            var initialBottomScrollValueSet = 0;
            var currentBottomScrollValue = 0;
            return function (data) {
                var i;
                data.sort(function(a, b) {
                    // Sorting the chat by id
                    if (a.id > b.id) {
                        return 1
                    } else if (a.id < b.id) {
                        return -1
                    } else {
                        return 0
                    }
                });
                // For each element in the data returned from server, push a JSON to an array
                for (i in data) {
                    if (data.hasOwnProperty(i)) {
                        // Push a JSON object to the array.
                        // This object follows the variablenames used in the template (see template file), which is set globally
                        var json = {di:((data[i].roleid == 9) ? '<img src="' + hostimage + '"/>' : ''),dx:((data[i].roleid == 9) ? 'chatvert' : ''),dm:data[i].message,da:$.trim(data[i].name),dt:data[i].postedtime};
                        // If the chat is beeing viewed on a client
                        if ( isMobile == 'true' ) dlList.unshift(json);
                        else dlList.push(json);
                        // Remember the last message handled
                        lastOffset = data[i].id;
                    }
                }
                // Get HTML for the comments in the chat
                sandbox.render(template, dlList, function (data) {
                    // Put the html on the correct div
                    $QA.html(data);

                    if (initialBottomScrollValueSet == 0 || $QA.scrollTop() >= currentBottomScrollValue) {
                        $QA.prop({ scrollTop: $QA.prop("scrollHeight") });
                        $QA.css('padding-top', '10px');
                        currentBottomScrollValue = $QA.scrollTop();
                        initialBottomScrollValueSet = 1;
                    }
                });
            }
        }();

        $('[placeholder]').focus(
                function() {
                    var input = $(this);
                    if (input.val() == input.attr('placeholder')) {
                        input.val('');
                        input.removeClass('placeholder');
                    }
                }).blur(
                function() {
                    var input = $(this);
                    if (input.val() == '' || input.val() == input.attr('placeholder')) {
                        input.addClass('placeholder');
                        input.val(input.attr('placeholder'));
                    }
                }).blur();

        function questionResponse(data) {
            //mno.core.log(1,data);
            if (data !== undefined && data['boolean']) {
                // Perform update after a submit
                update();
            } else {
                //alert('Det oppsto en feil!');
            }
        }

        /* Post the content of the form to the server. Takes an event as a parameter. */
        function post( e ) {
            e.preventDefault();
            var textarea = sandbox.container.find('textarea');
            var useralias = sandbox.container.find('#alias').html();
            var useremail = sandbox.container.find('#mail').val();
            if ((!$form.hasClass('error')) && textarea.val().length > 0) {
                // The textfield contains text, so we can post to server
                // Show the spinner indicationg that a post is going on
                sandbox.container.find('img.spinner').css('display', 'block');

                // TODO: What is this
                lastUserOffset = lastOffset;
                justPosted = true;

                //$('textarea.chatTextArea').focus();
                sandbox.getScript({
                    url:netmeetingEndPoint + posturl + '?id=' + adminId + '&roleid=' + roleId + '&name=' + encodeURIComponent(useralias) + "&email=" + useremail + "&msg=" + encodeURIComponent(textarea.val()) + '&rnd=' + Math.floor(Math.random() * 1111111111111),
                    jsonP: questionResponse
                });
                // Clear the content of the textarea
                textarea.val("");
            }
        }

        function destroy() {}

        return  {
            init: init,
            destroy: destroy
        };

    }
});
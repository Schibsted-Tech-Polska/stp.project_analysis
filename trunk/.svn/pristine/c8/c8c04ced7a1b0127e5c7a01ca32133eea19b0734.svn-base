/**
 * LiveStudio Widget Input view
 *
 * @copyright Schibsted
 * @package mno.widgets
 * @subpackage livestudio
 * @author michal.skinder@medianorge.no
 * @description
 * Form view of LiveStudio widget, can exist in multiple instances.
 * The basic HTML of form and all neccessary elements is defined in JSPs.
 * The script binds JSONP request upon form submitting and then processes all the stuff with messages, validation.
 *
 */
mno.core.register({

    id: 'widget.livestudio.input',

    creator: function (sandbox) {

        function init() {

            if (sandbox.container) {
                sandbox.container.each(function (i, element) {
                    var model = sandbox.model[i];
                    var $container = $(element);
                    var $form = $container;
                    var $notification = $form.find('.postNotification'),
                        $aliasNotification = $form.find('.notificationAlias'),
                        $emailNotification = $form.find('.notificationEmail'),
                        $messageNotification = $form.find('.notificationMessage'),
                        $alias = $form.find('input.postAlias'),
                        $email = $form.find('input.postEmail'),
                        $button = $form.find('input.postButton'),
                        $message = $form.find('textarea.postMessage'),
                        $loading = $form.find('.preloader'),
                        callbackFired = false, //this one is needed for error handling
                        labels = {
                            'failure': 'Systemfeil, melding ble ikke sendt.',
                            'validation': 'Feltene inneholder feil.',
                            'success': 'Takk for ditt innspill',
                            'expired': 'Melding ble ikke sendt, mottak av meldinger er stoppet.',
                            'fields': {
                                'alias': 'Feltet kan ikke være tomt.',
                                'email': 'Feil i epost felt.',
                                'message': 'Meldings feltet kan ikke være tomt.'
                            },
                            'defaults': {
                                'alias': 'Navn',
                                'email': 'E-post',
                                'message': 'Meldung'
                            }
                        },
                        dismissDelay = 250, //minimum delay between form submissions
                        delay = (function () {
                            var timer = 0;
                            return function (callback, ms) {
                                clearTimeout(timer);
                                timer = setTimeout(callback, ms);
                            };
                        }());

                    //input view should be removed if stream changed its status
                    sandbox.listen({
                        'livestudio-status': function (data) {
                            if (data.status === 'finished' || data.status === 'inactive' || data.status === 'pending') {
                                $container.fadeOut().detach();
                            }
                        }
                    });


                    $form.find("[placeholder]").focus(function() {
                        var input = $(this);
                        if (input.val() === input.attr("placeholder")) {
                            input.val('');
                            input.removeClass("placeholder");
                        }
                    }).blur(function() {
                            var input = $(this);
                            if (input.val() === '' || input.val() == input.attr("placeholder")) {
                                input.addClass("placeholder");
                                input.val(input.attr("placeholder"));
                            }
                    }).blur();

                    $form.bind('submit', function (event) {
                        event.preventDefault();

                        $(this).find("[placeholder]").each(function() {
                            var input = $(this);
                            if (input.val() === input.attr("placeholder")) {
                                input.val('');
                            }
                        });


                        //using closure to prevent spamming
                        delay(function () {
                            doRequest();
                        }, dismissDelay);

                        return false;
                    });

                    function doRequest() {

                        $loading.show();

                        //hide all previous messages and notifications
                        $notification.html('');
                        $aliasNotification.html('');
                        $emailNotification.html('');
                        $messageNotification.html('');

                        var validation = validateForm();
                        if (validation.errors === 0) {
                            sandbox.getScript({
                                url: model.postingURL + '?' + $form.serialize() + '&timestamp=' + new Date().getTime(),
                                jsonP: processResponse,
                                error: function () {
                                    //due to bug in mno.io we need a guard not to invoke processNotification twice
                                    if (!callbackFired) {
                                        processNotification({
                                            type: 'error',
                                            label: labels.failure,
                                            block: false
                                        });
                                    }
                                    callbackFired = false;
                                }
                            });
                        } else {
                            $loading.hide();
                            processNotification({
                                type: 'error',
                                label: labels.validation,
                                block: false,
                                messages: validation.fields
                            });
                        }
                    }

                    function validateForm() {

                        var result = {
                            errors: 0,
                            fields: {}
                        };
                        //these methods extend String.prototype in mno/utils/stringUtils.js
                        var alias = $alias.val().strip_tags().trim();
                        var message = $message.val().strip_tags().trim();

                        $alias.val(alias);
                        $message.val(message);
                        if (alias.length < 1) {
                            result.errors += 1;
                            result.fields.alias = true;
                        }

                        if (!/^([^@]+)@(.*)\.([a-zA-Z]{2,})$/.test($email.val())) {
                            result.errors += 1;
                            result.fields.email = true;
                        }

                        //backward compatibility hack for versions without Escenic's content-type settings not to get JS parse error
                        if (model.charLimit.length === 0) {
                            model.charLimit = 500;
                        } else {
                            if (isNaN(model.charLimit)) {
                                model.charLimit = 500;
                            }
                        }

                        if (message.length < 1 || message.length > model.charLimit) {
                            result.errors += 1;
                            result.fields.message = true;
                        }

                        return result;
                    }

                    function processNotification(params) {

                        $loading.hide();

                        params.type = params.type || 'error';
                        params.label = params.label || '';
                        params.block = params.block || false;
                        params.messages = params.messages || false;

                        if (params.type === 'error') {
                            $form.addClass('error');
                        } else {
                            $form.removeClass('error');
                        }

                        if (params.label !== '') {
                            $notification.html(params.label).show();
                        }

                        if (params.messages) {

                            if (params.messages.alias) {
                                $aliasNotification.html(labels.fields.alias).show();
                            }

                            if (params.messages.email) {
                                $emailNotification.html(labels.fields.email).show();
                            }

                            if (params.messages.message) {
                               $messageNotification.html(labels.fields.message).show();
                            }

                        }

                        if (params.block) {
                            $button.blur();
                            $button.addClass('inactive');
                        } else {
                            $button.removeClass('inactive');
                        }

                    }

                    function processResponse(data) {
                        callbackFired = true;

                        // this needs to be fixed on server side, because boolean is returned actually as a string
                        if (data !== undefined && data['boolean'] === 'true') {

                            //empty the form on success
                            $alias.val('');
                            $email.val('');
                            $message.val('');

                            processNotification({
                                type: 'success',
                                label: labels.success,
                                block: true
                            });
                        } else {
                            processNotification({
                                type: 'error',
                                label: labels.failure,
                                block: false
                            });
                        }
                    }
                });
            }
        }

        function destroy() {
            sandbox.container = null;
        }

        return {
            init: init,
            destroy: destroy
        };
    }
});
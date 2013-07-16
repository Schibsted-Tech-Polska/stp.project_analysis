/*
 * Plugin: mnoExpose
 * Exppose for MNO Scalable Javascript Application
 *
 * Author:
 * Tor Brekke Skjøtskift
 *
 * Copyright:
 * Aftenposten AS (c) 2010, All Rights Reserved
 *
 * License:
 *
 * Usage:
 * $(element).mnoExpose()
 *
 */

(function($) {
    mno.namespace('mno.utils.dialog');
    mno.utils.dialog = function (options) {
        var defaults = {
            onClose:function () {
            },
            onOpen:function () {
            },
            span:10,
            auto:false,
            content:''
        };

        options = $.extend(defaults, options);

        var $window = $(window),
            windowWidth = $window.width(),
            windowHeight = $window.height(),
            dialog,
            dialogBox,
            dialogOpen = false,
            data = {
                docHeight:$(document).height(),
                width:options.auto === false ? (options.span*80) + ((options.span-1) * 20) + 20 : 'auto',
                maxHeight:$window.height()-200
            };

        mno.views.render('mno.views.dialog', data, function (el) {
            el.appendTo('body');

            var $dialogWrapper = $('#mnoDialog');

            $dialogWrapper.css({
                left: (windowWidth/2) + 'px',
                top: (windowHeight/2) + 'px'
            });

            $('#mnoDialogBg, #mnoDialogClose').bind('click', function (e) {
                close();
            });

            dialogBox = $('#mnoDialogContent');
            dialogBox.hide().fadeIn(250, function () {
                dialogOpen = true;
            });


        });

        function close() {
            dialogBox.fadeOut(250, function () {
                $('#mnoDialogBg, #mnoDialog').remove();
                options.onClose();
            });
        }

        function insertContent(data) {
            var $dialogWrapper,
                dialogWidth,
                dialogHeight,
                dialogTop,
                dialogLeft;

            if (dialogOpen === true) {
                /* innershiv for HTML 5 element in IE */
                
                if(typeof mno.core.utils !== 'undefined' && typeof mno.core.utils.innerShiv === 'function'){
                    if(data.jquery && data.length > 0){
                        data = $('<div />').append(data);
                        data = data.html();
                    }
                    data = $(mno.core.utils.innerShiv(data,false)).appendTo('body');
                }

                dialogBox.removeClass('load').html(data);

                $dialogWrapper = $('#mnoDialog');
                dialogWidth = $dialogWrapper.outerWidth();
                dialogHeight = $dialogWrapper.outerHeight();
                dialogLeft = (windowWidth/2) - (dialogWidth/2) > 0 ? (windowWidth/2) - (dialogWidth/2) : 0,
                dialogTop = (windowHeight/2) - (dialogHeight/2) > 0 ? (windowHeight/2) - (dialogHeight/2) : 0;

                $dialogWrapper.css({
                    left: dialogLeft + 'px',
                    top: dialogTop + 'px',
                    position: (dialogLeft !== 0 && dialogTop !== 0) ? 'fixed' : 'absolute'
                });

                options.onOpen();
            } else {
                setTimeout(function () {
                    insertContent(data);
                }, 100);
            }
        }

        if (typeof options.content === 'object') { /*Must be HTML element or jQuery Object */

            insertContent(options.content);

        } else if ((typeof options.content === 'string') && (options.content.indexOf('http') !== -1)) { /* URL */
            $.ajax({
                url:options.content,
                success: function (data) {
                    insertContent(data);
                }
            });
        } else {
            mno.core.log(1, 'Wrong type for mnoDialog');
        }

        return {
            update:insertContent,
            close:close
        }

    };

}(window.jQuery));
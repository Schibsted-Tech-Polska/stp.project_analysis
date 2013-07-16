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

/*mno.core.getCSS(SITEURL + 'skins/global/utils/expose/expose.css');*/

(function($) {

    var methods = {
        init:function (options) {
            options = $.extend({
                onClose:function () {
                },
                onOpen:function () {
                }
            }, options);

            function close($this, bg, placeholder) {
                bg.fadeOut(250, function () {
                    /* TODO Spare på top og left verdier */
                    $this.removeClass('mnoExposed').css({
                        top:'auto',
                        left:'auto'
                    }).insertBefore(placeholder);
                    placeholder.remove();

                    options.onClose();
                });
            }

            return this.each(function(i) {
                var $this = $(this);
                $this.bind('focus click', function (e) {
                    if (!$this.hasClass('mnoExposed')) {
                        var pos = $this.offset(),
                                placeholder = $('<div></div>').insertBefore(this);

                        $this.data('placeholder', placeholder);

                        placeholder.css({height:$this.outerHeight(true) + 'px'});

                        var bg = $('<div />').attr('id','exposeWhiteBg').css('display','none').bind('click',
                                                                                              function () {
                                                                                                  close($this, bg, placeholder);
                                                                                              }).css('height', $(document).height() + 'px')
                                .appendTo('body');

                        $this.css({
                            width:$this.width(),
                            top:pos.top - $this.outerHeight(true) + $this.outerHeight(),
                            left:pos.left
                        })
                                .addClass('mnoExposed')
                                .appendTo('body');

                        options.onOpen();

                        bg.fadeTo(250, 0.8);
                        e.target.focus();
                    }
                });
            });


        },
        update:function() {
            return this.each(function () {
                var $this = $(this);
                if ($this.hasClass('mnoExposed')) {
                    $this.data('placeholder').css({height:$this.outerHeight(true) + 'px'});
                }
            });
        }
    };


    $.fn.mnoExpose = function(method) {
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || ! method) {
            return methods.init.apply(this, arguments);
        } else {
            mno.core.log(1, 'Method ' + method + ' does not exist on mnoExpose');
        }
    };

}(window.jQuery));



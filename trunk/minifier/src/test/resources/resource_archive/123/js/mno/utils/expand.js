/*
 * Plugin: mnoExpand
 * Expand for MNO Scalable Javascript Application
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
 * $(element).mnoExpand(options)
 *
 * Arguments:
 * content (object|false) Replacement content (default false)
 *     location (Url|element)Url or element to replacement content
 *     type (image|video|flash|html)
 * speed (int) Speed in millisecond (default 1000)
 * originalWidth (int) Original gridunits (1-10) (default 2) - only required when direction is "left"
 * expandedWidth (int) Gridunits to expand (1-10) (default 10)
 * direction (string) left|right (default right)
 *
 */

/*mno.core.getCSS(SITEURL + 'skins/global/utils/expand/expand.css');
mno.core.getScript({
    url:SITEURL + 'resources/js/mno/utils/jquery.easing.1.3.js',
    reload:false
}); */

(function($) {
    $.fn.mnoExpand = function(options) {
        var defaults = {
            content:false,
            speed: 250,
            originalWidth: 2,
            expandedWidth: 10,
            direction: 'right'
        },
        transition = mno.features.transition;

        /* Extend default options.*/
        options = $.extend(defaults, options);
        var loader;
        /* Set pixel width */
        options.originalWidth = ((options.originalWidth * 80) + ((options.originalWidth - 1) * 20));
        options.expandedWidth = ((options.expandedWidth * 80) + ((options.expandedWidth - 1) * 20));

        this.each(function() {
            var $this = $(this),
                    parent = $this.parents('.expandParent'),
                    content;

            if (parent.css('position') === 'static') {
                parent.css('position', 'relative');
                parent.css('left', 0);
            }

            parent.addClass('animate');
            parent.css('width',parent.width() + 'px');

            $this.addClass('animate');
            $this.data('src', false);
            $this.data('width', false);

            $('.videoMarker').bind('click', function () {
                expandVideo();
                //$(this).prev('img').trigger('click');
            });

            $('.videoMarkerIE').bind('click', function () {
                expandVideo();
                //$(this).prev('img').trigger('click');
            });

            $this.bind('click', function () {
                expandVideo();
            });

            //$this.bind('click', function () {
            function expandVideo(){

                var newNumericWidth = options.expandedWidth;

                if($this.data('width')) {
                    var currentPixelWidth = $this.data('width');
                    var currentNumericWidth = currentPixelWidth.substring(0, currentPixelWidth.indexOf('px'));
                    newNumericWidth = parseInt(currentNumericWidth);
                }

                var newLeftPosition = '0';
                if(options.direction === 'left' && newNumericWidth !== options.originalWidth) {
                    var newNumericPosition = newNumericWidth - options.originalWidth;
                    newLeftPosition = '-' + newNumericPosition + 'px';
                }

                if (options.content) {
                    var position = $this.position();
                    if (transition === false) {
                        loader = $('<div class="loader"></div>').appendTo(parent)
                                .css({
                            top:position.top + 'px',
                            left:position.left + 'px'
                        });
                    }
                    // todo cursor:zoom;
                    if (options.content.type === 'image') {
                        if (!options.content.location.element) {
                            var src = "";
                            if ($this.data('src')) {
                                src = $this.data('src');
                                $this.data('src', false);
                                $this.data('width', false);
                            } else {
                                /* Is source an attribute or an url? */
                                src = options.content.location.url ? options.content.location.url : $this.attr(options.content.location.attr);
                                $this.data('width', $this.width() + 'px');
                                $this.data('src', $this.attr('src'));
                            }
                            content = new Image();
                            $(content).attr('src', src)
                                    .load(function () {
                                $this.css('width', '100%');
                                $this.attr('src', src);
                            });
                        }
                    } else if (options.content.type === 'silverlight' || options.content.type === 'flash') {
                        var src = "";
                        if ($this.data('src')) {
                            src = $this.data('src');
                            $this.data('src', false);
                            $this.data('width', false);
                            content = new Image();
                            $(content).attr('src', src)
                                    .load(function () {
                                $this.css('width', '100%');
                                $this.attr('src', src);
                            });
                        } else {
                           $.ajax({
                                url:mno.publication.url + 'template/common/mnoVideo/'+ options.content.type +'/player.jsp',
                                dataType:'html',
                                data: {
                                    iframe: true,
                                    videoArtId:$this.attr(options.content.location.attr),
                                    playerWidth:options.expandedWidth + 'px'
                                },
                                success:function(data) {
                                    $this.replaceWith(data);
                                    parent.find('object').css('margin', '-5px 0 0 -10px');
                                    parent.find('.videoMarker, .videoMarkerIE').remove();
                                }
                            });
                        }
                        $this.css('width', '100%');
                        parent.find('.content').removeClass('withImg');
                    } else {}
                }
                if (transition !== false) {
                    parent.css('width', newNumericWidth + 'px');
                    parent.css('left', newLeftPosition);
                } else {
                    parent.animate({width:newNumericWidth + 'px',left:newLeftPosition}, options.speed, function () {
                        if (loader) {
                            loader.remove();
                        }
                    });
                }
            }//);

        });

        return this;
    };
}(window.jQuery));
/*
 * Plugin: mnoTree
 * Tree for MNO Scalable Javascript Application
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

/*mno.core.getCSS(SITEURL + 'skins/global/utils/tree/tree.css');*/

(function($) {

    var methods = {
        init:function () {
            return this.each(function(i) {
                var $this = $(this),
                    clone = $this.clone(true);
                 mno.core.log(1,clone);
                clone.addClass('mnoTree');

                //clone.find('li').addClass('leaf');
                clone.find('li:last-child').addClass('lastChild');
                clone.find('li.leaf a').click(function(e){
                    e.stopPropagation();
                    
                });
                clone.find('li.expanderCollapser:has(ul)').each(function () {
                    $(this).addClass('expanded')
                            .bind('click', function (e) {
                                $(this).toggleClass('expanded collapsed');
                                e.stopPropagation();
                            })
                            .prepend('<span class="mnoTree-expand">+</span><span class="mnoTree-collapse">-</span>')
                            .removeClass('leaf');
                });

                $this.replaceWith(clone);

            });
        }
    };


    $.fn.mnoTree = function(method) {
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || ! method) {
            return methods.init.apply(this, arguments);
        } else {
            mno.core.log(1, 'Method ' + method + ' does not exist on mnoExpose');
        }
    };

}(window.jQuery));



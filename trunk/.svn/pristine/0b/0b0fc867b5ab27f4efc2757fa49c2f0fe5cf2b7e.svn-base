/*
 * Main javscript for MNO publications
 *
 * Author:
 * Tor Brekke Skj�tskift
 *
 * Copyright:
 * Aftenposten AS (c) 2010, All Rights Reserved
 *
 */

(function ($) {
    /*$(window).bind("error",function(e){
        mno.core.log(3,e);
    });*/

    /*dom ready*/
    $(document).ready(function () {
        $('[data-href]').live('click', function () {
            window.location.href= $(this).attr('data-href');
        }).css("cursor","pointer");

        $('[data-href] object').live('click', function () {
            return false
        });

        /* eksterne videoer i iframes vil legges seg oppå menyer og a-å-index by default.
        Dette fikses ved å sende med wmode=transparent på urlen til iframen. Gjør derfor dette for alle iframes som inneholder youtube-videoer foreløpig */
        $('iframe').each(function(){
            var src = $(this).attr('src');
            var newSrc = src;
            if(src && src.indexOf('youtube') !== -1 && src.indexOf('wmode') < 0){
                if(src.indexOf('?') !== -1){ /* wmode må være første parameter */
                    var baseUrl = src.split('?')[0];
                    var parameters = src.split('?')[1];
                    newSrc = baseUrl+'?wmode=transparent&'+parameters;
                }else{
                    newSrc = src+'?wmode=transparent';
                }
                $(this).attr('src', newSrc);
            }
        });       /* begins with  as many as you want     */
        var regex = new RegExp('^.+(test|dev)[0-9]{1}\.');
        if(regex.test(window.location.href) || mno.publication.debug === true){
            mno.core.debug(true);
        }else{
            mno.core.debug(false);
        }
        mno.core.startAllOnCurrentPage();
      });
    $('body').bind('load', function () {
        window.setTimeout(function () {
            if(window.pageYOffset !== 0) {
                return;
            }

            window.scrollTo(0, window.pageYOffset+1);
        }, 100);
    });


}(window.jQuery));
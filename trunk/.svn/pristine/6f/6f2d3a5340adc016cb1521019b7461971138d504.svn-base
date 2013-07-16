/*
 *
 * Adtech Plugins lib ver 1.0
 *
 * Author: Thomas Orten
 *
 * Copyright: Media Norge Digital AS, Polaris Media ASA (c) 2010, All Rights Reserved
 *
 * NOTE: Expands the plugin object in adtech.js, with other ad types besides "standard" ads.
 *       These ads may do something extra besides just embedding flash/images/iframes.
 *       We might as well use jquery here, because we know we have this library, and these specials are specific to us and Adresseavisen.
 *
 * USAGE: (From adtech.js)
 *
 * adtech.setPlugin:
 *
 * Function used by plugins.js, to extend our "plugins" object above, with more ad specials.
 *
 *   @param {String} name The name of the ad special, e.g. "interstitial".
 *   @param {Function} func The callback function, i.e. the code that will be called when that special is booked.
 *
 *   The callback function accepts three parameters:
 *
 *   @param {Object} options  Same as o:{} in the ad object. Contains all the assets, swf urls, clicktags etc.
 *   @param {Object} context Window by default. Can pass along the iframes' window object so it knows to use its own instance of swfobject, also contained within the iframe.
 *                           We have to do this if we want the iframe to embed flash, as Swfobject doesn't currently support embedding into child iframes,
 *                           even if they are on the same domain.
 *   @param {String} frame The ID of the iframe that is calling, wo we know where to embed.
 *
 * adtech.getPlugin:
 *
 *   NOTE: This is used to embed the actual assets of the ad (whether it is a flash or image), and SHOULD be used. It is the same method as used by type "standard".
 *   Accepts the "type" of ad to embed, including the same parameters as the callback function itself (options, context, frame).
 *   Usually we use adtech.getPlugin('standard', options, context, frame); , and in additional do some div-magic to create an "ad special".
 *
 * CSS is located in /skins/global/widgets/mnoAd/
 *
 **/

/**
 * Left L-ad.
 */

adtech.setPlugin( 'lad', function (options, context, frame) {

    // Check if this is an actual object
    if (typeof options !== 'object') { return; }

    // Load ad assets
    adtech.getPlugin('standard', options, context, frame);

    // For companion ad
    var id = "adLeft",
        // Where to put the flash container
        iframecont = 'l_stolpe',
        // Get alias of the companion placement (set in config in studio!)
        alias = adtech.getCompanion('l_stolpe').alias;

    // Makes sure the iframes we load in using loadFIF below don't load this function again! Thus the ad will embed several times..
    // We can check using the frame string, which is passed to us from the iframe
    if (frame === 'fifl_stolpe' || frame === 'fifl_expanded') { return; }

    AdElement.get(frame).parentNode.style.marginLeft = '-20px';

    // Create div for topbanner FIF/iframe container
    var container = adtech.Create( 'div',
        {
            id: iframecont,
            className: 'ohidden'
        });

    // Append it
    AdElement.get(id).append(container);

    // Load left FIF
    adtech.loadFIF(iframecont, alias);

    //TODO: sjekkes mot ny layout. Viewport fjernes.
    if ($(window).width() <= 1220) {
        $('#viewport').css('width','980px');
    } else {
        $('#viewport').css('width','1000px');
    }

});

adtech.setPlugin( 'hestesko', function (options, context, frame) {
    $('#topAd').css('left', '-20px');

    adtech.getPlugin('standard', options, window);


});

/**
 *  Ticker ad.
 *  Basically a sticky at the bottom of the viewport.
 *
 *  Needs Async FIF.
 */

adtech.setPlugin( 'ticker', function (options, context, frame) {

    // Get at parent conttainer, with which we will do some css
    var container = AdElement.get(frame).parentNode;
    var parent = container.parentNode;

    // Set to fixed
    parent.style.position = 'fixed';

    // Set a margin according to whether this is a flash or not (has an options.config property), or an image (has an options.attr object),
    // and whether the height of these is 25px or 30px..
    var margin = options.config ? container.style.height.split("px")[0] - options.config.height :
        options.attr.imgH ?  container.style.height.split("px")[0] - options.attr.imgH : 0;

    // 14 px for ad padding
    container.style.marginTop = (margin -14) + "px";

    // Get ad assets
    adtech.getPlugin('standard', options, context, frame);

    container.style.height = 'auto';
    parent.style.height = '44px';

    // IE 7, no pseudo ::before, so we cannot insert an ad marker. Just drop it
    if ($("#fifticker").position().top < 10) {
        parent.style.height = '30px';
    }

});

/**
 * Sticky Topbanner
 *
 * Can use Async FIF/Javascript tag (or async, through not yet in production use).
 */

adtech.setPlugin( 'stickyTB', function (options, context, frame) {

    //If called from an iframe, frame will be a string. If no "frame", this is not in an iframe,
    // so we'll use the options.container property to find the parent container instead

    var container = frame ? $('#' + frame).parent() : $('#' + options.container).parent();

    // Find start offset, in case ad is not at the very top.. IE7 upgrade message at the top of the page for instance?
    var startHere = container.offset().top;
    // Set high z-index
    container.css({"z-index": 999});
    // Store topMenu object if there is onw
    var topMenu = $("#smallHeader");
    var topAdContainer = $("#topAd");
    // Set height of it to 0 initially, it won't be shown before scroll anyway
    var topMenuHeight = 0,
        closed = false;

    var closeBtn = $('<div>Lukk annonse</div>').css({
        position:'fixed',
        top:'130px',
        display:'none',
        zIndex:999,
        marginLeft:'880px',
        cursor:'pointer'
    }).on('click', function () {
            topAdContainer.removeClass('tbSticky');
            container.css('position', 'static');
            closeBtn.hide();
            closed = true;
        }).appendTo(topAdContainer);

    // Only for IE7+
    if (window.XMLHttpRequest) {
        $(window).scroll(function () {
            if (closed === true) {
                return;
            }

            // Add class on scroll to make sure we get minimal "jumping"
            if (!topAdContainer.hasClass("tbSticky")) { topAdContainer.addClass("tbSticky"); }
            // Checking again to see if topMenu exists.: IE sometimes loads the top menu after stickyTB. If length is not equal 1, set to #smallHeader
            topMenu = topMenu.length === 1 ? topMenu : $("#smallHeader");
            // Check stop container offset again. Same issue. Offset() may change, as not all ads might not have loaded.
            var stopHere = $('#netboard1').offset() ? $('#netboard1').offset().top : $(document).height();
            var netBoard1Height = $('#netboard1').height() || 0;
            // Get top menu height
            topMenuHeight = topMenuHeight !== 0 ? topMenuHeight : topMenu.outerHeight();
            // Cache scrolltop for later use
            var scrolled = $(window).scrollTop();

            if (scrolled >= stopHere) {
                // User has scrolled too far.
                container.css({ position: 'absolute', top: stopHere - netBoard1Height});
                closeBtn.css({ position: 'absolute', top: stopHere - netBoard1Height});
            } else if (scrolled <= stopHere && scrolled >= startHere) {
                closeBtn.show();
                // Scrolled past starting point, and less than stop point.
                container.css({ position: 'fixed', top: 0 });
                closeBtn.css({ position: 'fixed', top: 0 });
                if (topMenu.is(':hidden') || scrolled < 100) {
                    container.css({top: 0});
                    closeBtn.css({top: 0});
                } else {
                    // Extra margin because of sticky top menu
                    if(topMenuHeight == null){
                        topMenuHeight = topMenu.outerHeight();
                    }
                    //container.css({top: topMenuHeight});
                    container.css({ position: 'fixed', top: topMenuHeight +'px' });
                    closeBtn.css({ position: 'fixed', top: topMenuHeight +'px' });
                }
            } else {
                closeBtn.hide();
                container.css({ position: ''});
            }
        });
    }
    // Now get the ad itself
    adtech.getPlugin('standard', options, context, frame);
});

/**
 * Sticky skyscraper
 *
 * Can use Async FIF/Javascript tag (or async, through not yet in production use).
 */
adtech.setPlugin( 'sticky', function (options, context, frame ) {

    // Find container
    //If called from an iframe, frame will be a string. If no "frame", this is not in an iframe,
    // so we'll use the options.container property to find the parent container instead
    var container = frame ? $('#' + frame).parents(".ad:first") : $('#' + options.container).parents("ad:first"),
        containerPosIntial = null,
        topMenu = $("#smallHeader"),
        topMenuHeight = 0,
        // Where to stop the ad
        btmMax = $(document).height(),
        // Check for object existance to find height of either the swf height or image height
        adH = options.config ? options.config.height : options.attr.imgH;

    // Set hight zInde
    container.css({"z-index": 1000});

    /** Skip IE6 **/
    if (window.XMLHttpRequest) {
        $(window).scroll(function () {
            // Does topMenu exist now? If so, find object
            topMenu = topMenu.length === 1 ? topMenu : $("#smallHeader");
            // Then find height
            topMenuHeight = topMenuHeight !== 0 ? topMenuHeight : topMenu.outerHeight();
            // Set initial starting point on scroll, to make sure all heights of various elements are set
            containerPosIntial = containerPosIntial === null ? container.offset().top : containerPosIntial;
            if ($(window).scrollTop() >= btmMax) {
                // We've gone past our "stop" point at the bottom of the page
                container.css({ position: 'absolute', top: btmMax - adH });
            } else if ($(window).scrollTop() >= containerPosIntial - topMenuHeight) {
                // We're ready to set to fixed
                if (topMenu.is(':hidden')) {
                    container.css({ position: 'fixed', top: '0' });
                } else {
                    container.css({ position: 'fixed', top: topMenuHeight +'px' });
                }
            } else {
                // We haven't reached our starting point yet, don't fix
                container.css({ position: '', top: '' });
            }
        });
    }

    // Get ad assets
    adtech.getPlugin('standard', options, context, frame);

});


/**
 * stealLevel
 *
 * Let's an ad steal other ads positions (if located on the same level ("etasje")).
 * Can use Async FIF/Javascript tag (or async, through not yet in production use).
 */
adtech.setPlugin( 'stealLevel', function (options, context, frame ) {

    var container = frame ? '#'+ frame : '#' + options.container;

    adtech.getPlugin('standard', options, context, frame);

    $(document).ready(function () {
        // Lets make this as genreric as possible. Make it work with any level
        // Find parent container (from where we find its siblings to remove). Does this level's ad-containers ("etasje") have parent div's with class .gridUnit? If so, use this to determine its silings. If not, use its .ad container.
        var parentContainer = $(container).parents('.ad').parent().hasClass('gridUnit') ? $(container).parents('.ad').parent() : $(container).parents('.ad');
        // Remove its siblings
        parentContainer.siblings().not('.clear, .clearer').remove();

    });

});

/**
 * Lightbox, uses colorbox. (http://jacklmoore.com/colorbox/)
 *
 * Same code ad type "popback" and "interstial".
 * They both use a lightbox. We differentiate between the two by checking whether the "options.attr" object has an image porperty - and that "target" is set to "_self".
 * If it has these two, it is a popback, and the content (or clickTAG) is an URL we want to open in an IFRAME inside the ligbox (see the isPopback if-test below).
 *
 * Can use Async FIF/Javascript tag (or async, through not yet in production use).
 */

adtech.setPlugin( 'lightbox', function (options, context, frame ) {

    // This function serves both interstitial ads, and popbacks.
    // As we load the ad using an IFRAME, the only difference is whether the ad's content "target" attribute - is set to _new, or _self  (i.e. whether the link opens in a new window or not)
    // Opens in new window (target = _new) - normal ad and interstitial
    // Does not open in new window (target _self) - popback, the user continues answering questions inside the ad iframe. Scrollbars will appear

    var cssHref = "/skins/global/widgets/mnoAd/colorboxWhite.css",
        scriptSrc = "/resources/js/mno/ads/colorbox.js",
        timeout = options.attr.tout !== 0 ? (options.attr.tout * 1000) + 2000 : null,    // Add a couple of seconds to allow the flash file to load in
        container = frame ? null : $('#' + options.container).parent(),    // Iframe or async? Either or..
        isPopback = options.attr.img !== '' && options.attr.target === '_self';   // We know this is a popback ad, because of the target=_self (same window)

    if (container === null) { alert("Please contact the developer if you see this alert. The interstitial and popback ad spesials only work with javascript-tags, not iframes. "); }

    if ($('#colorbox').length > 0) { return false; }




    // Hide the ad container, to avoid "flashing" ad
    container.hide();

    adtech.getPlugin('standard', options, context, frame);

    // Then get javascript. When script is loaded, trigger the fancybox (in the callback function)

    $.getScript( scriptSrc, function () {

        // Trigger the colorbox

        $.colorbox({
            inline:true,
            href: container,
            fixed: true,
            close: 'Lukk annonsen',
            scrolling: false,
            innerWidth: options.config ? options.config.width : options.attr.imgW + 'px',
            innerHeight: options.config ? options.config.height : options.attr.imgH + 'px',
            onComplete: function () {
                container.show();
                //container.css("z-index", 1100);
                //#cboxClose{position:absolute; bottom:0; right:0; display:block; color:#444;}

                var link = $("<link>");
                link.attr({
                    type: 'text/css',
                    rel: 'stylesheet',
                    href: cssHref
                });
                $("head").append( link );


                $('#cboxClose').css("position", "absolute");
                $('#cboxClose').css("bottom", "0");
                $('#cboxClose').css("right", "0");
                $('#cboxClose').css("display", "block");
                $('#cboxClose').css("color", "#444");
                //$('#cboxClose').css("z-index", "1110");
                $('#cboxClose').css("cursor", "pointer");


                if (timeout !== null) {
                    ad_lightbox_timeout = window.setTimeout(function() {
                        $.colorbox.close();  // It has a close()-method.. Alrighty then
                    }, timeout);  // options.timeout is a value set in the banner template - and must be setup as an option in the banner template
                }
            },
            onCleanup: function () {
                container.hide();
            }
        });

        // If user clicks the image link, cancel the timeout on the parent page, so the window doesn't close!
        // IE this is a popback ad!

        if (isPopback) {
            var link = container.find('a');
            link.click(function () {
                // Clear timeout
                if (ad_lightbox_timeout) {
                    window.clearTimeout(ad_lightbox_timeout);
                }
                // Then create iframe
                var iframe =
                    $('<iframe />')
                        .attr({
                            width: '100%',
                            height: '100%',
                            frameBorder: 0,
                            marginHeight: 0,
                            marginWidth: 0,
                            seamless: 'seamless',
                            src: options.flashvars.clickTAG || options.flashvars.clickTAG1
                        });
                link.replaceWith(iframe); // And replace image with iframe
                return false;
            });
        }
    });

});

/**
 * Wallpaper ad
 *
 * Requires javascript (or async) tag! Async FIF won't work.. It's a hassle to do this with iframes..
 */

adtech.setPlugin( 'wallpaper', function (options, context, frame ) {
    $(document).ready(function () {
        $('#adRight').css({
            position:'fixed',
            display:'none',
            zIndex:999
        });
    });
    // First, make a ref div name
    var wallpaper = "wallpaper",
        // Get the companion ad Position from Helios
        companion = adtech.getCompanion('wallpaper'),
        clickTAG = options.flashvars.clickTAG || options.flashvars.clickTAG1,
        banner_width = options.attr.imgW || options.config.width;

    // Only continue if companion not already loaded
    if ($('#wallpaper').length === 0) {
        $(window).scroll(function () {
            //var btmMax = $('#megaboard').offset() > 0 ? $('#megaboard').offset().top : $(document).height();
            ($('#footer').css({position: 'relative'}))

        });
        // Create ref container for companion ad script..
        $('<div id="wallpaper_cont"></div>')
            // Call it wp_div
            .append('<div><div id="'+ wallpaper +'"></div></div>')
            .prependTo('body')
            .css({position: 'fixed'})
            .css({top: 0});

        // Are we dealing with a single placement, i.e. only a large image/flash, and not a background/topbanner combo?
        if (banner_width > 1000) {
            // Yes we  are. One placement.
            // Override container to wallpaper div above
            options.container = 'wallpaper';

            // Show top banner, as it is empty. But we need the height.
            $('#toppbanner iframe')
                .hide()
                .parent()
                .css({height: 150, cursor: 'pointer'})
                .css({position: 'absolute'})
                .css({top: 0})
                .show()
                .click(function (e) {
                    // Add adiitional click handler to toppbanner div
                    window.open(clickTAG, "wallpaper");
                });

            adtech.getPlugin('standard', options, window);

        }  else {

            // No we're not. Two placements. Load companion ad also.
            adtech.getPlugin('standard', options, context, frame);
            adtech.loadAd('wallpaper', companion.alias, companion.src);

        }

        if (options.attr.body_click) {
            var wp_cont = $('#wallpaper_cont');
            wp_cont[0].style.cursor = 'pointer';
            wp_cont.live( 'click', function (e) {
                // Add click handler to background div as well, but only invoke when event.target is the div and not a descendant
                if (this.id === e.target.id) {
                    window.open(clickTAG, "wallpaper")
                }
            });
        }

        if (options.attr.hex) {
            $('body')[0].style.backgroundColor = options.attr.hex;
        }

    } else {

        // Get ad assets
        adtech.getPlugin('standard', options, context, frame);

    }

    var div = $('#wallpaper').parent()[0];

    // Set wallpaper relative to screen,
    // needed because there is a lot of funky css changes on resize..
    /*function setRelativeToScreen () {
     var win_width = $(window).width();
     var viewport_width = $('#viewport').width(); //TODO: Sjekkes mot ny layout. Viewport fjernes
     if (win_width < banner_width || win_width <= viewport_width) {
     if (win_width <= viewport_width) { return; }
     var leftOffset = (win_width - banner_width)/2;  // Half of the difference
     div.style.marginLeft = leftOffset + 'px';
     div.style.width = win_width + 'px';
     } else {
     div.style.marginLeft = 'auto'; // Or auto if resizing up again
     div.style.width = banner_width + 'px';
     }
     }*/
    /*// Set correctly initially
     setRelativeToScreen();

     // And on resize
     $(window).resize(function () {
     setRelativeToScreen();
     });*/

});

/**
 * Overlay ad
 * Received code from Finn
 * Kroma
 */

adtech.setPlugin( 'overlay', function (options, context, frame ) {

    var countLayerOpen = function() {
        counter = new Image;
        counter.src = "_ADCLICK_";
        kroma_overlay_show_hide();
    }

    function VBGetSwfVer__ADFC_CUID_(i) {
        var sVersion__ADFC_CUID_ = "on error resume next\r\n"+
            "Dim swControl_, swVersion_\r\n"+
            "swVersion_ = 0\r\n"+
            "set swControl_ = CreateObject(\"ShockwaveFlash.ShockwaveFlash.\" + CStr("+i+"))\r\n"+
            "if (IsObject(swControl_)) then\r\n"+
            "swVersion_ = swControl_.GetVariable(\"$version\")\r\n"+
            "end if";
        window.execScript(sVersion__ADFC_CUID_, "VBScript");
        return swVersion_;
    }

    var AT_MULTICLICK=new Array;
    var AT_MULTICOUNT=new Array;
    var AT_CLICKVAR=new Array;
    var AT_CLICK = "javascript:countLayerOpen();";
    var AT_IMGCLICK="";
    var AT_TARGET="_blank";
    var AT_MICROSITE=""; // width=xxx height=yyy
    AT_MULTICLICK[1]="";
    AT_MULTICLICK[2]="";
    AT_MULTICLICK[3]="";
    AT_MULTICLICK[4]="";
    AT_MULTICLICK[5]="";
    AT_MULTICLICK[6]="";
    AT_MULTICLICK[7]="";
    AT_MULTICLICK[8]="";
    AT_MULTICLICK[9]="";
    AT_CLICKVAR[0]="clickTAG";
    AT_CLICKVAR[1]="clickTAG1";
    AT_CLICKVAR[2]="clickTAG2";
    AT_CLICKVAR[3]="clickTAG3";
    AT_CLICKVAR[4]="clickTAG4";
    AT_CLICKVAR[5]="clickTAG5";
    AT_CLICKVAR[6]="clickTAG6";
    AT_CLICKVAR[7]="clickTAG7";
    AT_CLICKVAR[8]="clickTAG8";
    AT_CLICKVAR[9]="clickTAG9";
    AT_MULTICOUNT[1]="";
    var AT_WIDTH_HEIGHT="width=240 height=600";
    var AT_FLASH=adtech.getPlugin('standard', options, context, frame);
    var AT_TRANSPARENT=false;
    var AT_FLASHVERSION=7;
    var AT_FLASH_BGCOLOR="";
    var AT_FlaQual="autohigh";
    var AT_FlashClick=false;
    var AT_LAYERMANUALRESIZE = false;
    var AT_BASE="_ADPATH_"; // Nachladepfad fuer Flash Filme (http://.../)
    var AT_IMAGE=adtech.getPlugin('standard', options, context, frame);
    var AT_TEXT="";
    var AT_ALTIMAGEWIDTH  = "240";
    var AT_ALTIMAGEHEIGHT = "600";
    var AT_ZINDEX         = "0";
    var AT_WMODE          = "opaque";
    var AT_EXPANDABLE="false"; // width:100px;height:70px; Zus?tzlich Fakepopup an position 0x0 machen
    var AT_FAKEPOPUP=false;
    var AT_FAKEPOPUP_left=100;
    var AT_FAKEPOPUP_top=100;
    var AT_FAKEPOPUP_autoclose='';
    var AT_FAKEPOPUP_start_opened=true;
    var AT_CURRENTDOMAIN= window.location.host;
    var AT_VARSTRING;
//make variable names unique on page
    var AT_MULTICLICK_ADFC_CUID_=AT_MULTICLICK;
    var AT_CLICK_ADFC_CUID_=AT_CLICK;
    var AT_TARGET_ADFC_CUID_=AT_TARGET;
    var AT_IMGCLICK_ADFC_CUID_=AT_IMGCLICK;
    AT_CLICKVAR[0]=AT_CLICKVAR[0]?AT_CLICKVAR[0]:"clickTAG";
    var AT_MULTICLICKSTR="?"+AT_CLICKVAR[0]+"=" + escape("_ADCLICK_") + escape(AT_CLICK);
    var AT_FLASHVARSSTR= "";
// if use microsite, dont add the first parameter
    if (AT_MICROSITE=="") AT_FLASHVARSSTR = AT_CLICKVAR[0]+"=" + escape("_ADCLICK_") +escape(AT_CLICK);
//------------------------------------------------------------------------------------------------
// Flash detect
    function JSGetSwfVer_ADFC_CUID_(){
        if (navigator.plugins != null && navigator.plugins.length > 0) {
            if (navigator.plugins["Shockwave Flash 2.0"] || navigator.plugins["Shockwave Flash"]) {
                var swVer2 = navigator.plugins["Shockwave Flash 2.0"] ? " 2.0" : "";
                var flashDescription = navigator.plugins["Shockwave Flash" + swVer2].description;
                flashVer = flashDescription.split(" ")[2].split(".")[0];
            } else {flashVer = -1;}
        }
        else if (navigator.userAgent.toLowerCase().indexOf("webtv/2.6") != -1) flashVer = 4;
        else if (navigator.userAgent.toLowerCase().indexOf("webtv/2.5") != -1) flashVer = 3;
        else if (navigator.userAgent.toLowerCase().indexOf("webtv") != -1) flashVer = 2;
        else flashVer = -1;
        return flashVer;
    }
    var AT_DETECT_FLASHVERSION = 0;
    if (AT_FLASH)
    {
        if (AT_FlashClick) {FlashClick = AT_ClickFn_ADFC_CUID_;}
        var ShockMode = 0;
        var versionStr = 0;
        if (navigator.appVersion.indexOf("MSIE") != -1 && navigator.appVersion.toLowerCase().indexOf("win") != -1 && !(navigator.userAgent.indexOf("Opera") != -1))
        {
            for (i=25;i>0;i--) {
                versionVB = VBGetSwfVer__ADFC_CUID_(i);
                if (typeof versionVB != "undefined") {
                    if (versionVB != 0){
                        versionStr = versionVB.split(" ")[1].split(",")[0];
                        if (versionStr>=AT_FLASHVERSION) {i=0;}
                    }
                }
            }
        }
        else {
            versionStr = JSGetSwfVer_ADFC_CUID_();
        }
        if (versionStr >= AT_FLASHVERSION) { ShockMode = 1;}
        AT_DETECT_FLASHVERSION = versionStr;
    }
    if ('_ADFC_CUID_'!='_ADFC'+'_CUID_'){
        if (AT_FLASH && (AT_FLASH.search(/\w+\:\/\//)!=0)) {AT_FLASH='_ADPATH_'+AT_FLASH;}
        if (AT_IMAGE && (AT_IMAGE.search(/\w+\:\/\//)!=0)) {AT_IMAGE='_ADPATH_'+AT_IMAGE;}
    }
    AT_MULTICOUNT[0]="_ADCOUNT_";  //Support for ViewCount
    for (var i_adtech=0;i_adtech<AT_MULTICLICK.length;i_adtech++){
        if (AT_MULTICLICK[i_adtech]) {
            if (!AT_CLICKVAR[i_adtech]) {
                AT_CLICKVAR[i_adtech]="clickTAG"+i_adtech;
            }
            if (AT_MULTICLICK[i_adtech].substr(0,11)=='javascript:') {
                AT_MULTICLICKSTR += "&" + AT_CLICKVAR[i_adtech] + "=" + escape(AT_MULTICLICK[i_adtech]);
                AT_FLASHVARSSTR += "&" + AT_CLICKVAR[i_adtech] + "=" + escape(AT_MULTICLICK[i_adtech]);
            } else {
                AT_MULTICLICKSTR += "&" + AT_CLICKVAR[i_adtech] + "=" + escape("_ADCLICK_") + escape(AT_MULTICLICK[i_adtech]);
                AT_FLASHVARSSTR  += "&" + AT_CLICKVAR[i_adtech] + "=" + escape("_ADCLICK_") + escape(AT_MULTICLICK[i_adtech]);
            }
        }
    }
//## if AT_FLASHVERSION > 5 use FLASHVARS
    if (AT_FLASHVERSION >5) {
        AT_VARSTRING ="?targetTAG="+AT_TARGET_ADFC_CUID_+"&clickTarget="+escape(AT_TARGET_ADFC_CUID_);
        AT_VARSTRING += "&pathTAG="+escape(AT_BASE);
    } else {
        AT_VARSTRING = AT_MULTICLICKSTR;
        AT_VARSTRING +="&targetTAG="+AT_TARGET_ADFC_CUID_+"&clickTarget="+escape(AT_TARGET_ADFC_CUID_);
        AT_VARSTRING += "&pathTAG="+escape(AT_BASE);
        AT_FLASHVARSSTR="";
    }
//if (AT_FAKEPOPUP) {
    AT_VARSTRING += "&closeTAG=" + escape("javascript:closeAdLayer_ADFC_CUID_()")
//}
//if (AT_FAKEPOPUP_start_opened) {
    AT_VARSTRING += "&openTAG=" + escape("javascript:openAdLayer_ADFC_CUID_()")
//}
    AT_VARSTRING += "&expandTAG=" + escape("javascript:expand_ADFC_CUID_()");
    AT_VARSTRING += "&collapseTAG=" + escape("javascript:collapse_ADFC_CUID_()");
    AT_VARSTRING += "&clicktarget=_blank&clickTarget=_blank&clickTARGET=_blank";
    var AT_MULTICOUNTARR=new Array;
    for (var i_adtech=0;i_adtech<AT_MULTICOUNT.length;i_adtech++)
        if (AT_MULTICOUNT[i_adtech])
        { AT_MULTICOUNTARR[i_adtech]=new Image;
            AT_MULTICOUNTARR[i_adtech].src=""+AT_MULTICOUNT[i_adtech];
        }
    AT_WIDTH_HEIGHT=(AT_WIDTH_HEIGHT)?(' '+AT_WIDTH_HEIGHT+' '):'_ADFC_WIDTH_HEIGHT_';
    if (AT_WIDTH_HEIGHT.length<19 && "_ADFC_CUID_"=="12345") //only on test server
    { alert('Error: AT_WIDTH_HEIGHT must be set for\n1x1 Content Units in the Template config!');}
    if (!AT_IMGCLICK) {AT_IMGCLICK=AT_CLICK;};
    if (!AT_TEXT) {AT_TEXT="_ADFC_ALT_TEXT_";};
    if (!AT_BASE) {AT_BASE="_ADPATH_"}
    if (AT_EXPANDABLE && AT_EXPANDABLE != 'false'){
        AT_FAKEPOPUP=true;
        AT_FAKEPOPUP_left=-0;
        AT_FAKEPOPUP_top=-0;
    }
    if (AT_MICROSITE!=""){
        var AT_MICROSITE_ADFC_CUID_="toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,"+AT_MICROSITE.replace(/ height=/,",height=");
    }
    if (AT_FlashClick || AT_MICROSITE!="")
    {              AT_COUNT=''
        if ('_ADFC_CUID_'!='_ADFC'+'_CUID_') AT_COUNT=escape('_ADCLICK_')
        AT_VARSTRING="?cli"+"ckTAG="+AT_CLICK+"','','"+AT_MICROSITE_ADFC_CUID_+"'))";
        AT_TARGET_ADFC_CUID_="_self";
    }
    window.AT_ClickFn_ADFC_CUID_= function (click)
    {
        eval(AT_CLICK);
    };

    if (navigator.userAgent.indexOf('MSIE')>0 && navigator.userAgent.indexOf('Opera')<0) {
        var sv_ADFC_CUID = 'Sub AT_OBJECT_ADFC_CUID__FSCommand(ByVal command, ByVal args)\r\n'+
            'call AT_OBJECT_ADFC_CUID__DoFSCommand(command, args)\r\n'+
            'end sub';
        if (typeof inFIF != "undefined") {
            parent.window.execScript(sv_ADFC_CUID, "VBScript");
        }
        else {     window.execScript(sv_ADFC_CUID, "VBScript");
        }
    }
    //### BROWSER CHECK ###
    var AT_agent = navigator.userAgent.toLowerCase();
    var AT_major = parseInt(navigator.appVersion);
    // ####### Different browser types
    // ####### Different browser types
    var AT_is_nav  = ((AT_agent.indexOf('mozilla')!=-1) && (AT_agent.indexOf('spoofer')==-1) && (AT_agent.indexOf('compatible') == -1) && (AT_agent.indexOf('opera')==-1) && (AT_agent.indexOf('webtv')==-1));
    var AT_is_ie=(AT_agent.indexOf("msie") != -1) || (AT_is_nav && AT_major >= 5);
    var AT_IS_FIREFOX = AT_agent.indexOf('firefox')!=-1;
    var AT_IS_OPERA = AT_agent.indexOf('opera')!=-1;
    if (AT_IS_OPERA) AT_is_ie = false;
    if (AT_is_nav) AT_is_ie = false;
    if (AT_IS_FIREFOX) AT_is_ie = false;
// ## END
    adtech_flashinc="";
    if (AT_EXPANDABLE && AT_EXPANDABLE != 'false')
        adtech_flashinc+='<div id="AT_ANCHOR_DIV_ADFC_CUID_" style="overflow:hidden;position:relative;width:100px;height:100px;z-index:' + AT_ZINDEX + ';">';
    if (AT_FAKEPOPUP) {
        adtech_flashinc+='<div id="AT_DIV_ADFC_CUID_" ' ;
        if ( AT_EXPANDABLE && AT_EXPANDABLE != 'false' && !AT_LAYERMANUALRESIZE ) {
            adtech_flashinc+=' onmouseout="collapse_ADFC_CUID_()" onmouseover="expand_ADFC_CUID_()"';
        }
        adtech_flashinc+=' style="width:100px;height:100px;z-index:' + AT_ZINDEX + ';position:absolute;top:'+AT_FAKEPOPUP_top+'px;left:'+AT_FAKEPOPUP_left+'px;'+(!AT_FAKEPOPUP_start_opened?"display:none;":"")+'">';
    }
    if (ShockMode && AT_FLASH){
        if (AT_EXPANDABLE && AT_EXPANDABLE !='false') AT_WIDTH_HEIGHT = "width=0 height=0";
        adtech_flashinc+='<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://active.macromedia.com/flash2/cabs/swflash.cab#version=5,0,0,0" id="AT_OBJECT_ADFC_CUID_" name="AT_OBJECT_ADFC_CUID_" '+AT_WIDTH_HEIGHT+'>';
        adtech_flashinc+='<param name=movie va'+'lue="'+AT_FLASH+ AT_VARSTRING +'&CURRENTDOMAIN='+AT_CURRENTDOMAIN+ '">';
        adtech_flashinc+='<param name=quality value=' + AT_FlaQual + '>';
        adtech_flashinc+='<param name="base" value="'+AT_BASE+'">';
        if (AT_FLASHVERSION > 5)
            adtech_flashinc+='<param name="flashvars" value="'+AT_FLASHVARSSTR+'">';
        adtech_flashinc+='<param name="allowscriptaccess" value="always">';
        if (AT_FLASH_BGCOLOR) {adtech_flashinc+='<param name="bgcolor" value="'+AT_FLASH_BGCOLOR+'">';}
        adtech_flashinc+='<param name="swLiveConnect" value="true">';
        adtech_flashinc+='<param name="wmode" value="' + AT_WMODE + '">';
        adtech_flashinc+='<embed sr'+'c="'+AT_FLASH+AT_VARSTRING+ '&CURRENTDOMAIN='+AT_CURRENTDOMAIN+ '" id="AT_OBJECT_ADFC_CUID_"';
        if (AT_FLASH_BGCOLOR) {adtech_flashinc+=' bgcolor="'+AT_FLASH_BGCOLOR+'"'}
        adtech_flashinc+=' name="AT_OBJECT_ADFC_CUID_" base="' + AT_BASE + '" quality="' + AT_FlaQual + '"';
        if (AT_FLASHVERSION > 5)
            adtech_flashinc+=' flashvars="'+AT_FLASHVARSSTR+'"';
        adtech_flashinc+=' allowScriptAccess="always" swLiveConnect=true '+AT_WIDTH_HEIGHT;
        adtech_flashinc+=' wmode="' + AT_WMODE + '"';
        adtech_flashinc+=' type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash">';
        adtech_flashinc+='</embed>';
        adtech_flashinc+='</object>';
    } else {
        if (AT_MICROSITE) {
            adtech_flashinc+='<a hr'+'ef="javascript:AT_ClickFn_ADFC_CUID_(\''+AT_IMGCLICK+'\')" target="_self">';
        } else {
            adtech_flashinc+='<a href="'+'_ADCLICK_'+AT_IMGCLICK+'" target="'+AT_TARGET_ADFC_CUID_+'">';
        }
        if (AT_IMAGE) {
            adtech_flashinc+='<img s'+'rc="'+AT_IMAGE+'" WIDTH="' + AT_ALTIMAGEWIDTH + '" HEIGHT="' + AT_ALTIMAGEHEIGHT + '" alt="'+AT_TEXT+'" title="'+AT_TEXT+'" border="0">';
        }
        adtech_flashinc+='</a>';
    }
    if (AT_FAKEPOPUP) {
        adtech_flashinc+='</div>' ;
        if (AT_is_ie) {
            var _zindex = AT_ZINDEX-1;
            if (AT_EXPANDABLE && AT_EXPANDABLE != 'false') {_zindex= -4000;}
            adtech_flashinc+='<div id="HID_IFRAME__ADFC_CUID_" style="'+(!AT_FAKEPOPUP_start_opened?"display:none;":"")+'width:100px;height:100px;position:absolute;top:'+AT_FAKEPOPUP_top+'px;left:'+AT_FAKEPOPUP_left+'px;Z-INDEX:'+ _zindex +'">';
            adtech_flashinc+='<iframe id="HIDDER" style="FILTER: alpha (opacity=0);" width="0px" height="0px" src="about:blank"></iframe>';
            adtech_flashinc+='</div>';
        }
    }
    if (AT_EXPANDABLE && AT_EXPANDABLE != 'false' )
    {
        adtech_flashinc+='</div>';
    }
    if (typeof AD_vars != 'undefined')
        document.write('<scr'+'ipt type="text/javascript" src="_ADPATH_adtech_flashinc.js"></scr'+'ipt>');
    else
        document.write(adtech_flashinc);
    if (AT_FAKEPOPUP&&AT_FAKEPOPUP_autoclose) window.setTimeout ("closeAdLayer_ADFC_CUID_()",AT_FAKEPOPUP_autoclose);
    if (AT_FAKEPOPUP) {
        window.closeAdLayer_ADFC_CUID_=function(){document.getElementById("AT_DIV_ADFC_CUID_").style.display = "none";
            if (AT_is_ie) {
                var iframediv = document.getElementById('HID_IFRAME__ADFC_CUID_');
                iframediv.style.display = "none";
            }
        }
        window.openAdLayer_ADFC_CUID_=function() {document.getElementById("AT_DIV_ADFC_CUID_").style.display = "";
            if (AT_is_ie) {
                var iframediv = document.getElementById('HID_IFRAME__ADFC_CUID_');
                iframediv.style.display = "";
            }
        }
    }
    window.expand_ADFC_CUID_=function() {
        var thediv = document.getElementById('AT_DIV_ADFC_CUID_');
        var thediv2 = document.getElementById('AT_ANCHOR_DIV_ADFC_CUID_');
        if (AT_is_ie) {
            var iframediv = document.getElementById('HID_IFRAME__ADFC_CUID_');
            iframediv.style.display = "";
        }
        thediv.style.width = "0px";
        thediv.style.height = "0px";
        thediv2.style.overflow = "";
    }
    window.expand_width_ADFC_CUID_ = function(value) {
        var thediv = document.getElementById('AT_DIV_ADFC_CUID_');
        var thediv2 = document.getElementById('AT_ANCHOR_DIV_ADFC_CUID_');
        if (AT_is_ie) {
            var iframediv = document.getElementById('HID_IFRAME__ADFC_CUID_');
            iframediv.style.display = "";
        }
        thediv.style.width = value+"px";
        thediv2.style.overflow = "";
    }
    window.expand_height_ADFC_CUID_ = function(value) {
        var thediv  = document.getElementById('AT_DIV_ADFC_CUID_');
        var thediv2 = document.getElementById('AT_ANCHOR_DIV_ADFC_CUID_');
        thediv.style.height = value+"px";
        thediv2.style.overflow = "";
        if (AT_is_ie) {
            var iframediv = document.getElementById('HID_IFRAME__ADFC_CUID_');
            iframediv.style.display = "";
        }
    }
    window.collapse_ADFC_CUID_ =function() {
        var thediv  = document.getElementById('AT_DIV_ADFC_CUID_');
        var thediv2 = document.getElementById('AT_ANCHOR_DIV_ADFC_CUID_');
        thediv.style.width = "100px";
        thediv.style.height = "100px";
        thediv2.style.overflow = "hidden";
        if (AT_is_ie) {
            var iframediv = document.getElementById('HID_IFRAME__ADFC_CUID_');
            iframediv.style.display = "";
        }
    }
    window.restartMovie_ADFC_CUID_=function(){movie=document.getElementById("AT_OBJECT_ADFC_CUID_");movie.REWIND();movie.PLAY()}
    window.stopMovie_ADFC_CUID_=function()  {document.getElementById("AT_OBJECT_ADFC_CUID_").STOP();}
    window.AT_OBJECT_ADFC_CUID__DoFSCommand=function(command,value){
        if (command.search(/(click|link|url)/i)>=0){
            AT_ClickFn_ADFC_CUID_(command.replace(/[^0-9]/g,''));
        } else if (command.search(/(hide|close|stop|halt|done|quit)/i)>-1) {
            closeAdLayer_ADFC_CUID_();
        } else if (command.search(/(show|open|start|spawn|launch)/i)>-1) {
            if(command != "showmenu")
                openAdLayer_ADFC_CUID_();
        }else if (command == "expand") {
            expand_ADFC_CUID_();
        } else if (command == "collapse") {
            collapse_ADFC_CUID_();
        } else if (command == "expandwidth") {
            expand_width_ADFC_CUID_(value);
        } else if (command == "expandheight") {
            expand_height_ADFC_CUID_(value);
        } else if (command == "redirectToPage") {
            window.open("_ADCLICK_"+value, "redirectwin", "");
        }
    }
    var restartMovie=restartMovie_ADFC_CUID_;
    var stopMovie=stopMovie_ADFC_CUID_;
    if (AT_FAKEPOPUP) {
        var closeAdLayer=closeAdLayer_ADFC_CUID_;
        var adlayerhider=closeAdLayer;
        var openAdLayer=openAdLayer_ADFC_CUID_;
    }

    kroma_disposable_object = {
        /*
         * properties
         */
        width : "",
        height : "",
        id : "object",
        stylesheet : null,
        adcontent : {
            id : "Ad",
            movie : adtech.getPlugin('standard', options, context, frame),
            allowscriptaccess : "always",
            allownetworking : "all",
            allowfullscreen : "true",
            width : "",
            height : "",
            quality : "high",
            wmode : "opaque",
            clicktags : []
        },
        overlaycontent : {
            id : "overlay",
            movie : options.flashvars.clickTAG,
            allowscriptaccess : "always",

            allownetworking : "all",
            allowfullscreen : "true",
            width : "",
            height : "",
            quality : "high",
            wmode : "transparent",
            clicktags : []
        },
        /*
         * methods
         */
        stringify : function(obj) {
            var result = "";
            for(var key in obj) {
                result += key + " : " + obj[key] + "\n";
            }
            return result;
        },
        getFlashEmbedString : function(paramP) {// p = params object
            var e = "";
// e = embedString
            var c = "";
// c = clickTagString
            if(!paramP.id) {
                paramP.id = "finnAd_overlayFlash_" + Math.random(100000, 1000000);
            }
            if(!paramP.allowscriptaccess) {
                paramP.allowscriptaccess = "always";
            }
            if(!paramP.allownetworking) {
                paramP.allownetworking = "all";
            }
            if(!paramP.allowfullscreen) {
                paramP.allowfullscreen = "true";
            }
            if(!paramP.quality) {
                paramP.quality = "high";
            }
            if(!paramP.wmode) {
                paramP.wmode = "opaque";
// Chrome has a bug for wmode=window
            }
            e += '<object id="' + paramP.id + '" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" ';
            e += 'width="' + paramP.width + '" height="' + paramP.height + '">';
            e += '<param name="allowscriptaccess" value="' + paramP.allowscriptaccess + '">';
            e += '<param name="allownetworking" value="' + paramP.allownetworking + '">';
            e += '<param name="allowfullscreen" value="' + paramP.allowfullscreen + '">';
            e += '<param name="quality" value="' + paramP.quality + '">';
            e += '<param name="wmode" value="' + paramP.wmode + '">';
            e += '<param name="movie" value="' + options.flashvars.clickTAG + '">';
            e += '<embed src="' + options.flashvars.clickTAG + '" name="' + paramP.id + '" quality="' + paramP.quality + '" width="' + options.attr.emb_w + 'px' + '" height="' + options.attr.emb_h + 'px' + '" wmode="' + paramP.wmode + '" allowscriptaccess="' + paramP.allowscriptaccess + '" allownetworking="' + paramP.allownetworking + '" allowfullscreen="' + paramP.allowfullscreen + '" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer">';
//            e += '<embed src="http://ad-emea.doubleclick.net/clk;249722413;74706036;g?http://finn.oasfile.aftenposten.no/2011/KKS/Expert/1149/expert_magasin_1149.swf" name="' + paramP.id + '" quality="' + paramP.quality + '" width="' + paramP.width + '" height="' + paramP.height + '" wmode="' + paramP.wmode + '" allowscriptaccess="' + paramP.allowscriptaccess + '" allownetworking="' + paramP.allownetworking + '" allowfullscreen="' + paramP.allowfullscreen + '" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer">';

            e += '</object>';
            return e;
        }// end function kroma_getEmbedString()
    };
    // end disposable
    kroma_disposable_object.styles = ".kroma_overlay_background{ display:none; background-color:#000000; opacity:0.6; filter:alpha(opacity=60); zoom:1; position:absolute; top:0px; left:0px; min-width:100%; min-height:100%; z-index:1099000; }\n .kroma_overlay_popup{ display:none; position:fixed; top:30%; left:29%; padding:0px 0px 0px 0px; z-index:1099001; }";
    /*
     * Define styles
     */
    /*
     * Attach stylesheet to the DOM
     */
    var __parentWindow = parent||window; // Parent.window or window.
    var kromaStyleInjected = false;
    var kromaStyleInject = function(){
        if (kromaStyleInjected) return;
        var ss = __parentWindow.document.createElement('style');
        ss.setAttribute("type", "text/css");
        __parentWindow.document.body.appendChild(ss);
        if (ss.styleSheet) { // IE
            ss.styleSheet.cssText = kroma_disposable_object.styles;
        } else { // Other than IE
            var tt = __parentWindow.document.createTextNode(kroma_disposable_object.styles);
            ss.appendChild(tt);
        }
        kromaStyleInjected = true;
    }
    /*
     * Apply styles
     *
     */

    function kroma_overlay_show_hide(doHide) {
        kromaStyleInject();

        var $j = jQuery;
        var documentContext = __parentWindow.document;

        kroma_debug(documentContext);

        var getDocumentHeight = function() {
            return Math.max(
                Math.max(documentContext.body.scrollHeight, documentContext.documentElement.scrollHeight),
                Math.max(documentContext.body.offsetHeight, documentContext.documentElement.offsetHeight),
                Math.max(documentContext.body.clientHeight, documentContext.documentElement.clientHeight)
            ) + 'px';
        }




        var overlayHeight = options.attr.frame_h + 'px';
        var overlayWidth = options.attr.frame_w + 'px';

        var overlaycontentHeight = options.attr.emb_h + 'px';
        var overlaycontentWidth = options.attr.emb_w + 'px';
        var bgColor = options.attr.hex;

        kroma_disposable_object.overlaycontent.width = overlayWidth - 5;
        kroma_disposable_object.overlaycontent.height = overlayHeight - 30;

        $j('#kroma_overlay_background,#kroma_overlay_popup', documentContext).remove();
        $j('body', documentContext).append('<div id="kroma_overlay_background" style="display: none" class="kroma_overlay_background"></div>').append('<div id="kroma_overlay_popup" style="display: none" class="kroma_overlay_popup"><div style="float:right;clear:both; margin:5px 5px 5px 0;"><h3 style="margin:0;"><a onclick="kroma_overlay_show_hide(true);return false;" href="#">Lukk X</a></h3></div></div>').find('#kroma_overlay_background', documentContext).css('height', getDocumentHeight()).click(function(){ kroma_overlay_show_hide(true); }).end().find('#kroma_overlay_popup', documentContext).css({width: overlayWidth, height: overlayHeight});

        if(doHide) {
            $j("#kroma_overlay_popup, #kroma_overlay_popup", documentContext).css("display","none");
            $j("#kroma_overlay_popup", documentContext).html('');
            $j("#kroma_overlay_background, #kroma_overlay_popup", documentContext).fadeOut(200);
        } else {
            $j("#kroma_overlay_popup, #kroma_overlay_popup", documentContext).css("display","block");
            $j("#kroma_overlay_popup").css("background-color", bgColor)
            var expert24112011_overlaycontent = kroma_disposable_object.getFlashEmbedString(kroma_disposable_object.overlaycontent);
            $j("#kroma_overlay_popup", documentContext).append(expert24112011_overlaycontent);
            $j("#kroma_overlay_background, #kroma_overlay_popup", documentContext).show();
        }
    }
    __parentWindow.kroma_overlay_show_hide = kroma_overlay_show_hide;
    function kroma_debug() {
        if (typeof(console) != 'undefined') {
            console.log(arguments);
        }
    }

});

/**
 * Expandable
 *
 * Used also by the "collapsible toppbanner", which starts out opened, and collapses after a set amount of seconds.
 * We can differentiate between the two by checking whether "tout" (timeout) has a value. If an ad is booked as "expandable"  and with a timeout
 * - we presume it is to be shown opened initially. See the if-check below.
 */

adtech.setPlugin( 'expandable', function (options, context, frame) {

    $('#'+ options.container).wrap('<div id="'+ options.container +'_wrapper" />');

    var $obj_parent = $('#'+ options.container).parent(),
        $obj_grand_parent = $obj_parent.parent();

    // Set FLASHVAR "placement" param to the container's id- so the flash function expandThis (called from within the flash file)
    // will know what container to expand and collapse!
    options.flashvars.placement = options.container;

    // Get assets
    adtech.getPlugin('standard', options, context, frame);

    $obj_grand_parent.data('expandable_direction', options.attr.direction);

    // Push content down or lay over content?
    if (typeof options.attr.push !== 'undefined') {
        $obj_grand_parent.data('expandable_push', 'true');
    } else {
        $obj_parent.css({ position: 'absolute', top: 0 });
    }

    $obj_parent.parent().show();

    // Is this just a collapsible ad, which should collapse back to its original size after a few senconds? If so, skip this step.
    if (typeof options.attr.tout === 'undefined' || options.attr.tout === 0) {

        if (typeof options.attr.exp_w !== 'undefined' && typeof options.attr.exp_h !== 'undefined') {
            $obj_parent.css({
                width: options.attr.exp_w + 'px'
                ,height: options.attr.exp_h + 'px'
                ,overflow: 'hidden'
            });
            $obj_parent.parent().css({ height: options.attr.exp_h + 'px' });
            // We need to store the "collapsed" ad sizes for later use!
            $obj_parent.data('collapsed_size', { w: options.attr.exp_w, h: options.attr.exp_h });
            // Hack for ad marker to show in right pos..
            $('<div class="ad_marker_keep_height" />').css({height: (options.attr.exp_h) + 'px', width: '1px'}).appendTo($obj_grand_parent);
        } else {
            // Hack for ad marker to show in right pos..
            $('<div class="ad_marker_keep_height" />').css({height: options.config ? options.config.height : options.attr.imgH + 'px', width: '1px'}).appendTo($obj_grand_parent);
        }

    } else {
        // Timeout is set, this is e.g. a "collapsible top banner".

        $obj_parent.css({ overflow: 'hidden' })
            .data('collapsed_size', { w: options.attr.exp_w, h: options.attr.exp_h });

        if (typeof options.attr.push === 'undefined') {
            // IE7 specific hack, targets body class
            // Because IE7 nulls out the z-index for each position:relative up the DOM tree.
            if ($('body').hasClass('ie7')) {
                $obj_grand_parent.parent().css({zIndex: 10000});
            }
            $obj_grand_parent.css({  paddingTop: options.attr.exp_h + 'px', zIndex: 10000});
        }

        // Timeout for collapsing the "collapsible top banner"
        setTimeout(function() {
            $obj_parent.animate({
                height: options.attr.exp_h + 'px'
            }, function () {

            });
            $obj_grand_parent.css({ zIndex: 'auto'});
            // options.timeout is a value set in the banner template - and must be setup as an option in the banner template
            var dummy = $('<div id="dummyTop" style="display:none;position:absolute;left:-10000px"></div>');
            adtech.getPlugin('standard', {
                attr: options.attr2 ? options.attr2 : options.attr
                ,config: options.config2 ? options.config2 : options.config
                // Set id
                ,container:  options.container
                ,flashvars: options.flashvars
            });
        }, (options.attr.tout * 1000) + 2000);
    }

    // Is this just one file? If so, exit now
    if (typeof options.attr2 === 'undefined' && typeof options.config2 === 'undefined') { return false; }

    // Replace current options object with new object containing relevant data (from either attr2 og config2)
    var new_opts = {
        attr: options.attr2 ? options.attr2 : options.attr
        ,config: options.config2 ? options.config2 : options.config
        // Set id
        ,container:  options.container + '_expanded'
        ,flashvars: options.flashvars
    };

    // Overwrite placement flash-param for expandable flash
    new_opts.flashvars.placement = options.container + '_expanded';

    // Attach object data to DOM object with data()
    $obj_grand_parent.data('expandable_options', new_opts);

});

/**
 * Expands and collapses an ad container. Called from actionscript using eight adtech.expandCollapse('show', placementid) / adtech.expandCollapse('hide', placementid),
 * or expandThis(placementid) / collapseThis(placementid).
 *
 * @param {String} how Method. "show" or "hide"
 * @param {String} obj ID of the ad container
 */

adtech.expandCollapse = function (how, obj) {

    // IE7 specific hack, targets body class
    if ($('body').hasClass('ie7')) {
        $('.ie7 #page, .ie7 .ad').css({position: 'static'});
        $('.ie7 #adRight').css({zIndex: 1200});
    }

    var $obj = $('#' + obj),
        $obj_parent =  $obj.parent(),
        $obj_grand_parent = $obj_parent.parent(),
        $obj_prev = $obj.prev(),
        pushDown = typeof $obj_grand_parent.data('expandable_push') !== 'undefined',
        isOneFile = typeof $obj_grand_parent.data('expandable_options') === 'undefined',
        expandedFlashCalling = $obj[0].id.indexOf('expanded') !== -1,
        expandedFlashNotLoaded = $obj_parent.siblings('[id$="expanded_wrapper"]').length === 0,
        w = $obj.attr('width'),
        h = $obj.attr('height');

    // Only call banner once
    if (expandedFlashNotLoaded && !expandedFlashCalling && !isOneFile) {

        // Retrieve data containing toppbanner_expanded data with data()
        var options = $obj_grand_parent.data('expandable_options');

        // Container for flash file
        $('<div id="'+ options.container +'_wrapper"><div id="'+ options.flashvars.placement +'"></div></div>')
            .insertBefore($obj_parent);

        // Insert banner number two, with new options
        adtech.getPlugin('standard', options);
    }

    if (!isOneFile) {
        // Show or hide. show? - find next object. hide? - find previous
        $obj_parent.hide()[ how === 'show' ? 'prev' : 'next' ]().show();
        if (!pushDown && how == 'show') {
            $obj_grand_parent.find('div:first-child').css({ position: 'absolute'});
            $obj_grand_parent.css({ height: h +'px', width: w + 'px' });
        }
    }

    if (isOneFile) {
        if (!pushDown) {
            // Expandable using overflow-properties
            if (how === 'show') {
                // Show. Leave container at its collapsed height, but set overflow to visible
                $obj_grand_parent.addClass('expOpen');
            } else {
                // Hide. Leave container at its collapsed height, but set overflow to hidden
                $obj_grand_parent.removeClass('expOpen');
                w = $obj_parent.data('collapsed_size').w;
                h = $obj_parent.data('collapsed_size').h;
            }
        }
        if (pushDown && how === 'hide') {
            // Hide. This container thas been expanded, now we want it back to its collapsed size
            w = $obj_parent.data('collapsed_size').w;
            h = $obj_parent.data('collapsed_size').h;
        }
    } else {
        if (expandedFlashCalling) {
            // Closing..
            $obj_grand_parent.removeClass('expOpen');
            w = $obj_prev.attr('width');
            h = $obj_prev.attr('height');
            // Remove appended file completely (to e.g. reload sound)
            $obj_grand_parent.find('div:first-child').remove();
        } else {
            $obj_grand_parent.addClass('expOpen');
            w = $obj.attr('width');
            h = $obj.attr('height');
        }
    }

    if (pushDown) {
        // Set position of div that holds adMarker in place (by setting a 1px wide div), if ad is set to "push down" content.
        if (how === 'hide' || expandedFlashCalling) {
            // Closing.. Set back to static
            $('.ad_marker_keep_height').css({position: 'static'});
        } else {
            // Opening.. Set to pos absolute so there is no "extra" height
            $('.ad_marker_keep_height').css({position: 'absolute'});
        }
    }

    // Set w/h of parent container
    $obj_parent.css({
        height: h + 'px'
        ,width: w + 'px'
    });

    // Should this push content down? Nope
    if (!pushDown) {
        var container = isOneFile ? $obj_parent :  $obj_parent[how === 'show' ? 'prev' : 'next'](),
            direction = $obj_grand_parent.data('expandable_direction');
        // If yes, position the flash files absolutely
        container
            .css({
            top: direction.indexOf('N') !== -1 ? 'auto' :  0  // North? Set top to auto. South? Set top to 0
            ,right:  direction.indexOf('E') !== -1 ? 'auto' : 0  // East? Set right to auto. West? Set right to 0
            ,bottom: direction.indexOf('N') !== -1 ? 0 : 'auto' // North? Set bottom to 0. South? Set bottom to auto
            ,left: direction.indexOf('E') !== -1 ? 0 : 'auto' // East? Set left to 0. West? Set left to auto
        });
    }

};

/**
 * Global function to call adtech.expandCollapse('show', obj)
 *
 * @deprecated
 * @param {String} obj ID of the ad container
 */

function expandThis(obj) {
    return adtech.expandCollapse('show', obj);
}

/**
 * Global function to call adtech.expandCollapse('hide', obj)
 *
 * @deprecated
 * @param {String} obj ID of the ad container
 */

function collapseThis(obj) {
    return adtech.expandCollapse('hide', obj);
}

/**
 *   This is one dirty hack.. omg
 *   For expanding the left L ad.
 *   Hopefully this can be thrown in the dump.
 */

function expandLAd () {

    var leftRefId = "adLeft",
        expandedContainerId = 'l_expanded',
        expandedAlias = adtech.getCompanion('l_expanded').alias,
        closeX = '<span id="LBarX">X</span>';

    var expBanner = $(expandedContainerId);
    if (!expandedAlias) return;

    if (expBanner.length === 0) {

        var expdiv = adtech.Create( 'div',
            {
                id: expandedContainerId,
                className: 'ohidden'
            });
        AdElement.get(leftRefId).append(expdiv);
        adtech.loadFIF(expandedContainerId, expandedAlias);
        $('#l_expanded').append(closeX);
        $('#LBarX').mousedown( function(e) {
            $(this).parent().remove();
        });

        expBanner.show();
    }

}

/**
 * Legacy, Aftenbladet function for collapsing ad positions. To be removed
 *
 * @deprecated
 * @param {String} placement Placement ID
 */

function collapseAdLayers (placement) {
    if ($(placement).contents().find('img[alt="AdTech Ad"], img[src$="clearpix.gif"]').length > 0)  {
        $(placement).parents('.ad:first').hide();
    }
}

/**
 *  Function for hiding empty banners and adtech banners, run on doc.ready
 */

$(document).ready(function () {                                                                                      //

    if (typeof mno.publication !== 'undefined') {

        $('.ad').each(function(i) {

            // Search in friendly iframe, or not
            var el = $(this).find('iframe[src *="' + mno.publication.url +'"]').length > 0 ? $(this).find('iframe').contents() : $(this);

            // Check for default adtech ads..
            if (el.find('img[src$="trans.gif"], img[alt="AdTech Ad"], img[src*="Default_Size"]').length > 0) {
                $(this).hide();
            }

        });
    }

});

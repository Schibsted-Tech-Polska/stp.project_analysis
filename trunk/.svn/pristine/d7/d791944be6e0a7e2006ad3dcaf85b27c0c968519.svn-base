/**
 * Schibsted Vekst Traffic Fund
 * - Record internal Schibsted traffic in Traffic Fund
 * - Bind recording functionality to elements
 *
 * Author:
 * Kristoffer Nordström
 *
 * Copyright:
 * Media Norge Digital (c) 2011, All Rights Reserved
 *
 * Requires:
 * jquery-1.4.2.min.js (delegate)
 * jquery-1.5.min.js (jsonp)
 */
mno.namespace('mno.utils.trafficfund');
mno.utils.trafficfund = (function($) {
    var domainMap = {
        'annonsepoolen':    ['annonsepoolen.no'],
        'aftenbladet':      ['aftenbladet.no', 'stavangeraftenblad.no', 'rogalyd.no', 'aenergi.no'],
        'aftenposten':      ['aftenposten.no', 'ap.no', 'amagasinet.no', 'kmag.no', 'oslopuls.no', 'golf.no', 'forbruker.no', 'mamma.no', 'hyttemag.no', 'nyhetene24.no', 'nyhetene24.no.msn.com'],
        'bt':               ['bt.no', 'bergenstidende.no'],
        'dinmat':           ['dinmat.no'],
        'e24':              ['e24.no'],
        'finn':             ['finn.no'],
        'flytteportalen':   ['flytteportalen.no'],
        'fvn':              ['fvn.no', 'fevennen.no', 'f\u00e6vennen.no', 'fedrelandsvennen.no', 'f\u00e6drelandsvennen.no', 'fvnmobil.no'],
        'letsdeal':         ['letsdeal.no'],
        'mittanbud':        ['mittanbud.no'],
        'moteplassen':      ['moteplassen.com', 'moteplassen.no'],
        'nabolag':          ['nabolag.no'],
        'penger':           ['penger.no'],
        'prisjakt':         ['prisjakt.no'],
        'vg':               ['vg.no', 'vgb.no', 'vgd.no', 'nynorskvg.no', 'dinepenger.no', 'vektklubb.no', 'minmote.no', 'pent.no']
    },
    isSupportsXMLHttpRequest = (typeof XMLHttpRequest != 'undefined' && 'withCredentials' in new XMLHttpRequest()),
    dwrScriptSessionId = '81B7609CE4175AF8B69184E3D80F1D55' + Math.floor(Math.random()*1000)/*,
    jsDebugTrafficFund = mno.utils.params.getParameter('jsDebugTrafficFund')*/;

    $(document).delegate('a', 'click mouseup', trackClick);

    function trackClick(e) {
        if(e.type==='mouseup' && !($.browser.msie && e.ctrlKey) && !(e.which && e.which==2)) {
            return;
        }

        var href = e.type==='submit' ? this.action : this.href;

        if(verifyDomains(window.location.href, href)) {
            recordClick(removeProtocol(window.location.href), href);
        }
    }

    function removeProtocolSubdomain(href) {
        var regexpDomainNode = new RegExp(/^[A-Za-z0-9]+\./),
            regexpSubSubdomain = new RegExp(/^[A-Za-z0-9]+\.[A-Za-z0-9]+\.[A-Za-z0-9]+\.[A-Za-z0-9]+/),
            regexpSubdomain = new RegExp(/^[A-Za-z0-9]+\.[A-Za-z0-9]+\.[A-Za-z0-9]+/);

        href = removeProtocol(href);

        if(href.match(regexpSubSubdomain)) {
            href = href.replace(regexpDomainNode, '').replace(regexpDomainNode, '');
        }
        else if(href.match(regexpSubdomain)) {
            href = href.replace(regexpDomainNode, '');
        }

        return href;
    }

    function removeProtocol(href) {
        var regexpProtocol = new RegExp(/^[a-z]+:\/\//);

        return href.replace(regexpProtocol, '');
    }

    function removePath(href) {
        return href.indexOf('/') > 0 ? href.substring(0, href.indexOf('/')) : href;
    }

    function formatPageParam(href) {
        return href.indexOf('/') > 0 ? href.substring(href.indexOf('/'), href.length) : href;
    }

    /* - Rewrite links (with redirect functionality) to final destination URI */
    function urlRewrite(href) {
        var regexpHeliosURI = new RegExp(/^[a-z]+:\/\/helios\.[a-z]+\.no\//),
            regexpAdtechURI = new RegExp(/^[a-z]+:\/\/adserver.adtech.de\//),
            regexpXitiURI = new RegExp(/^[a-z]+:\/\/[a-z0-9]+\.xiti.com\//),
            regexpAdmetaURI = new RegExp(/^[a-z]+:\/\/rms.admeta.com\//);

        if(href.match(regexpHeliosURI) != null ||
            href.match(regexpAdtechURI) != null ||
            href.match(regexpXitiURI) != null) {
            if(href.indexOf('url=') > 0) {
                href = href.substring(href.indexOf('url=')+4, href.length);
            }
            else if(href.indexOf('link=') > 0) {
                href = href.substring(href.indexOf('link=')+5, href.length);
            }
        }
        if(href.match(regexpAdmetaURI) != null) {
            href = 'http://www.moteplassen.com/';
        }

        return href;
    }

    /* - Verifies domains to make sure they should be tracked */
    function verifyDomains(host, href) {
        var isTrackHref = false, isTrackHost = false;

        host = removeProtocolSubdomain(host);
        href = removeProtocolSubdomain(urlRewrite(href));

        $.each(domainMap, function(key, value) {
            if($.inArray(removePath(href), value) > -1 &&
                $.inArray(removePath(host), value) == -1) {
                isTrackHref = true;
            }
            if($.inArray(removePath(host), value) > -1) {
                isTrackHost = true;
            }
        });

        /*if(jsDebugTrafficFund && !(isTrackHref && isTrackHost)) {
            console.log("Traffic Fund: Error processing - host: "+host+" href: "+href);
        }*/

        return isTrackHref && isTrackHost;
    }

    /* - Make request to Traffic Fund server */
    function recordClick(from, to) {
        var trackUrl = 'http://click.trafikkfondet.no/trafikfonden/dwr/call/plaincall/ClickServer.recordClick.dwr' +
                '?callCount=1' +
                '&batchId=0' +
                '&c0-id=0' +
                '&page=' + encodeURIComponent(formatPageParam(from)) +
                '&scriptSessionId=' + dwrScriptSessionId +
                '&c0-scriptName=ClickServer' +
                '&c0-methodName=recordClick' +
                '&c0-param0=string:' + encodeURIComponent(from) +
                '&c0-param1=string:' + encodeURIComponent(urlRewrite(to));

        if(isSupportsXMLHttpRequest) {
            xhrTrack(trackUrl);
        }
        else {
            imgTrack(trackUrl);
        }
        //ajaxTrack(trackUrl);
    }

    function ajaxTrack(trackUrl) {
        $.ajax({
                    async: false,
                    cache: false,
                    crossDomain: true,
                    dataType: 'jsonp',
                    url: trackUrl
                });
    }

    function xhrTrack(trackUrl) {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', trackUrl, false);
        xhr.onreadystatechange = function() {
            if(xhr.readyState >= this.OPENED) {
                xhr.abort();
            }
        };
        try {
            xhr.send();
        }
        catch(e) {
        }
    }

    function imgTrack(trackUrl) {
        var trackImg = new Image(1,1);
        trackImg.src = trackUrl;
    }

    return {
        trackClick: trackClick,
        recordClick: recordClick,
        verifyDomains: verifyDomains
    }
})(jQuery);

/**
 * Traffic Fund legacy API
 * - Needed in case of 3rd party content integration with the original Traffic Fund script
 */
function tf_recordClickAndNavigate() {
    mno.utils.trafficfund.trackClick();
}

function tf_recordClickToUrl(to) {
    if(mno.utils.trafficfund.verifyDomains(window.location.href, to)) {
        mno.utils.trafficfund.recordClick(window.location.href, to);
    }
}

function tf_recordClickFromUrlToUrl(from, to) {
    if(mno.utils.trafficfund.verifyDomains(from, to)) {
        mno.utils.trafficfund.recordClick(from, to);
    }
}

/**
 * DWR legacy
 * - Handle (swallow) callback
 */
if(dwr==null)var dwr={};if(dwr.engine==null)dwr.engine={};if(dwr.engine._remoteHandleCallback==null)dwr.engine._remoteHandleCallback=function(batchId,callId,reply){};
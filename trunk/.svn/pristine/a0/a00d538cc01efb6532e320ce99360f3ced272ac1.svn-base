/* $status ,  livestudioEndPoint , articleId , liveStudioId , aType , callback , timer , update , startTimer , $form , */

mno.core.register({
    id:'widget.livestudio.stream',
    creator:function (sandbox) {

        var refreshTime = 10000;
        var preferHtml5 = false; // :)
        var offset = 0; // should be instance-specific
        var statusURL;
        var streamURL;
        var syncURL;
        var timeDelta = 0; // ms, between client and server

        var statusTexts = {
            'OPEN':'saken oppdateres',
            'LIVE':'saken oppdateres',
            'PENDING':'',
            'INACTIVE':'',
            'FINISHED':''
        };

        var monthNames = ["Januar", "Februar", "Mars", "April", "Mai", "Juni",
            "Juli", "August", "September", "Oktober", "November", "Desember"];

        function init() {


            if (sandbox.container) {
                sandbox.container.each(function (i, element) {
                    mno.core.log(1, "inside each loop for every livestudio widget");
                    statusURL = sandbox.model[i].statusURL;
                    streamURL = sandbox.model[i].streamURL;
                    syncURL = sandbox.model[i].streamURL.replace(/livestudio\.htm/, 'timestampsync.htm');

                    if (sandbox.model[i].refreshTime.length > 0) {
                        if (!isNaN(sandbox.model[i].refreshTime)) {
                            refreshTime = sandbox.model[i].refreshTime * 1000;
                        }
                    }

                    // sync time with the server
                    syncTime();

                    var $ = sandbox.$,
                        liveStudioId,
                        articleId,
                        publicationName = mno.publication.name,
                        aType = getPublicationId(publicationName),
                        $container = $(element),
                        $form = $container.find('.sendQ'),
                        $status = $container.find('.moreToFollow'),
                        $output = $container.find('.items'),
                        livestudioEndPoint = '', //deprecated
                        liveStudioId = parseInt(sandbox.model[i].liveStudioId),
                        articleId = mno.model.article.id;

                    checkStatus(articleId, liveStudioId, aType, livestudioEndPoint, $status, $output, $form);
                });
            }
        }

        function syncTime() {
            jQuery.ajax({
                url:syncURL,
                dataType:"jsonP", /* interpret response as jsonP */
                jsonp:"cb", /* name of the GET paramter with function name */
                jsonpCallback:'cbTimeSync',
                timeout: 2000,
                success:function (data, textStatus, jqXHR) {
                    var now = new Date();
                    timeDelta = data.time - now.getTime();
                },
                error:function() {
                    syncTime();
                }
            });
        }

        // url generators
        function getCheckUrl(livestudioEndPoint, articleId, liveStudioId, aType) {
            return statusURL + "?id=" + liveStudioId;
        }

        function getUpdateUrl(livestudioEndPoint, liveStudioId, offset) {
            return streamURL + "?id=" + liveStudioId + "&offset=" + offset;
        }


        function getPublicationId(publicationName) {
            var aType = 1;
            var aTypes = {
                "bt":3,
                "fvn":5,
                "sa":4
            };
            if (aTypes[publicationName]) {
                aType = aTypes[publicationName];
            }
            return aType;
        }

        function getCallbackName() {
            // unique for 10 seconds
            var time = Math.floor(((new Date()).getTime() + timeDelta) / 10000);
            /* widget-specific function name  */
            return 'liveStudioCB_' + (sandbox.container.data('widgetId')) + '_' + time;
        }

        function getScript(obj) {
            // trying to replace mno.io with jQuery to allow varnish caching
            jQuery.ajax({
                url:obj.url,
                dataType:"jsonP", /* interpret response as jsonP */
                jsonp:"cb", /* name of the GET paramter with function name */
                jsonpCallback:getCallbackName(),
                timeout:4000,
                cache:true,
                success:function (data, textStatus, jqXHR) {
                    obj.jsonP(data);
                },
                error:function (jqXHR, textStatus, errorThrown) {
                    if (typeof(obj.error) !== "undefined") {
                        obj.error();
                    }
                }
            })
        }

        function update(liveStudioId, livestudioEndPoint, $output) {
            getScript({
                url:getUpdateUrl(livestudioEndPoint, liveStudioId, offset),
                jsonP:function (data) {
                    offset = renderResult(data, $output, offset)
                }
            });
        }


        function checkStatus(articleId, liveStudioId, aType, livestudioEndPoint, $status, $output, $form) {
            mno.core.log(1, "checkstatus started url to call:" + getCheckUrl(livestudioEndPoint, articleId, liveStudioId, aType));
            getScript({
                url:getCheckUrl(livestudioEndPoint, articleId, liveStudioId, aType),
                jsonP:function (data) {
                    mno.core.log(1, "checkstatus getscript callback started");

                    try {
                        if (statusTexts[data.status] !== undefined) {
                            $status.html(statusTexts[data.status]);
                        }
                        switch (data.status) {
                            case 'OPEN':
                                // What do you think? Ask questions now!
                                $status.show();
                                timer(true, articleId, liveStudioId, aType, livestudioEndPoint, $status, $output, $form);
                                break;
                            case 'LIVE':
                                // in progress now!
                                $status.show();
                                update(liveStudioId, livestudioEndPoint, $output);
                                timer(true, articleId, liveStudioId, aType, livestudioEndPoint, $status, $output, $form);
                                //startTimer();
                                break;
                            case 'PENDING':
                                $status.hide();
                                $form.remove();
                                // see questions and answers! Closed to new questions. Online Guest still answering questions.
                                update(liveStudioId, livestudioEndPoint, $output);
                                timer(true, articleId, liveStudioId, aType, livestudioEndPoint, $status, $output, $form);
                                break;
                            case 'INACTIVE':
                                $status.hide();
                                $form.remove();
                                timer(false, articleId, liveStudioId, aType, livestudioEndPoint, $status, $output, $form);
                                update(liveStudioId, livestudioEndPoint, $output);
                                break;
                            case 'FINISHED':
                                $status.hide();
                                $form.remove();
                                // See questions and answers. Online chat is closed.
                                update(liveStudioId, livestudioEndPoint, $output);
                                timer(false, articleId, liveStudioId, aType, livestudioEndPoint, $status, $output, $form);
                                break;
                            default:
                                $status.hide();
                                $form.remove();
                        }
                        //$status.addClass(data.status.toLowerCase());
                        sandbox.notify({
                            type:'livestudio-status',
                            data:{"status":data.status.toLowerCase()}
                        });

                    } catch (e) {
                        mno.core.log(3, e);
                        if (e.stack) {
                            mno.core.log(3, e.stack);
                        }
                        timer(true, articleId, liveStudioId, aType, livestudioEndPoint, $status, $output, $form);
                    }
                },
                error:function () {
                    // keep trying
                    timer(true, articleId, liveStudioId, aType, livestudioEndPoint, $status, $output, $form);
                }
            });
            mno.core.log(1, "checkstatus getscript finisehd");
        }

        function timer(start, articleId, liveStudioId, aType, livestudioEndPoint, $status, $output, $form) {
            var timerVar;
            if (start) {
                timerVar = setTimeout(function () {
                    checkStatus(articleId, liveStudioId, aType, livestudioEndPoint, $status, $output, $form);
                }, refreshTime);
            } else {
                if (timerVar !== undefined) {
                    clearTimeout(timerVar);
                }
            }
        }


        function parseTags(message, $context) {
            /* supported stuff:

             [q:This is a quote]
             [img:url]
             [t:read more|url]
             [video:pub:videoId] video player with videoId from pub (ap/btno, etc.) from xstream
             [b:bold]
             [i:italic]
             [u:underlined]
             [color:red|colorful]
             */

            function getVideoEmbedCode($0, pub, videoId) {
                /* 3G inside-app bug causes us to abort video embed */
                var matches = window.location.search.match(/hideTopBottom=t/);
                if (null !== matches && undefined !== matches && matches.length > 0) {
                    return "";
                }

                var rnd = Math.floor(Math.random() * 1e6);
                var width = ($context.width() - 20);

                if (preferHtml5) {
                    var canPlay = false;
                    var v = document.createElement('video');
                    if (v.canPlayType && v.canPlayType('video/mp4').replace(/no/, '')) {
                        canPlay = true;
                    }
                } else {
                    canPlay = false;
                }

                //var code = '<' + 'scr' + 'ipt src="';
                var src = 'http://front.xstream.dk/'
                    + pub
                    + '/player/embed?id='
                    + videoId
                    + '&targetId=player' + rnd
                    + '&width='
                    + width
                    + '&locale=no_NO&flashVars=%7B%22vpdomain%22%3A%22http%3A%2F%2Fno-mno.videoplaza.tv%22%2C%22vpTags%22%3A%22kultur%22%2C%22vpShares%22%3A%22'
                    + pub + '_' + videoId
                    + '%22%2C%22vpFlags%22%3A%22nooverlays%22%2C%22closeButtonTimeout%22%3A%2215%22%7D&theme=black'
                    + (canPlay ? '&forceHtml=true&html5=true' : '') //html5 if supported
                    ;
                //var code = code + src + '" type="text/javascript"><' + '/sc' + 'ript> '
                var code = ''
                    + '<div class="livestudio_video_wrapper"><div id="player' + rnd + '" class="livestudio_video" data-script-source="' + src + '"> </div></div>';

                return code;
            }

            function getImgCode($0, url, width, crop, ratioX, ratioY) {
                return '<img src="' + url + '" alt="" '
                    /*+ (width > 0 ? 'width="' + width + '"' : '')
                     + (ratioY > 0 ? 'height="' + (width * (ratioY / ratioX))+'"' : '')*/
                    + ' />';
            }

            return message
                .replace(/\[q:(.*?)\]/g, "<q class='quote'>$1</q>")
                .replace(/\[b:(.*?)\]/g, "<b>$1</b>")
                .replace(/\[i:(.*?)\]/g, "<i>$1</i>")
                .replace(/\[u:(.*?)\]/g, "<u>$1</u>")
                .replace(/\[color:([^|]*)\|(.*?)\]/g, "<span style=\"color:$1\">$2</span>")
                .replace(/\[img:(.*?\/w([0-9]+)(c([0-9]+?)([0-9]))?\/.*?)\]/g, getImgCode)
                .replace(/\[video:(\w+):(.*?)\]/g, getVideoEmbedCode)
                .replace(/\[t:([^|]*)\|(.*?)\]/g, '<a target="_blank" href="$2">$1</a>')
                .replace(/&#x000D;/g, '<br />'); // render bugfix
        }

        function doIFrames($elem) {
            $elem.find('div[data-script-source]').each(function (i, elem) {
                var $e = $(elem);
                var src = $e.data('scriptSource');
                var vId = $e.attr('id');

                // don't do me again:
                $e.attr('data-script-source', null);
                $e.html('<iframe frameborder="0" width="' + ($elem.width() - 20) + '"  height="' + (($elem.width() - 20) * (9 / 16)) + '" scrolling="no" marginwidth="0" marginheight="0" src="/resources/js/widgets/livestudio/views/video.html" />');
                var iframe = $e.find('iframe').get(0);
                iframe.contentWindow.document.writeln('<div style="display:none">&nbsp</div>'); // IE fix
                var div = iframe.contentWindow.document.createElement('div');
                div.id = vId;
                iframe.contentWindow.document.body.appendChild(div);
                var script = iframe.contentWindow.document.createElement("script");
                script.type = "text/javascript";
                script.src = src;
                iframe.contentWindow.document.body.appendChild(script);
                iframe.contentWindow.document.close();
            });
        }


        function formatTime(timestamp) {
            var formatDate = '';
            var format = "'Kl. 'HH:mm";
            if (timestamp.getDayInYear() != (new Date()).getDayInYear()) {
                // not today
                formatDate = "d MMM yyyy";
            }

            return {
                time:new SimpleDateFormat(format, {"monthNames": monthNames}).format(timestamp),
                date:new SimpleDateFormat(formatDate, {"monthNames": monthNames}).format(timestamp)
            };
        }


        function renderResult(data, $output, offset) {
            var i, dlList = [];
            if (data && data.length) {
                data.sort(function (a, b) {
                    if (a.ptime > b.ptime) {
                        return -1;
                    } else if (a.ptime < b.ptime) {
                        return 1;
                    } else {
                        return 0;
                    }
                });
                offset = Math.max(offset, data[0].id);

                for (i in data) {
                    if (data.hasOwnProperty(i)) {
                        var item = data[i];
                        var theTime = new Date(item.ptime);
                        dlList.push({
                            displayTime:formatTime(theTime),
                            displayContent:parseTags(item.message, $output)
                        });
                    }
                }
                sandbox.render('widgets.livestudio.views.item', {items:dlList}, function ($latest) {
                    // do we want to animate? (not if too many elements or any image)
                    /* (images cause problems, since we don't know
                     the destination height if an image is loading... */

                    var doSlide = (($latest.length < 3)
                        && ($latest.find('img').length == 0));

                    if (doSlide) {
                        $latest.css({
                            'display':'none'
                        });
                    }
                    // animate if supported natively, if not - whatever
                    if (mno.features.transition === true) {
                        $latest.filter('article').addClass('latest');
                    }
                    //$latest.html(data);
                    $output.prepend($latest);
                    try {
                        doIFrames($output);
                    } catch (e) {
                        mno.core.log(e, 2);
                    }

                    if (mno.features.transition === true) {
                        $latest.filter('article').delay(100).removeClass('latest');
                    }
                    if (doSlide) {
                        var destHeight = $latest.css('display', 'block').height();
                        $latest.css({
                            'height':0,
                            'overflow':'hidden'
                        });

                        var destCss = { /* animation target */
                            height:parseInt(destHeight) + 30
                        };

                        if (mno.features.transition === true) {
                            $latest.css(destCss);
                        } else {
                            $latest.animate(destCss, function () {
                                $latest.css({ height:null, overflow:null }); // remove
                            });
                        }
                    }
                });
            }
            return offset;
        }

        function destroy() {
            $ = null;
        }

        return  {
            init:init,
            destroy:destroy
        };
    }


});
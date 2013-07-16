mno.core.register({
    id:'widget.livestudio.preview',
    extend:[],
    creator:function (sandbox) {
        var $ = jQuery;
        var callsMade = {};

        function init() {
        }

        function destroy() {
            $ = null;
        }

        function parseTags(message) {
            /* supported stuff:

             [q:This is a quote]
             [img:url]
             [t:read more|url]
             [video:pub:videoId] tossed out
             [b:bold]
             [i:italic]
             [u:underlined]
             [color:red|colorful]
             */
            return message
                .replace(/\[q:(.*?)\]/g, "<q>$1</q>")
                .replace(/\[b:(.*?)\]/g, "<b>$1</b>")
                .replace(/\[i:(.*?)\]/g, "<i>$1</i>")
                .replace(/\[u:(.*?)\]/g, "<u>$1</u>")
                .replace(/\[color:([^|]*)\|(.*?)\]/g, "<span style=\"color:$1\">$2</span>")
                .replace(/\[img:(.*?)\]/g, '<img alt="[image]" src="/skins/global/gfx/icons/livestudio_image.png" width="20" height="20" />')
                .replace(/\[video:(\w+):(.*?)\]/g, '<img src="/skins/global/gfx/icons/livestudio_video.png" alt="[video]" width="20" height="20" />')
                .replace(/\[t:([^|]*)\|(.*?)\]/g, '$1');
        }

        function formatTime(timestamp) {
            var format;
            format = "HH:mm";
            return new SimpleDateFormat(format).format(timestamp);
        }

        function liveStudioPreview(element, url, livestudioId, count) {
            var $el = $(element);

            // prevent calling for the same stream twice
            var idx = $el.selector;
            if (callsMade[idx] === true) {
                return;
            }
            callsMade[idx] = true;

            sandbox.getScript({
                url:url + 'nettprat/livestudio.htm?id='+livestudioId+'&max=' + parseInt(count),
                timeout: 8000,
                callbackName: 'liveStudioPreview'+livestudioId,
                jsonP:function (data) {
                    var $out = $('<ul class="latestNews zebra" />');
                    jQuery.each(data, function(i, item) {
                        $out.append($('<li class="ellipsis" />').html(
                            '<span class="timestamp">'
                            + formatTime(new Date(item.ptime))
                            + '</span>'
                            + parseTags(item.message)
                        ));
                    });
                    $el.html($out);
                }
            });
        }

        return  {
            init:init,
            destroy:destroy,
            liveStudioPreview:liveStudioPreview // the "helper"
        };
    }
});
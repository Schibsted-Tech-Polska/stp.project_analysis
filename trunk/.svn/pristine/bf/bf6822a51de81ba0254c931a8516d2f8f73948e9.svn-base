mno.core.register({
    id:'widget.netmeeting.preview',
    extend:[],
    creator:function (sandbox) {
        var $ = jQuery;
        var callsMade = {};

        function init() {
        }

        function destroy() {
            $ = null;
        }

        function formatTime(timestamp) {
            var format;
            format = "HH:mm";
            return new SimpleDateFormat(format).format(timestamp);
        }

        function shortenString(s, n) {
            return s.length + n.length > 85 ? s.substring(0,85-n.length)+'&hellip;': s;
        }

        function chatPreview(element, url, chatId, count) {
            var $el = $(element);

            // prevent calling for the same stream twice
            var idx = $el.selector;
            if (callsMade[idx] === true) {
                return;
            }
            callsMade[idx] = true;

            sandbox.getScript({
                url:url + '/nettprat/chat.htm?id='+chatId+'&max=' + parseInt(count),
                timeout: 8000,
                cache: 30000,
                callbackName: 'chatPreview'+chatId,
                jsonP:function (data) {
                    var $out = $('<ul class="latestNews zebra" />');
                    jQuery.each(data, function(i, item) {
                        $out.append($('<li />').html(
                            '<span class="timestamp">'
                            + formatTime(new Date(item.ptime))
                            + '</span>'
                            + '<span class="f-bold">'+item.name.trim()+':</span> '
                            + shortenString(item.message.trim(), item.name.trim())
                        ));
                    });
                    $el.html($out);
                }
            });
        }

        return  {
            init:init,
            destroy:destroy,
            chatPreview:chatPreview // the "helper"
        };
    }
});
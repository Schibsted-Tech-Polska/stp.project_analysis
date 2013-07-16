/**
 * LiveStudio Widget Headline view
 *
 * @copyright Schibsted
 * @package mno.widgets
 * @subpackage livestudio
 * @author michal.skinder@medianorge.no
 * @description
 * Summary view of headline widget.
 * The basic HTML is defined in JSPs.
 * All the script does is listening to stream view and every (predefined) ticks, JSONPs for summary text refreshment.
 *
 */
mno.core.register({

    id: 'widget.livestudio.headline',

    creator: function (sandbox) {

        function init() {

            if (sandbox.container) {
                sandbox.container.each(function (i, element) {
                    var $container = $(element);
                    var model = sandbox.model[i];
                    var ticker = 0; //keeps information on how many times this widget was kicked by stream view

                    //backward compatibility hack for versions without Escenic's content-type settings not to get JS parse error
                    if (model.interval.length === 0) {
                        model.interval = 1;
                    } else {
                        if (isNaN(model.interval)) {
                            model.interval = 1;
                        }
                    }

                    sandbox.listen({
                        'livestudio-status': function (data) {
                            //we always want to fetch the headline on page load, after that once every ticks, so we need this flag
                            var fetchHeadline;

                            if (ticker === 0) {
                                fetchHeadline = true;
                            } else {
                                if (data.status === 'finished' || data.status === 'inactive') {
                                    //stop fetching headline if stream is off
                                    fetchHeadline = false;
                                } else {
                                    fetchHeadline = true;
                                }
                            }

                            if (fetchHeadline) {
                                //by this we know the headline is refreshed every once (model.interval * stream refresh time)
                                if (ticker % model.interval === 0 || ticker === 0) {
                                    getScript({
                                        url: model.headlineURL + "?id=" + model.liveStudioId,
                                        jsonP: function (data) {
                                            var message = data.description;
                                            if (typeof message === 'string') {

                                                $container.show();

                                                //simplified custom tags parsing- we don't have images or videos
                                                message = message.replace(/\[q:(.*?)\]/g, "<q class='quote'>$1</q>")
                                                    .replace(/\[b:(.*?)\]/g, "<b>$1</b>")
                                                    .replace(/\[i:(.*?)\]/g, "<i>$1</i>")
                                                    .replace(/\[u:(.*?)\]/g, "<u>$1</u>")
                                                    .replace(/\[color:([^|]*)\|(.*?)\]/g, "<span style=\"color:$1\">$2</span>")
                                                    .replace(/\[t:([^|]*)\|(.*?)\]/g, '<a href="$2">$1</a>');
                                                //rewrite headline only if something has changed
                                                if (message !== $container.html()) {
                                                    $container.html(message);
                                                }
                                            } else {
                                                $container.html('');
                                                $container.hide();
                                            }

                                        }
                                    });
                                }
                                ticker += 1;
                            }
                        }
                    });

                    function getScript(obj) {
                        //because we have couple of times less requests and changes of headline than stream, we want caching
                        //sandbox.getScript disallows caching by introducing unique callback function name,
                        //so we need to use standard jQuery solution
                        jQuery.ajax({
                            url: obj.url,
                            timeout: 5000,
                            dataType: "jsonP",
                            jsonp: "cb",
                            jsonpCallback: "liveStudioCB" + (sandbox.container.data('widgetId')),
                            cache: true,
                            success: function (data) {
                                obj.jsonP(data);
                            },
                            error: function () {
                                $container.html('');
                            }
                        });
                    }

                });
            }
        }

        function destroy() {
            sandbox.container = null;
        }

        return {
            init: init,
            destroy: destroy
        };
    }
});
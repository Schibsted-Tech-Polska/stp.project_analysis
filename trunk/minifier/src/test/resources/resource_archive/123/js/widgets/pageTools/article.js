mno.core.register({
    id:'widget.pageTools.article',
    creator: function (sandbox) {
        var model = sandbox.model[0];

        function addThisCallback () {
            var count = 0,
                l = model.tools.length,
                items = [],
                toolIndex = [];

            while (l--) {
                if (model.tools[l].indexOf('preferred') !== -1) {
                    toolIndex.push(l);
                    count++;
                } else {
                    items[l] = model.tools[l];
                }
            }

            var append='';
            if(model.layout === 'counter'){
                append = '_counter';
            } else if(model.layout === 'large') {
                append = '_large';
            }
            sandbox.render('widgets.pageTools.views.addthis' + append, {items: items, twitterHashtag: model.twitterHashtag}, function(data) {
                sandbox.container.append(data);
                addthis.init();
            });

            /*addthis.user.getPreferredServices(function(services){
                console.log("AddThis: getPreferredServices");
                if (services.length) {
                    var i, append='';
                    if(model.layout === 'counter'){
                        append = '_counter';
                    } else if(model.layout === 'large') {
                        append = '_large';
                    }

                    // Loop over personalization entries
                    for (i=0; i < count; i++) {
                        if ($.inArray(services[i], items) !== -1) {
                            count++;
                        } else {
                            items[toolIndex.shift()] = services[i];
                        }
                    }

                    sandbox.render('widgets.pageTools.views.addthis' + append, items, function(data) {
                        sandbox.container.append(data);
                        addthis.init();
                    });
                }
            });*/
        }

        function init() {
            var items = [],
                    i = 0;

            sandbox.getScript({
                url:'http://s7.addthis.com/js/250/addthis_widget.js#async=1',
                callback: addThisCallback
            });

            if (model.expandable === 'true') {
                (function () {
                    var state = false;
                    sandbox.container.find('.trigger').on('click', function (e) {
                        if (state === false) {
                            sandbox.container.find('.shareButton').show(250, function () {
                                $(this).css('display','inline-block');
                            });
                            $(this).html('<span class="icon">x</span> Skjul');
                        } else {
                            sandbox.container.find('.shareButton').hide(250,function () {
                                $(this).css('display','none');
                            });
                            $(this).html('<span class="icon">+</span> Del')
                        }
                        state  = !state;
                        e.preventDefault();
                        e.stopPropagation();
                    });
                }());
            }

            sandbox.container.bind('click', function() {
                /*
                  rt    : Request type (1 is for pageviews)
                  ctxId : Context ID (i.e. section ID)
                  pubId : Publication ID
                  cat   : Category (custom field)
                  meta  : Meta (custom field)
                  objId : Object ID (i.e. article ID, section ID, ...)
                  type  : Object type (i.e. article, section, ...)
                  title : Title (i.e. article title, section title, ...)
                  url   : URL (i.e. article URL, section URL, ...)
                */
                var rt = 1;
                var ctxId = mno.publication.currentSectionId;
                var pubId = mno.publication.id;
                var cat = "";
                var meta = "shared-news";
                var objId = mno.model.article.id;
                var type = "article";
                var title = mno.model.article.TITLE;
                var url = window.location.href;
                var clientDT = new Date().getTime();

                //check http://www.javascripter.net/faq/escape.htm
                title = encodeURIComponent(title);
                url = encodeURIComponent(url);

                /*
                eae.logger.url	http://bttest2.medianorge.no:8080/analysis-logger/Logger
                eae.queryservice.url	http://bttest2.medianorge.no:8080/analysis-qs/QueryService
                 */

                var baseUrl = mno.publication.url;
                baseUrl = mno.publication.loggerUrl + '?';
                baseUrl = baseUrl + 'rt=' + rt;
                baseUrl = baseUrl + '&ctxId=' + ctxId;
                baseUrl = baseUrl + '&pubId=' + pubId;
                baseUrl = baseUrl + '&cat=' + cat;
                baseUrl = baseUrl + '&meta=' + meta;
                baseUrl = baseUrl + '&objId=' + objId;
                baseUrl = baseUrl + '&type=' + type;
                baseUrl = baseUrl + '&title=' + title;
                baseUrl = baseUrl + '&url=' + url;
                baseUrl = baseUrl + '&clientDT' + clientDT;

                var imgUrl = '<img src="' + baseUrl + '" border="0" alt="" width="1" height="1"/>';
                sandbox.container.append(imgUrl);
                //alert("Should send to " + imgUrl);
            });

            for (i in model.fontSize) {
                items.push(i);
            }

            sandbox.render('widgets.pageTools.views.fontSize', items, function (data) {
                var $this;
                sandbox.container.append(data);
                sandbox.container.find('.font').each(function () {
                    var $this = $(this);
                    $this.bind('click', function () {
                        jQuery('body').css('font-size', model.fontSize[$this.attr('id')]);
                        return false;
                    });

                });
            });

            // Adds click event to the favourite icon enabling to save.
            sandbox.container.find('.mnoStoreArticle').live('click', function(e) {
                e.preventDefault();
                e.stopPropagation();
                sandbox.notify({
                    type:'save-article',
                    data:{
                        id:mno.model.article.id,
                        e:e
                    }
                });
                $(this).addClass('saved');
            });
        }

        function destroy() {
        }

        return {
            init:init,
            destroy:destroy
        }
    }
});
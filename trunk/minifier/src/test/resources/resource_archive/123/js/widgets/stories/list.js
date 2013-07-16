mno.core.register({
    id:'widget.stories.list',
    extend:['widget.stories.default'],
    creator: function (sandbox) {
        var $ = sandbox.$;

        cbCommentCount = function (data) {
            callback.call(this.instance, data);
        };

        function callback(data) {
            if (data) {
                $('[data-disqus-identifier]').each(function(i, element) {
                    var tallet = data[$(this).attr('data-disqus-identifier')];
                    if (tallet === undefined) {
                        $(this).remove();
                    } else {
                        if (tallet == 0) {
                            $(this).remove();
                        } else {
                            if(tallet == 1) {
                                $(this).attr('title', tallet + " Kommentar");
                            } else {
                                $(this).attr('title', tallet + " Kommentarer");
                            }
                            $(this).append(tallet);
                        }
                    }
                });
            }
        }

        function fallback() {
            // get disqus counter
            if (typeof disqus_shortname !== "undefined" && disqus_shortname != "") {
                sandbox.getScript({url: 'http://' + disqus_shortname + '.disqus.com/count.js'});
            }
        }

        function init() {
            var $ = sandbox.$;

            if (typeof disqus_shortname !== "undefined" && disqus_shortname != '') {
                sandbox.getScript({
                    url:'/external/sectionFeeds/comments/commentcounts-' + mno.publication.currentSectionUniqueName + '.json',
                    error: fallback
                });
            }
            if (sandbox.container) {
                this.helper(sandbox);
            }
            sandbox.container.each(function(i) {
                if (sandbox.model[i].linkBehaviour === 'lightBox') {

                    $(this).find('a').each(function () {
                        var $this = $(this);
                        var pictureUrl = $this.find('img', '').attr('src');
                        $this.attr('href', '').removeAttr('target').bind('click', function(e) {

                            var dialog = mno.utils.dialog({
                                content:$('<img src="' + pictureUrl + '" alt="" />'),
                                auto:true
                            });
                            e.stopPropagation();
                            e.preventDefault();

                        });
                    });
                }
            });

            // Adds click event to the favourite icon enabling to save.
            sandbox.container.find('span.favourite').each(function(e) {
                    $(this).unbind('click.favourite');
                    $(this).bind('click.favourite', function(e) {
                        e.preventDefault();
                        e.stopPropagation();
                        sandbox.notify({
                            type:'save-article',
                            data:{
                                id:$(this).attr('data-article-id'),
                                e:e
                            }
                        });
                        $(this).addClass('saved');
                    });
                }
            );
        }

        function destroy() {
            $ = null;
        }

        return  {
            init: init,
            destroy: destroy
        };
    }
});
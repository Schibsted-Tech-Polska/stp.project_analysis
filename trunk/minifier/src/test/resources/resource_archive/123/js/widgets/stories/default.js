mno.core.register({
    id:'widget.stories.default',
    extend:['mno.utils.flash', 'widget.poll.default', 'widget.quiz.singleQuiz','widget.slideshow.main','widget.livestudio.preview','widget.netmeeting.preview'],
    creator: function (sandbox) {
        var that = this;
        var $ = sandbox.$;
        var runFlash;
        var runPoll;
        var runQuiz;
        var liveStudioPreview;
        var chatPreview;
        var commentSystem = mno.publication.commentSystem;

        function init() {
            if (sandbox.container) {
                sandbox.getScript({
                    url:'/external/sectionFeeds/comments/commentcounts-' + mno.publication.currentSectionUniqueName + '.json',
                    error: fallback
                });
                runFlash = this.showFlash;
                runPoll = this.pollHelper;
                runQuiz = this.initQuiz;
                liveStudioPreview = this.liveStudioPreview; // why not.
                chatPreview = this.chatPreview; // why not.

                this.helper(sandbox);
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
        }

        function fallback() {
            // get disqus counter
            if (commentSystem == 'facebook') {

            } else {
                if (typeof disqus_shortname !== "undefined" && disqus_shortname != "") {
                    sandbox.getScript({url: 'http://' + disqus_shortname + '.disqus.com/count.js'});
                }
            }
        }

        function helper(sandbox) {
            var that = this;

            if (sandbox.container) {
                sandbox.container.each(function(i, element) {
                    var model = sandbox.model[i], slideshowMove = false, $this = $(this);

                    for (var idx = 0; model.articles[idx]; idx++) {
                        if (model.articles[idx].javascript !== undefined) {
                            var articleSandbox = new mno.sandbox.Sandbox({
                                container: $('.widget.stories.default [data-content-id=' + model.articles[idx].id + ']'),
                                model: [model.articles[idx].model],
                                moduleId: 'widget.stories.default.js'
                            });
                            model.articles[idx].javascript(articleSandbox);
                        }
                    }

                    if (model.storiesWithFlash !== undefined) {
                        jQuery.each(model.storiesWithFlash, function(j, article) {
                            jQuery.each(article, function(k, flash) {
                                runFlash(flash[0]);
                            });
                        });
                    }

                    if (model.polls !== undefined) {
                        runPoll(element, model);
                    }

                    if (model.quizes !== undefined) {
                        jQuery.each(model.quizes, function(k) {
                            runQuiz(sandbox, $(element).find('section.quiz'), model.quizes[k], true);
                        });
                    }

                    if(model.liveStudios !== undefined && model.liveStudios.length > 0) {
                        jQuery.each(model.liveStudios, function(l, live) {
                            var $target=jQuery('article[data-content-id="'+live.articleId+'"] .preview.livestudio .container');
                            liveStudioPreview($target, live.applicationUrl, live.livestudioId, live.latestCount);
                        });
                    }
                    if(model.chat !== undefined && model.chat.length > 0) {
                        jQuery.each(model.chat, function(l, chat) {
                            var $target=jQuery('article[data-content-id="'+chat.articleId+'"] .preview.chat .container');
                            chatPreview($target, chat.applicationUrl, chat.livestudioId, chat.latestCount);
                        });
                    }
                    (function () {
                        if (model.articles !== undefined) {
                            var chatLinks = [];

                            function _chatPopUp() {
                                mno.utils.openWindow($(this).attr('href'), {
                                    width:900,
                                    height:550,
                                    name: 'window' + new Date().getTime()

                                });
                            }

                            for (var j = 0; model.articles[j]; j++) {
                                if (model.articles[j].type === 'chat') {
                                    var $links = $this.find('[data-content-id=' + model.articles[j].id + '] a');
                                    $links.bind('mouseup.chat', _chatPopUp);
                                    $links.bind('click', function (e) {
                                        e.preventDefault();
                                    });
                                    chatLinks.push($links);
                                }
                            }
                            sandbox.listen({
                                slideStart: function () {
                                    for (var i = 0; chatLinks[i]; i++) {
                                        chatLinks[i].unbind('mouseup.chat');
                                    }
                                },
                                slideEnd: function () {
                                    for (var i = 0; chatLinks[i]; i++) {
                                        chatLinks[i].bind('mouseup.chat', _chatPopUp);
                                    }
                                }
                            });
                        }
                    }());

                    if (model.slideshowSelected) {
                        that.slideshow($(this), {numVisible:model.slideshowNumberOfVisibleSlides});
                    }
                });                                                                                                                                                                 //
            }
        }

        cbCommentCount = function (data) {
            callback.call(that.instance, data);
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
                                $(this).attr('title',  tallet + " Kommentar");
                            } else {
                                $(this).attr('title', tallet + " Kommentarer");
                            }
                            $(this).append(tallet);
                        }
                    }
                });
            }
        }

        function destroy() {
            $ = null;
        }

        return  {
            init: init,
            helper: helper,
            destroy: destroy
        };
    }
});
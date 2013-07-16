mno.core.register({
    id:'widget.mobileStories.default',
    extend:['widget.poll.default', 'widget.quiz.singleQuiz', 'widget.livestudio.preview'],
    creator:function (sandbox) {

        function init() {
            var runPoll = this.pollHelper;
            var liveStudioPreview = this.liveStudioPreview;
            var runQuiz;

            if (sandbox.container) {
                 // get disqus counter
                if(typeof disqus_shortname !== "undefined"){
                    disqus_shortname = mno.publication.disqus.shortname;
                }
                sandbox.getScript({url: 'http://' + disqus_shortname + '.disqus.com/count.js'});

                runQuiz = this.initQuiz;
                sandbox.container.each(function(i, element){
                    var model = sandbox.model[i];

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

                    if(model.polls !== undefined) {
                        runPoll(element, model);
                    }
                    if(model.quizes !== undefined){
                        jQuery.each(model.quizes, function(k){
                            runQuiz(sandbox, $(element).find('section.quiz'), model.quizes[k], true);
                        });
                    }
                    if(model.liveStudios !== undefined && model.liveStudios.length > 0) {
                        jQuery.each(model.liveStudios, function(l, live) {
                            var $target=jQuery('section[data-content-id="'+live.articleId+'"] .preview.livestudio .container');
                            liveStudioPreview($target, live.applicationUrl, live.livestudioId, live.latestCount);
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
        }

        function destroy() {}

        return {
            init:init,
            destroy:destroy
        }
    }
});


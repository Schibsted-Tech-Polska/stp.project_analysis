mno.core.register({
    id: 'widget.quiz.quizList',
    creator:function (sandbox) {
        var that = this;
        function renderQuizList(sandbox, model, container) {
            var $ = sandbox.$;


            jQuery.ajax({
                url: sandbox.publication.url + '/external/quiz/' + model.quizMethod + '.json',
                dataType:'jsonp',
                cache: true,
                jsonpCallback:model.quizMethod,
                success:function(data) {
                    if (data.list.length > 0) {
                        var item = {
                            quizSectionUrl: sandbox.publication.url + 'quiz/',
                            items:data.list,
                            starOn: "/skins/global/gfx/moodboard/star-on.png",
                            starOff: "/skins/global/gfx/moodboard/star-off.png",
                            dataWidgetId: model.dataWidgetId,
                            numOfQuizzes: model.numOfQuizzes,
                            showStars: model.showStars,
                            showUserQuiz: model.showUserQuiz,
                            userQuizUrl: model.userQuizUrl
                        };
                        sandbox.render('widgets.quiz.views.quizList', item, function (html) {
                            $(container).empty();
                            $(container).append(html);
                        });
                    }
                },
                error:function(jqHXR, textStatus, errorThrown) {
                    mno.core.log(1, 'error retrieveForecast: ' + textStatus + ' ' + errorThrown);
                }
            });
        }

        function init() {
            if (sandbox.container) {
                sandbox.container.each(function(i, element) {
                    var model = sandbox.model[i];
                    renderQuizList(sandbox, model, element);

                });
            }
        }

        function destroy() {
            $ = null;
        }

        return {
            init:init,
            destroy:destroy
        };
    }
});
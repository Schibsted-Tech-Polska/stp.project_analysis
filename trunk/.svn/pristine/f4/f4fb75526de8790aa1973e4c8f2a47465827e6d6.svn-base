/* TODO Unused variable: renderScript 4 "creator", userAnswerId 125 "answers" */

mno.core.register({
    /*this script is also extended by stories/default.js*/
    id: 'widget.quiz.singleQuiz',
    extend:['widget.moodboard.default'],
    creator:function (sandbox) {
        var params = mno.utils.params,
                runMoodBoardInit;

        function init() {
            if (sandbox.container) {
                var runQuizInit = this.initQuiz;
                runMoodBoardInit = this.initMoodBoard;
                runQuizInit(sandbox, sandbox.container, sandbox.model[0], false);
            }
        }

        function initQuiz(sandbox, qElement, model, isFrontpage){
            var $ = sandbox.$,
                quiz = {},
                quizContainer = null,
                quizSandbox = sandbox,
                applicationUrl = model.applicationUrl,
                applicationUrlNoCache=model.applicationUrlNoCache,
                quizId=parseInt(model.quizId, 10),
                element = $(qElement),
                isFrontPage=isFrontpage,
                model=model;

            var state = {
                'qaid':0,
                'id': quizId,
                'q_index':0,
                'method':'next'
            };
            if(isFrontpage){
                state.quizUrl = model.quizArticelUrl;
            }
            else if(model.answers){//means we are redirecting from frontpage and should go to question 2
                state.q_index = 1;
                state.lastAnswer = model.answers;
            }

            quizContainer = element.find('.quizContainer');
            if(typeof applicationUrl !== "undefined" && typeof state.id !== "undefined" ){
                getQuiz();
            }

            if (typeof element.mnoExpose === 'function') {
                element.mnoExpose();
            }

            if(model.answers){
                element.click();
            }


            function getNext(answer) {
                applicationUrl = applicationUrlNoCache;
                jQuery.ajax({
                    url:applicationUrl + 'quiz.htm?qaid=' + state.qaid + '&id=' + state.id + '&q_index=' + state.q_index + '&method=' + state.method + '&answers=' + answer + '&view=json',
                    dataType:'jsonp',
                    cache: 'true',
                    jsonpCallback:'singleQuiz' + state.id,
                    success: renderScript
                });
            }

            function redirect(answer) {
                window.location.replace(state.quizUrl+'?answers='+answer);
            }

            function getQuiz() {
                var params = '';
                if(state.lastAnswer){
                    params = '&answers=' + state.lastAnswer + '&q_index=' + state.q_index + '&method=' + state.method;
                }
                try{
                jQuery.ajax({
                    url:applicationUrl + 'quiz.htm?id=' + state.id + '&view=json' + params,
                    /*callbackVar:'callback',*/
                    dataType:'jsonp',
                    cache: 'true',
                    jsonpCallback:'singleQuiz' + state.id,
                    success: function (data) {
                        if (data.quiz !== undefined) {
                            quiz = data.quiz;
                            quizSandbox.render('widgets.quiz.views.quizHeader', [
                                {
                                    img:quiz.pictureUrl || false,
                                    caption: quiz.pictureCaption || false,
                                    author: quiz.author,
                                    external: quiz.external,
                                    title: quiz.title,
                                    text: quiz.text
                                }
                            ], function (data) {
                                element.prepend(data);
                            });
                            renderScript(data);
                        }
                    }
                });
                }
                catch(e){
                    mno.core.log(1,e);

                }
            }

            function renderScript(data) {
                if (data.quiz !== undefined) {
                    quiz = data.quiz;
                    var total = quiz.numQuestions;

                    state.qaid = quiz.quizAnswerId || '';

                    if (state.q_index !== total) {
                        state.gaid = quiz.quizAnswerId || 0;
                        state.q_index++;
                        var question = quiz.question;

                        quizSandbox.render('widgets.quiz.views.question', [
                            {
                                img:question.pictureUrl || false,
                                number:state.q_index,
                                total:total,
                                question:question.question,
                                alternatives: question.answers
                            }
                        ], function (data) {
                            quizContainer.html(data);

                            if(isFrontPage){
                                $('.next').bind('click', function () {
                                    if (quizContainer.find('input[name="answers"]:checked').length !== 0) {
                                        redirect(quizContainer.find('input[name="answers"]:checked').val());
                                    }
                                    return false;
                                });
                            }else{
                                $('.next').bind('click', function () {
                                    if (quizContainer.find('input[name="answers"]:checked').length !== 0) {
                                        getNext(quizContainer.find('input[name="answers"]:checked').val());
                                    }
                                    return false;
                                });
                            }
                            if (typeof element.mnoExpose === 'function') {
                                element.mnoExpose('update');
                            }
                        });

                    } else {
                        var drawDate = (quiz.drawDate !== undefined && quiz.passedDrawdate === false && (quiz.minCorrectAnswers === undefined || (parseInt(quiz.quizAnswer.points,10) >= parseInt(quiz.minCorrectAnswers,10)))),
                                register = (quiz.quizAnswer.userRegistered === undefined);

                        if (drawDate === true && register === true) {
                            state.method = 'registerEmail';
                        }

                        quizSandbox.render('widgets.quiz.views.quizResult', [
                            {
                                description:quiz.scoreDescription || false,
                                quizTitle:quiz.title || 'Quiz',
                                quizId:quizId,
                                drawdate: drawDate,
                                register: register,
                                year: drawDate[0] || '',
                                month: drawDate[1] || '',
                                day: drawDate[2] || '',
                                points:quiz.quizAnswer.points,
                                status:quiz.status,
                                total:total,
                                resultDescription: (function () {
                                    /*Loop description and return array*/
                                    if (quiz.results !== undefined) {
                                        var len = quiz.results.length,
                                                i,
                                                scoreFrom,
                                                scoreTo,
                                                description,
                                                result = [],tmpResult;

                                        for (i = 0; i < len; i++) {
                                            tmpResult = quiz.results[i];
                                            scoreFrom = tmpResult.scoreFrom;
                                            scoreTo = tmpResult.scoreTo;
                                            description = tmpResult.description;


                                            if (scoreFrom === scoreTo) {
                                                result.push({from:scoreFrom,text:description});
                                            } else {
                                                result.push({from:scoreFrom, to:scoreTo,text:description});
                                            }
                                        }
                                        return result;
                                    } else {
                                        return false;
                                    }
                                }()),
                                completedCount:quiz.completedCount,
                                answers: (function () {
                                    /* Loop answers and return array */
                                    var len = quiz.questions.length,
                                            answers = [];
                                    function getAlternatives (q, userAnswerId) {
                                        var len = q.answers.length,
                                                answer,
                                                alternative = [],
                                                j;

                                        for (j = 0; j < len; j++) {
                                            answer = q.answers[j];
                                            if (quiz.drawDate !== undefined && quiz.passedDrawdate === false && quiz.showSolution === false) {
                                                alternative.push({state:'normal', answer: answer.answer});
                                            } else {
                                                alternative.push({
                                                    state: function () {
                                                        var ret = '';
                                                        if (answer.correct === true) {
                                                            ret = 'bold';
                                                        } else {
                                                            ret = 'normal';
                                                        }
                                                        if (answer.answerId === userAnswerId) {
                                                            if (answer.correct === true) {
                                                                ret = ret + ' correct';
                                                            } else {
                                                                ret = ret + ' wrong';
                                                            }
                                                        }
                                                        return ret;

                                                    }(),
                                                    answer:answer.answer,
                                                    percentage:answer.percentage || false
                                                });
                                            }
                                        }
                                        return alternative;
                                    }
                                    for (i = 0; i < len; i++) {
                                        var q = quiz.questions[i];
                                        var userAnswerId = quiz.quizAnswer.quizAnswers[i].answerId;
                                        answers.push({
                                            number:(i + 1),
                                            questionText:q.question,
                                            hint: q.hintUrl || false,
                                            img: q.pictureUrl || false,
                                            alternatives: getAlternatives(q, userAnswerId)
                                        });
                                    }
                                    return answers;
                                }())


                            }
                        ], function (data) {
                            quizContainer.html(data);
                            model['groupid'] = quiz.categoryId;
                            model['template'] = 'widgets.moodboard.views.userrating';
                            model['scale'] = 5;
                            model['siteId'] = 'quiz';
                            model['objectId'] = quiz.quizId;

                            runMoodBoardInit(quizSandbox,model, quizContainer.find('div#rating'));

                            if (typeof element.mnoExpose === 'function') {
                                element.mnoExpose('update');
                            }
                            $('#quizRegister').bind('click', function () {
                                var info = $('#scoreDesc form').serialize();
                                quizSandbox.getScript({
                                    url:applicationUrl + 'quiz.htm?qaid=' + state.qaid + '&id=' + state.id + '&q_index=' + state.q_index + '&method=' + state.method + '&view=json&' + info,
                                    callbackVar:'callback',
                                    jsonP: renderScript
                                });
                                return false;
                            });
                        });
                    }
                }
            }
        }

        function destroy() {
            $ = null;
        }

        return {
            init:init,
            destroy:destroy,
            initQuiz:initQuiz
        };
    }
});



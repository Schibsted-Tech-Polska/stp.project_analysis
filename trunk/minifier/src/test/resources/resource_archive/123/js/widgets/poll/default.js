mno.core.register({
    id: 'widget.poll.default',
    creator: function (sandbox) {
        function _isType(mType,type) {
            return (mType.indexOf(type) !== -1) ? true : false;
        }

        return {
            init: function(){
                runPollHelper = this.pollHelper;

                if (sandbox.container) {
                    sandbox.container.each(function(i, element){
                        runPollHelper(element, sandbox.model[i]);
                    });
                }
            },

            pollHelper: function (element, model) {

                var $element = $(element),
                    publicationUrl = mno.publication.rel,
                    publicationId = mno.publication.id;

                if(model !== null && model.polls !== 'undefined') {
                    jQuery.each(model.polls, function(i, pollModel){
                        var pollId = typeof pollModel.pollId !== 'undefined' ? pollModel.pollId : '0',
                        styleId = pollModel.pollStyleId,
                        hasVoted = (pollModel.mode === 'voted') || cookieContainsPollId(pollId),
                        canVoteMultipleTimes = (typeof pollModel.voteMultipleTimes !== 'undefined' && pollModel.voteMultipleTimes === 'true');

                        if (_isType(model.type,'poll') || _isType(model.type,'relatedContents') || _isType(model.type,'mobileRelatedContents') || _isType(model.type,'stories') || _isType(model.type,'mobileStories')){
                            showView(pollId, styleId, hasVoted, canVoteMultipleTimes);
                        }

                        $element.find('.showPollResult_' + pollId).live('click', function(){
                            showResult(pollId, styleId);
                        });

                        $element.find('.sendPollVote_' + pollId).live('click', function(){
                            sendVote(pollId, styleId, $(this));
                        });

                        $element.find('.showPollForm_' + pollId).live('click', function(){
                            var revote = $(this).attr("data-revote");
                            showForm(pollId, styleId, revote);
                        });
                    });
                }


                function showView(pollId, styleId, hasVoted, canVoteMultipleTimes) {
                    if (hasVoted && !canVoteMultipleTimes) {
                        showResult(pollId, styleId);
                    } else {
                        removePollIdFromCookie(pollId);
                        showForm(pollId, styleId);
                    }
                }

                function renderPollResult(data, styleId, pollId) {
                    var colors = [
                        '#4572A7',
                        '#AA4643',
                        '#89A54E',
                        '#80699B',
                        '#3D96AE',
                        '#DB843D',
                        '#92A8CD',
                        '#A47D7C',
                        '#B5CA92'
                    ];
                    if (typeof Highcharts === 'undefined') {
                        sandbox.getScript({
                            url: sandbox.publication.url + 'resources/js/mno/utils/highcharts.js',
                            callback:function () {
                                renderPollResult(data, styleId, pollId);
                            }
                        });
                    } else {

                        jQuery('.' + styleId).each(function(j, element) {
                            var chart = new Highcharts.Chart({
                                chart: {
                                    renderTo: element,
                                    plotBackgroundColor: null,
                                    plotBorderWidth: null,
                                    plotShadow: true,
                                    width:(data.labels === true) ? jQuery(element).width() / 2 : jQuery(element).width(),
                                    height:jQuery(element).width() / 3,
                                    spacingTop:5,
                                    marginRight:0,
                                    marginLeft:0,
                                    marginBottom:20
                                },
                                colors:colors,
                                credits:false,
                                title:false,
                                legend:{
                                    borderWidth:0,
                                    lineHeight:14,
                                    itemStyle: {
                                        fontSize:'12px'
                                    },
                                    symbolPadding:2,
                                    symbolWidth:15
                                },
                                tooltip: {
                                    formatter: function() {
                                        return '<strong>' + this.point.name + '</strong>: ' + this.y + ' %';
                                    }
                                },
                                plotOptions: {
                                    pie: {
                                        allowPointSelect: true,
                                        cursor: 'pointer',
                                        size:'100%',
                                        dataLabels: {
                                            enabled: true,
                                            distance:0,
                                            conntectorWidth:0,
                                            formatter:function () {
                                                return this.y + ' %'
                                            }
                                        }
                                    }
                                },
                                series: [
                                    {
                                        type: 'pie',
                                        name: 'Resultat',
                                        data: (function () {
                                            var i = data.items.length,
                                                   items = data.items,
                                                   returnArray = [],
                                                   tempVal = 0,
                                                   index=0,
                                                   currentVal = 0;

                                           /* sort nested array*/
                                           while (i--) {
                                               currentVal = parseInt(items[i][1],10)
                                               if (currentVal > tempVal) {
                                                   index = i;
                                                   tempVal = currentVal;
                                               }
                                               returnArray.unshift(items[i]);
                                           }

                                           /* slice largest */
                                           returnArray[index] = {
                                               name: items[index][0],
                                               y: items[index][1],
                                               selected: true
                                           };
                                           return returnArray;

                                        }())
                                    }
                                ]
                            });

                            if (data.revote === true) {
                                jQuery(element).append('<a class="button showPollForm_'+pollId+'" data-revote="true">Stem igjen</a>');
                            }

                            if (data.vote === true) {
                                jQuery(element).append('<a class="button showPollForm_'+pollId+'" data-revote="false">Gi stemme</a>');
                            }

                            jQuery(element).append('<p class="f-small floatRight">Antall stemmer: <strong>' + data.count + '</strong></p><div class="clear"></div>');

                            if (data.labels === true) {
                                sandbox.render('widgets.poll.views.labels', {items:data.items, colors:colors}, function (data) {
                                    jQuery(element).prepend(data);
                                });
                            }

                        });
                        jQuery('.pollForm_' + pollId + ' span.validation').each(function(i, element) {
                            $(element).hide();
                        });
                    }
                }

                function sendVote(pollId, styleId, $this) {

                    var strutsUrl = publicationUrl + "poll/vote.do";

                    var checkedValue = $this.closest('.pollForm_' + pollId).find('input[name="vote"]:checked').val();

                    if (checkedValue === 0) {
                        jQuery('.pollForm_' + pollId + ' span.validation').show();
                    } else {
                        var strutsParams = 'mentometerId=' + pollId + '&publicationId=' + publicationId + '&vote=' + checkedValue;
                        strutsParams += '&redirectTo=' + window.location.protocol + '//' + document.domain + publicationUrl + 'template/framework/wireframe/poll.jsp?comment=' + pollId + ',' + styleId;

                        setCookie('JSESSIONID');

                        jQuery.ajax({
                            type: "POST",
                            url: strutsUrl,
                            data: strutsParams,
                            dataType:'json',
                            success:function(data) {
                                renderPollResult(data, styleId, pollId);
                            },
                            error:function(jqHXR, textStatus, errorThrown) {
                                mno.core.log(1, 'error: ' + textStatus + ' ' + errorThrown);
                            }
                        });
                    }
                }

               function showResult(pollId, styleId){
                    jQuery.ajax({
                        type: "GET",
                        url: publicationUrl+"template/framework/wireframe/poll.jsp",
                        data: "comment="+pollId+","+styleId,
                        dataType:'json',
                        success:function(data){
                            renderPollResult(data, styleId, pollId);
                        },
                        error:function(jqHXR, textStatus, errorThrown){
                            mno.core.log(1,'error: '+textStatus+' '+errorThrown);
                        }
                    });
                }

                function showForm(pollId, styleId, revote) {
                    if (revote == 'true') {
                        removePollIdFromCookie(pollId);
                    }
                    jQuery.ajax({
                        type: "GET",
                        url: publicationUrl + "template/framework/wireframe/poll.jsp",
                        data: "comment=" + pollId + "," + styleId + "&showForm=yes",
                        success:function(data) {
                            jQuery('.' + styleId).each(function(i, element) {
                                $(element).html(data);
                            });
                            jQuery('.pollForm_' + pollId + ' span.validation').each(function(i, element) {
                                $(element).hide();
                            });
                        },
                        error:function(jqHXR, textStatus, errorThrown) {
                            mno.core.log(1, 'error: ' + textStatus + ' ' + errorThrown);
                        }
                    });

                }

                function getCookie(sCookieName) {
                    var sName = sCookieName + "=", ichSt, ichEnd;
                    var sCookie = document.cookie;

                    if (sCookie.length && ( -1 != (ichSt = sCookie.indexOf(sName)) )) {
                        if (-1 == ( ichEnd = sCookie.indexOf(";", ichSt + sName.length) ))
                            ichEnd = sCookie.length;
                        return unescape(sCookie.substring(ichSt + sName.length, ichEnd));
                    }

                    return null;
                }

                function setCookie(sName) {
                    var cookieValue = getCookie(sName)
                    if (cookieValue == null || cookieValue == "") {
                        var argv = setCookie.arguments, argc = setCookie.arguments.length;
                        var sExpDate = (argc > 2) ? "; expires=" + argv[2].toGMTString() : "";
                        var sPath = (argc > 3) ? "; path=/" : "; path=/";
                        var sDomain = (argc > 4) ? "; domain=" + argv[4] : "";
                        var sSecure = (argc > 5) && argv[5] ? "; secure" : "";
                        document.cookie = sName + "=" + escape((new Date()).getTime(), 0) + sExpDate + sPath + sDomain + sSecure + ";";
                    }
                }

                function cookieContainsPollId(pollId){
                    var mentometerCookie = getCookie('mentometer');
                    if(mentometerCookie !== null) {
                        var polls = mentometerCookie.split('M');
                        for(i=0;i<polls.length;i++){
                            if(polls[i]==pollId){
                                return true;
                            }
                        }
                    }
                    return false;
                }

                function removePollIdFromCookie(pollId) {
                    var mentometerCookie = getCookie('mentometer');
                    if(mentometerCookie !== null) {
                        var polls = mentometerCookie.split('M');
                        var newCookievalue = '';
                        for (i = 0; i < polls.length; i++) {
                            if (polls[i] != pollId) {
                                if (newCookievalue == '') {
                                    newCookievalue = newCookievalue + polls[i];
                                } else {
                                    newCookievalue = newCookievalue + 'M' + polls[i];
                                }
                            }
                        }
                        var date = new Date();
                        date.setTime(date.getTime() + (1 * 24 * 60 * 60 * 1000));
                        var expires = "; expires=" + date.toGMTString();
                        document.cookie = "mentometer=" + newCookievalue + expires + "; path=/";
                    }
                }
            },
            destroy: function() {
                /*var $ = null;*/

            }
        };
    }
});

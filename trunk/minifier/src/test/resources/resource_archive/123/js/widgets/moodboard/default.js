mno.core.register({
    id:'widget.moodboard.default',
    /*this script is extended by singleQuiz.js*/
    creator: function (sandbox) {
        /*create the moodboard, and setup integration for moodboard service*/
        function initMoodBoard(sandbox, model, container)   {
            if (typeof model === 'undefined') {
                mno.core.log(1, 'Moodboard missing model');
                return false;
            }

            /*"Global" widget data*/
            var scaleObjects = model.scaleObjects,
                siteId = model.siteId || mno.publication.name,
                moodBoardScale = model.scale,
                articleId = model.objectId || mno.model.article.id,
                groupId = model.groupid || 5,
                moodBoardRatingResultUrl = model.moodBoardRatingResultUrl,
                moodBoardVotingUrl = model.moodBoardVotingUrl,
                cookieName =  'APURsite_' + siteId + '__' + 'gi_' + groupId + '__oi_' + articleId + '__s_' + moodBoardScale,
                template = model.template || 'widgets.moodboard.views.moodboard',
                animationTimer,
                oStarOn = new Image,
                oStarOff = new Image;

            oStarOn.src = "/skins/global/gfx/moodboard/star-on.png";
            oStarOff.src = "/skins/global/gfx/moodboard/star-off.png";

            /*setup methods for integration with moodboard service*/

            /*use data from moodboard api and render a result with html template*/
            var renderMoodBoardResult = function (data, setCookie, ratingValue) {
                if(data.result === 'Error') {
                    if(data.err_code === 'ERR_SEVERAL_VOTE_ATTEMPT') {
                        alert('Du kan bare stemme en gang -');
                        //TODO ï¿½mprove error handling ? better presentation for user
                    }
                    return;
                }

                //set c
                if (setCookie === true) {
                    setMoodBoardCookie(ratingValue);
                }

                /*render the html for moodboard with template*/
                if (template === 'widgets.moodboard.views.moodboard') {
                    var totalCount = data.count,
                        itemCount,
                        largestSingleCount = 0;

                    /*loop through all labels to be presented and add the corresponding result*/
                    /*loop through all result data*/
                    for (var o in scaleObjects) {
                        /*loop through all result data find matching result to current label
                        modify the data, i.e. merge result and presentation mapping from widget config params*/
                        for (var i in data.items) {
                            if (scaleObjects[o].scaleValue === data.items[i].ratingValue) {
                                scaleObjects[o].resultItem = data.items[i];
                                itemCount = data.items[i].count;
                                if (itemCount>largestSingleCount) {
                                    largestSingleCount = itemCount;
                                }
                            }
                        }
                    }
                    sandbox.render(template, {items:scaleObjects, totalCount:totalCount, userRatingValue:getMoodBoardCookieValue(1)}, function (data) {
                        container.html(data);

                        if (getMoodBoardCookieValue(1) === null) {
                            var startAnimation  = function () {
                                var state = 0,
                                    len = container.find('.label').length - 1;

                                    return function () {
                                        var label = container.find('.label').eq(state),
                                            myClass = label.attr('class').replace('label','');

                                        container.find('.inlineMood').html('<span class="'+myClass+'">' + label.text() + '</span>');

                                        state = (state === len) ? 0 : state + 1;
                                        animationTimer = setTimeout(startAnimation, 2000);
                                    }
                                }();

                            container.hover(function () {
                                clearTimeout(animationTimer);
                            }, function () {
                                startAnimation();
                            });

                            startAnimation();

                            container.find('.label').hover(function () {
                                    var $this = $(this),
                                        myClass = $this.attr('class').replace('label','');
                                    container.find('.inlineMood').html('<span class="'+myClass+'">' + $this.text() + '</span>');
                                }, function () {
                                    container.find('.inlineMood').html('......');
                                });
                        }
                    });


                /*render the html for userrating with star rating*/
                } else if (template === 'widgets.moodboard.views.userrating' || template === 'widgets.moodboard.views.rates') {
                    itemCount = (data.count != "")?data.count : 0;
                    var alertTest = function(){
                        alert("Oh my!");
                    }
                    var scale = new Array(moodBoardScale);
                    var item = {
                        itemCount: itemCount,
                        totalUserRatingAvgValue: data.totalUserRatingAvgValue,
                        starOff: oStarOff,
                        id: articleId,
                        scale:scale,
                        alertTest:alertTest


                    };
                    sandbox.render(template,item,function(data){

                        container.html(data);

                        if(item.totalUserRatingAvgValue != undefined){
                            avarageValueForObjects(item.totalUserRatingAvgValue,articleId);
                        }
                        var prevCookie = jQuery.cookie(cookieName);
                        if(prevCookie !== null){
                            /*user has already voted for this quiz*/
                            showRatingStars(getMoodBoardCookieValue(1),articleId);
                        }
                    });

                }
            };

            var avarageValueForObjects = function (avgValue,iObjectId) {
                for(var j=1;j<=avgValue;j++){
                   var test = $('img#'+iObjectId + '_usrrat_' + j)[0] ;
                    $('img#'+iObjectId + '_usrrat_' + j)[0].src =  oStarOn.src;
                }
            };

            var showRatingStars = function(ratingValue,iObjectId){
                for(var j=1;j<=ratingValue;j++){
                    $('img#'+iObjectId + '_userstar_' + j)[0].src =  oStarOn.src;
                }
            };

            var resetStarsForSingleObject= function(iObjectId,iValue) {
                /*check c*/
                var prevCookie = jQuery.cookie(cookieName);
                if (prevCookie !== null) {
                    /*user has already voted for this quiz*/
                    return;
                }
                turnOffStarsForSingleObject(iObjectId, iValue);
                turnOnStarsForSingleObject(iObjectId);
                return false;
            };

            var turnOnStarsForSingleObject = function (iObjectId, iValue) {
               /*check c*/
                var prevCookie = jQuery.cookie(cookieName);
                if(prevCookie !== null){
                    /*user has already voted for this quiz*/
                    return;
                }

                /*turnOffStarsForSingleObject(iObjectId, moodBoardScale);*/
                for (var i = 1; i <= iValue; i++) {
                    $('#'+iObjectId + '_userstar_' + i)[0].src =  oStarOn.src;
                }
            };

            var turnOffStarsForSingleObject = function(iObjectId, iValue) {
                for (var i = 1; i <= iValue; i++) {
                    $('#'+iObjectId + '_userstar_' + i)[0].src = oStarOff.src;
                }
            };

            var setMoodBoardCookie = function(ratingValue) {
                jQuery.cookie(cookieName, new Date().getTime()+';RV'+ratingValue , { expires: 1095, path: '/' });
            };

            var getMoodBoardCookieValue = function(i) {
                var moodBoardCookieValues = readMoodBoardCookie();
                return moodBoardCookieValues === null ? null : moodBoardCookieValues[i];
            };

            var readMoodBoardCookie = function() {
                var cookie = jQuery.cookie(cookieName);
                return cookie == null ? null : cookie.split('RV');
            };

            if (template !== undefined && template === 'widgets.moodboard.views.moodboard'){
                /*add click event for the different moods - added to html elements created in the template*/
                container.delegate('.barChartBar', 'click', function() {
                    container.unbind('mouseenter mouseleave');
                    container.find('.label').unbind('mouseenter mouseleave');
                    if (animationTimer !== undefined) {
                        clearTimeout(animationTimer);
                    }
                    var ratingValue = $(this).attr('data-id');
                    submitUserMood(articleId, siteId, ratingValue);
                });

            }

            if(template !== undefined && template === 'widgets.moodboard.views.userrating'){
                container.delegate('a','mouseover', function(){
                    turnOnStarsForSingleObject(articleId,$(this).index());
                });
                container.delegate('a', 'mouseout', function() {
                    resetStarsForSingleObject(articleId,$(this).index());
                });
                container.delegate('a', 'click', function(){
                    submitUserMood(articleId,siteId,$(this).index());
                });
            }





            /*submit the user mood, get result and update the moodboard*/
            function submitUserMood(objectId, site, ratingValue) {
                /*check c*/
                var prevCookie = jQuery.cookie(cookieName);
                if(prevCookie != null){
                    //TODO - better presenation for user?
                    alert("Du kan kun stemme en gang");
                    return;
                }

                var userratingParams = "siteId=" + site + "&s=" + moodBoardScale +"&oi=" + objectId + "&gi=" + groupId + "&rv=" + ratingValue;
                var votingUrl = moodBoardVotingUrl+'?'+userratingParams+'&cb=?';

                jQuery.ajax({
                    type: "GET",
                    url: votingUrl,
                    cache: true,
                    dataType:'jsonp',
                    success:function(data) {
                        renderMoodBoardResult(data, true, ratingValue);
                    },
                    error:function(jqHXR, textStatus, errorThrown) {
                        mno.core.log(1, 'error: ' + textStatus + ' ' + errorThrown);
                    }
                });
            }


            /*fire initial ajax request to get the current result for the moodboard*/
             var userratingParams = "siteId=" + siteId +"&s="+ moodBoardScale+ "&oi="+ articleId +"&gi=" + groupId;
             var ratingUrl = moodBoardRatingResultUrl+'?'+userratingParams+'&cb=?';

            jQuery.ajax({
                type: "GET",
                url: ratingUrl,
                cache: true,
                dataType:'jsonp',
                success:function(data) {
                    renderMoodBoardResult(data, false, null);
                },
                error:function(jqHXR, textStatus, errorThrown) {
                    mno.core.log(1, 'error: ' + textStatus + ' ' + errorThrown);
                }
            });

        }/*end initMoodBoard(...)*/



        function init() {
            var that = this;

            if(sandbox.container){
                sandbox.container.each(function(i, element) {
                    var model = sandbox.model[i];
                    /*scaleObjects - mapping values for the mood "scale"*/
                    that.initMoodBoard(sandbox, model, $(this));
                });
            }
        }

        function destroy() {
            $ = null;
        }

        return  {
            init: init,
            initMoodBoard:initMoodBoard,
            destroy: destroy


        };

    }
});
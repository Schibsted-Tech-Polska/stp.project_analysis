/* TODO remove global */
/* $status ,netmeetingEndPoint , articleId , adminId , aType , callback , timer , update , startTimer , $form , */

mno.core.register({
    id:'widget.netmeeting.default',
    creator: function (sandbox) {

        function switchPublication(publicationName){
            var aType = 1;
            switch (publicationName) {
                case 'bt':
                    aType = 3;
                    break;
                case 'fvn':
                    aType = 5;
                    break;
                case 'sa':
                    aType = 4;
                    break;
                default:
                    aType = 1;
            }
            return aType;
        }

        function update(adminId, netmeetingEndPoint, $QA) {
            sandbox.getScript({
                url:netmeetingEndPoint + "/nettprat/nettprat.htm?id=" + adminId + "&rnd=" + Math.floor(Math.random() * 1111111111111),
                jsonP: function(data){
                    renderResult(data, $QA)
                }
            });
        }


        function checkStatus(articleId, adminId, aType, netmeetingEndPoint, $status, $QA, $form) {
            mno.core.log(1,"checkstatus started url to call:" + netmeetingEndPoint + "/nettprat/statusnettprat.htm?eaid=" + articleId + "&id=" + adminId + "&aType=" + aType + "&rnd=" + Math.floor(Math.random() * 1111111111111));
            sandbox.getScript({
                url:netmeetingEndPoint + "/nettprat/statusnettprat.htm?eaid=" + articleId + "&id=" + adminId + "&aType=" + aType + "&rnd=" + Math.floor(Math.random() * 1111111111111),
                jsonP: function(data){
                    mno.core.log(1,"checkstatus getscript callback started");
                    callback(data, articleId, adminId, aType, netmeetingEndPoint, $status, $QA, $form);
                }
            });
            mno.core.log(1,"checkstatus getscript finisehd");
        }

        function timer(start ,articleId, adminId, aType, netmeetingEndPoint, $status, $QA, $form) {
            var timerVar;
            if (start) {
                timerVar = setTimeout(function () {
                    checkStatus(articleId, adminId, aType, netmeetingEndPoint, $status, $QA, $form);
                }, 30000); /* 30 sek refresh */
            } else {
                if (timerVar !== undefined) {
                    clearTimeout(timerVar);
                }
            }
        }

        function callback(data, articleId, adminId, aType, netmeetingEndPoint, $status, $QA, $form) {
            try{
                switch (data.status) {
                    case 'OPEN':
                        $status.html('<strong>Hva mener du?</strong><br/>Still sp&oslash;rsm&aring;l n&aring;!');
                        timer(true ,articleId, adminId, aType, netmeetingEndPoint, $status, $QA, $form);
                        break;
                    case 'LIVE':
                        $status.html('P&aring;g&aring;r n&aring;!');
                        update(adminId, netmeetingEndPoint, $QA);
                        timer(true ,articleId, adminId, aType, netmeetingEndPoint, $status, $QA, $form);
                        //startTimer();
                        break;
                    case 'PENDING':
                        $form.remove();
                        $status.html('<strong>Se sp&oslash;rsm&aring;l og svar!</strong><br/>Stengt for nye sp&oslash;rsm&aring;l. Nettgjest besvarer fortsatt sp&oslash;rsm&aring;l.');
                        update(adminId, netmeetingEndPoint, $QA);
                        timer(true ,articleId, adminId, aType, netmeetingEndPoint, $status, $QA, $form);
                        break;
                    case 'INACTIVE':
                        $form.remove();
                        $status.html('');
                        timer(false ,articleId, adminId, aType, netmeetingEndPoint, $status, $QA, $form);
                        update(adminId, netmeetingEndPoint, $QA);
                        break;
                    case 'FINISHED':
                        $form.remove();
                        $status.html("<strong>Se sp&oslash;rsm&aring;l og svar!</strong><br/>Nettpraten er avsluttet.");
                        update(adminId, netmeetingEndPoint, $QA);
                        timer(false ,articleId, adminId, aType, netmeetingEndPoint, $status, $QA, $form);
                        break;
                    default:
                        $form.remove();
                }
                $status.addClass(data.status.toLowerCase());

            }catch(e){
                mno.core.log(3,e);
                if(e.stack){
                    mno.core.log(3,e.stack);   
                }
            }

        }

        function renderResult(data, $QA) {
            var i, dlList = [];
            data.sort(function(a,b){
                if(a.answertime > b.answertime){return -1}else if(a.answertime < b.answertime){return 1}else{return 0}
            });
            for (i in data) {
                if (data.hasOwnProperty(i)) {
                    dlList.push({dt:data[i].question + '<span class="author">' + data[i].name + '</span>', dd:data[i].answer});
                }
            }
            sandbox.render('definitionList', dlList, function (data) {
                $QA.html(data);
            });
        }
        
        function questionResponse(data) {
            //mno.core.log(1,data);
            if (data !== undefined && data['boolean']) {
                alert('Ditt sp\u00F8rsm\u00E5l er mottatt! Vi gj\u00F8r oppmerksom p\u00E5 at nettgjesten kun svarer p\u00E5 et utvalg av sp\u00F8rsm\u00E5lene ved stor p\u00E5gang.');
            } else {
                alert('Det oppsto en feil!');
            }
        }

        function init() {
            if (sandbox.container) {
                sandbox.container.each(function(i,element){
                    mno.core.log(1,"inside each loop for every netmeeting widget");
                    var $ = sandbox.$,
                            netmeetingEndPoint = (typeof sandbox.model[i].netmeetingEndpoint !== "undefined" ? sandbox.model[i].netmeetingEndpoint : 'http://nettprat.aftenposten.no'), // prod = http://nettprat.aftenposten.no/
                            isChat = typeof sandbox.model[i].isChat,
                            adminId,
                            articleId,
                            publicationName = mno.publication.name,
                            aType = switchPublication(publicationName),
                            $container = $(element),
                            $form = $container.find('.sendQ'),
                            $status = $container.find('.statusTxt'),
                            $QA = $container.find('.QA');

                    /*
                     Her må vi gjøre noe for å skille på vanlig nettprat og chat.
                     Vi har en boolean variabel 'isChat' som sier om dette er chat eller ikke.
                     For å poste en chat msg bruker man /nettprat/postchat.htm
                     For å hente chat tråden bruker man /nettprat/chat.htm
                    */


                    adminId = sandbox.model[i].adminId;
                    articleId = mno.model.article.id;
                    checkStatus(articleId, adminId, aType, netmeetingEndPoint, $status, $QA, $form);

                    /* I use "live" so the submit event is last in execution order */
                    $form.live('submit', function (e) {
                        e.preventDefault();
                        if (!$form.hasClass('error')) {
                            sandbox.getScript({
                                url:netmeetingEndPoint + '/nettprat/postquestion.htm?id=' + adminId + '&name=' + encodeURIComponent($form.find('#alias').val()) + "&email=" + $form.find('#mail').val() + "&msg=" + encodeURIComponent($form.find('#QTextField').val()) + '&rnd=' + Math.floor(Math.random() * 1111111111111),
                                jsonP: questionResponse
                            });

                            $form[0].reset();
                        }

                    });
                });
            }
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
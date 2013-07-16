mno.core.register({
    id:'widget.eventSearch.searchResults',
    extend:['widget.moodboard.default'],
    wait: [],
    creator:function (sandbox) {

        var runMoodBoardInit;

        function composeParamString(array, paramName){
            var len = array.length, i = 0, paramToSearch = '';

            for(i=0; i < len; i++){
                if(array[i] != '-1') paramToSearch += paramName + '=' + array[i] + '&';
            }

            return paramToSearch;
        }

        function init() {
            runMoodBoardInit = this.initMoodBoard;

            if (sandbox.container) {
                sandbox.container.each(function (widgetIndex, element) {
                    //console.log('************** Initialized eventSearch searchResults **************');

                    console.log(sandbox.model[widgetIndex]);

                    var $evtSearchResults = $(this),
                        urlList = sandbox.model[widgetIndex].jsonFeedUrl_resultsList,
                        urlListCount = sandbox.model[widgetIndex].jsonFeedUrl_resultsListCount,
                        wID = sandbox.model[widgetIndex].eventSearchWidgetId,
                        $resList = $evtSearchResults.find('.eventSearchResult'),
                        currentPageIndex = 0,
                        dataToRemember = {
                            textToFind: '',
                            categoryToFind: [-1],
                            dateToFindFrom: getGoodDate(),
                            dateToFindTo: getGoodDate(),
                            selectedDateFilter: 'today',
                            districtToFind: [-1],
                            featuresToFind: [-1],
                            commonTagsToFind: [-1],
                            widgetID: wID,
                            resultsPerPage: 10,
                            resultsIndex: 0,
                            timeOfDay: ['all_day']
                        };

                    $evtSearchResults.find('.listViewWrapper').css('display', 'none');

                    if(window.location.hash != '') {
                        dataToRemember = decodeHash(window.location.hash);
                        $evtSearchResults.find('.itemsPerPage').val(dataToRemember.resultsPerPage);
                        $evtSearchResults.find('.itemsPerPage').change();
                        doSearch(dataToRemember);
                    }

                    sandbox.listen({
                        'eventSearch-makeSearch': function (data) {
                            $resList.html('');
                            doSearch(data);
                        }
                    });

                    /* results per page selector */
                    $evtSearchResults.find('.itemsPerPage').on('change',function(event){
                        dataToRemember.resultsPerPage = $evtSearchResults.find('.itemsPerPage').val();
                        dataToRemember.resultsIndex = 0;
                        window.location.hash = '##' + prepareHash(dataToRemember);
                        doSearch(dataToRemember);
                    });

                    if(sandbox.model[widgetIndex].where_placed == 'place_detail' && sandbox.model[0].placeId != '') {
                        dataToRemember.dateToFindTo = '';
                        doSearch(dataToRemember);
                    }

                    function doSearch(data) {
                        var jsonURL = urlList + '?',
                            jsonCountURL = urlListCount + '?',
                            paramToSearch = '';

                        dataToRemember = data;

                        paramToSearch += composeParamString(data.categoryToFind, 'categoryId');
                        paramToSearch += composeParamString(data.featuresToFind, 'featureValueId');
                        paramToSearch += composeParamString(data.commonTagsToFind, 'featureValueId');

                        //console.log(sandbox.model[0].placeId);

                        if(sandbox.model[0].where_placed === 'place_detail') {
                            paramToSearch += '&placeId=' + sandbox.model[0].placeId + '&';
                        }

                        paramToSearch += 'text=' + data.textToFind + '&';
                        paramToSearch += 'dateFrom=' + convertDate(data.dateToFindFrom) + '&';
                        paramToSearch += 'dateTo=' + convertDate(data.dateToFindTo) + '&';

                        sandbox.getScript({
                            url: jsonCountURL + paramToSearch,
                            callbackVar:'callback',
                            reload: true,
                            jsonP: initPagination
                        });

                        //console.log(paramToSearch);

                        paramToSearch += 'count=' + data.resultsPerPage + '&';
                        paramToSearch += 'firstIndex=' + data.resultsIndex*data.resultsPerPage + '&';

                        //console.log(jsonURL + paramToSearch);

                        sandbox.getScript({
                            url: jsonURL + paramToSearch,
                            callbackVar:'callback',
                            reload: true,
                            jsonP: showListResults
                        });
                    }


                    function showListResults(data) {
                        if(data !== undefined) {
                            $resList.html('');

                            var i, j,
                                finalDate,
                                eventsCount = data.length,
                                eventIds = '',
                                len = 0;

                            var dataToShow = [];
                            var item = {};

                            if(eventsCount>0) {

                                for(i=0; i<eventsCount; i++) {
                                    item = {};
                                    eventIds += data[i].id;
                                    if(i+1 < eventsCount) eventIds += ',';

                                    /******************* calendarPart ************************/
                                    finalDate = dateToCalendar(data[i].dateFrom);
                                    item.monthFrom = finalDate[0];
                                    item.dayFrom = finalDate[2];
                                    item.dayFromName = finalDate[1];
                                    item.datetime_from = data[i].dateFrom;

                                    if(data[i].dateFrom !== data[i].dateTo && data[i].dateTo !== null){
                                        finalDate = dateToCalendar(data[i].dateTo);
                                        item.monthTo = finalDate[0];
                                        item.dayTo = finalDate[2];
                                        item.dayToName = finalDate[1];
                                        item.datetime_to = data[i].dateTo;
                                    }

                                    if(data[i].timeFrom !== null && data[i].timeFrom != '00:00') {
                                        item.datetime_time = data[i].timeFrom;
                                        item.time = data[i].timeFrom;
                                        if(data[i].timeTo !== null && data[i].timeTo !== undefined) {
                                            item.time += ' - ' + data[i].timeTo + '';
                                        }
                                    }else{
                                        item.time = 'heldags<br/>event';
                                    }

                                    /******************* informationPart ************************/
                                    item.link = sandbox.model[widgetIndex].external_references_event_link + data[i].articleId + '.ece';

                                    item.name = data[i].name;
                                    item.categories = data[i].categories.join(", ");
                                    item.id = data[i].id;

                                    if(data[i].place !== null) {
                                        item.place =  data[i].place.name;
                                        if(data[i].streetAddress !== null) item.place += ', ' + data[i].place.streetAddress;
                                        if(data[i].zipCode !== null) item.place += ', ' + data[i].place.zipCode;
                                    }

                                    len = data[i].featureValues.length;
                                    item.commonTags = [];
                                    for(j = 0; j < len; j++) {
                                        if(data[i].featureValues[j].id === 83 || data[i].featureValues[j].id === 84 || data[i].featureValues[j].id === 82) item.commonTags.push(data[i].featureValues[j].value);
                                    }

                                    if(data[i].type == "M") item.moreShows = 1;

                                    /******************* imagePart ************************/
                                    if(data[i].multimediaId !== null) item.image = '<img src="' + sandbox.model[widgetIndex].imagesUrl + data[i].multimediaId + '&width=150" />';

                                    dataToShow.push(item);
                                }

                                sandbox.render('widgets.eventSearch.views.tiledEvtSearchResults', dataToShow, function (html) {

                                    $resList.html(html);

                                    sandbox.model[widgetIndex]['event'] = data;
                                    sandbox.model[widgetIndex]['eventIds'] = eventIds;
                                    initRatesDetails(sandbox, sandbox.container, sandbox.model[widgetIndex]);
                                });
                            }else{
                                $resList.append("No results :(");
                            }
                        }
                    }

                    /* pagination initialization */
                    function initPagination(data) {

                        var pagesCounterHtml = '',
                            $pagesList = $evtSearchResults.find('.pagesList'),
                            $resultsCount = $evtSearchResults.find('.resultsCount'),
                            label = '',
                            pagesCount = Math.ceil(data/dataToRemember.resultsPerPage),
                            rightAdded = false,
                            leftAdded = false;

                        if(data > 0) {
                            $evtSearchResults.find('.listViewWrapper').css('display', 'block');
                            $resultsCount.html(data + ' results found.');

                            //itemsPerPage
                            mno.utils.form.select($evtSearchResults, true);

                            $pagesList.html('<li class="prevPage navBtn"><a>&#171;</a></li>');

                            for(var pc=0; pc < pagesCount; pc++) {

                                /** first 6 and last 6 counters visible + first & last items always visible + elem +- 2 visible **/
                                if( ((pc < 6 && currentPageIndex < 4) || pc === 0) ||
                                    ((pc > pagesCount -7 && currentPageIndex > pagesCount -5) || pc === pagesCount -1) ||
                                    (currentPageIndex >= pc-2 && currentPageIndex <= pc+2) ) {

                                    label = pc +1;
                                    pagesCounterHtml += '<li class="pageIndex navBtn ';

                                    if(pc === currentPageIndex) {
                                        pagesCounterHtml += 'selected';
                                    }
                                    pagesCounterHtml += '" name="'+pc+'"><a>' +label;
                                    pagesCounterHtml += '</a></li>';

                                } else if(pc+2 > currentPageIndex && !rightAdded) {
                                    rightAdded = true;
                                    pagesCounterHtml += '<li>&hellip;</li>';
                                } else if(pc-2 < currentPageIndex && !leftAdded) {
                                    leftAdded = true;
                                    pagesCounterHtml += '<li>&hellip;</li>';
                                }
                            }

                            $pagesList.append(pagesCounterHtml);
                            $pagesList.append('<li class="nextPage navBtn"><a>&#187;</a></li>');

                            /* adding click event to buttons */
                            $pagesList.find('.navBtn').click(function(event){
                                //alert(dataToRemember.categoryToFind);

                                if($(this).hasClass('nextPage') && currentPageIndex < pagesCount-1) {
                                    currentPageIndex += 1;
                                    dataToRemember.resultsIndex=currentPageIndex;
                                    window.location.hash = '##' + prepareHash(dataToRemember);
                                    doSearch(dataToRemember);
                                } else if($(this).hasClass('prevPage') && currentPageIndex > 0) {
                                    currentPageIndex -= 1;
                                    dataToRemember.resultsIndex=currentPageIndex;
                                    window.location.hash = '##' + prepareHash(dataToRemember);
                                    doSearch(dataToRemember);
                                } else if($(this).hasClass('pageIndex') && currentPageIndex !== $(this).attr('name')) {
                                    currentPageIndex = parseInt($(this).attr('name'));
                                    dataToRemember.resultsIndex=currentPageIndex;
                                    window.location.hash = '##' + prepareHash(dataToRemember);
                                    doSearch(dataToRemember);
                                }
                            });
                            $pagesList.append('</ul>');
                        }else{
                            $evtSearchResults.find('.listViewWrapper').css('display', 'none');
                        }
                    }
                });
            }

            /**
             * Function that prepares search filters values to the form ready to use
             * @param data
             * @return {String}
             */
            function prepareHash(data){
                var hash = '';
                hash += encodeURI(data.textToFind) + '|';

                hash += data.categoryToFind.join(',') + '|';
                hash += data.districtToFind.join(',') + '|';
                hash += data.featuresToFind.join(',') + '|';
                hash += encodeURI(data.dateToFindFrom) + '|';
                hash += encodeURI(data.dateToFindTo) + '|';
                hash += encodeURI(data.selectedDateFilter) + '|';
                hash += data.commonTagsToFind.join(',') + '|';
                hash += encodeURI(data.resultsIndex) + '|';
                hash += encodeURI(data.resultsPerPage) + '|';
                hash += data.timeOfDay.join(',') + '|';

                return encodeURI(hash);
            }

            function decodeHash(hash) {
                var dataToSearch = {}, tmpArray;

                hash = hash.substring(2);
                tmpArray = decodeURI(decodeURI(hash)).split("|");
                dataToSearch.textToFind = tmpArray[0];
                dataToSearch.categoryToFind = tmpArray[1].split(",");
                dataToSearch.districtToFind = tmpArray[2].split(",");
                dataToSearch.featuresToFind = tmpArray[3].split(",");
                dataToSearch.dateToFindFrom = tmpArray[4];
                dataToSearch.dateToFindTo = tmpArray[5];
                dataToSearch.selectedDateFilter = tmpArray[6];
                dataToSearch.commonTagsToFind = tmpArray[7].split(",");
                dataToSearch.resultsIndex = tmpArray[8];
                dataToSearch.resultsPerPage = tmpArray[9];
                dataToSearch.timeOfDay = tmpArray[10].split(",");

                return dataToSearch;
            }

            function getGoodDate() {
                var months = ['01','02','03','04','05','06','07','08','09','10','11','12'];
                var days = ['00','01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'];

                var currentTime = new Date();
                var month = months[currentTime.getMonth()];
                var day = days[currentTime.getDate()];
                var year = currentTime.getFullYear();

                return year + '-' + month + '-' + day;
            }

            function dateToCalendar(date){
                var result = [];
                if(date !== null) {
                    var months = ['01','02','03','04','05','06','07','08','09','10','11','12'];
                    var days = ['00','01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'];
                    var nameDays = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
                    var monthName = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

                    var tmpA = date.split('-');
                    var dateToCheck = new Date(tmpA[0], tmpA[1]-1, tmpA[2]);

                    result[0] = monthName[dateToCheck.getMonth()];
                    result[1] = nameDays[dateToCheck.getDay()];
                    result[2] = days[dateToCheck.getDate()];
                }
                return result;
            }

            function convertDate(data) {
                var result = data;
                var pattern=/\//;

                if(pattern.test(data)) {
                    var tmpArray = data.split('/');
                    result = tmpArray[2] + '-' + tmpArray[1] + '-'+ tmpArray[0];
                }

                return result;
            }
        }

        function initRatesDetails(sandbox, container, model) {
            var eventIds = model['eventIds'].split(',');
            var eventID;

            jQuery.each(eventIds , function(j){
                eventID = eventIds[j];//parseInt(model.eventId,10);
                model['groupid'] = 2; //1 for place, 2 for event
                model['template'] = 'widgets.moodboard.views.rates';
                model['scale'] = 6;
                model['siteId'] = 'OsloBy';
                model['objectId'] =  eventID;

                runMoodBoardInit(sandbox, model, container.find('div#rating_'+eventID));
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
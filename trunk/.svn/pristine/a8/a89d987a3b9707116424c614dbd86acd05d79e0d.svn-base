mno.core.register({
    id:'widget.eventSearch.advancedSearch',
    wait: [],
    creator:function (sandbox) {

        function stripTags(data) {
            return data.replace(/<\w+(\s+("[^"]*"|'[^']*'|[^>])+)?>|<\/\w+>/gi, '');
        }

        /**
         * Function responsible for selecting proper value in Categories Select Field
         */
        function selectValues(data, wID) {
            var $evtAdvToSet = $('#' + wID);

            $evtAdvToSet.find('.textField').val(data.textToFind);
            $evtAdvToSet.find(".category option[value='" + data.categoryToFind[0] + "']").attr("selected", true);
            $evtAdvToSet.find(".category").change();
            $evtAdvToSet.find('.dateFilter').val(data.selectedDateFilter);
            $evtAdvToSet.find('.dateFilter').change();
            $evtAdvToSet.find('.dateFrom').val(data.dateToFindFrom);
            $evtAdvToSet.find('.dateTo').val(data.dateToFindTo);
        }

        /**
         * Function prepares string pass to browser address bar
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

        /**
         * Function decode data from browser address bar and returns object with filter values
         */
        function decodeHash(hash) {
            var dataToSearch = {},
                tmpArray = decodeURI(decodeURI(hash.substring(2))).split("|");

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

        /**
         * Function responsible for getting proper date in format DD/MM/YYYY
         * @param {String} returns date we need, possible values: firstDayNextMonth, lastDayNextMonth, firstDayOfWeekend, lastDayOfWeekend, tomorrow, next7days, today
         * @return {String} date in format DD/MM/YYYY
         */
        function getGoodDate(type) {
            var months = ['01','02','03','04','05','06','07','08','09','10','11','12'],
                days = ['00','01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'],
                nextMonth,
                currentTime = new Date();

            currentTime.setHours(0);
            currentTime.setMinutes(0);
            currentTime.setSeconds(0);
            currentTime.setMilliseconds(0);

            if(type == 'firstDayNextMonth') {
                nextMonth = currentTime.getMonth() + 1;
                currentTime.setMonth(nextMonth);
                currentTime.setDate(1);
            }else if(type == 'lastDayNextMonth') {
                currentTime.setDate(1);
                currentTime.setMonth(currentTime.getMonth() + 2);
                currentTime.setDate(currentTime.getDate()-1);
            }else if(type == 'firstDayOfWeekend') {
                while(currentTime.getDay()<5) {
                    currentTime.setDate(currentTime.getDate()+1);
                }
            }else if(type == 'lastDayOfWeekend') {
                while(currentTime.getDay()<5) {
                    currentTime.setDate(currentTime.getDate()+1);
                }
                currentTime.setDate(currentTime.getDate()+2);
            }else if(type == 'tomorrow') {
                currentTime.setDate(currentTime.getDate()+1);
            }else if(type == 'next7days') {
                currentTime.setDate(currentTime.getDate()+7);
            }else if(type == 'today') {
                //do nothing
            }

            return days[currentTime.getDate()] + '/' + months[currentTime.getMonth()] + '/' + currentTime.getFullYear();
        }

        function init() {
            if (sandbox.container) {
                sandbox.container.each(function (widgetIndex, element) {

                    //console.log('************** Initialized eventSearch advancedSearch **************');
                    var wID = sandbox.model[widgetIndex].eventSearchWidgetId,
                        $evtAdvSearch = $('#' + wID),
                        jsonCategoryURL = sandbox.model[widgetIndex].jsonFeedUrl_categoriesList,
                        $dateFilter = $evtAdvSearch.find('.dateFilter'),
                        $dateFields = $evtAdvSearch.find('.dateFields'),
                        $dateFrom = $evtAdvSearch.find('.dateFrom'),
                        $dateTo = $evtAdvSearch.find('.dateTo'),
                        today = getGoodDate('today'),
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

                    /* Setting data fields and handling event change on date filters */
                    $dateFrom.val(today);
                    $dateTo.val(today);

                    /* action triggered by changing Date Filter filed */
                    $dateFilter.on('change', function(data){

                        //reset date picket and set TODAY as the day.
                        $dateFrom.val(today);
                        $dateTo.val(today);

                        $dateFields.css('display', 'none');
                        if ($dateFilter.val() === 'custom') {
                            $dateFields.css('display', 'block');
                        }

                        switch($dateFilter.val()) {
                            case 'tomorrow':
                                $dateFrom.val(getGoodDate('tomorrow'));
                                $dateTo.val(getGoodDate('tomorrow'));
                                break;
                            case 'weekend':
                                $dateFrom.val(getGoodDate('firstDayOfWeekend'));
                                $dateTo.val(getGoodDate('lastDayOfWeekend'));
                                break;
                            case 'next7days':
                                $dateTo.val(getGoodDate('next7days'));
                                break;
                            case 'nextmonth':
                                $dateFrom.val(getGoodDate('firstDayNextMonth'));
                                $dateTo.val(getGoodDate('lastDayNextMonth'));
                                break;
                        }
                    });

                    if(window.location.hash !== '') {
                        dataToRemember = decodeHash(window.location.hash);
                        selectValues(dataToRemember, wID);
                    }

                    /* Listener waiting to setup filters depending on information from other instances of the same widget */
                    /*sandbox.listen({
                        'eventSearch-makeSearch': function (data) {
                            dataToRemember = data;
                            selectValues(data, wID);
                        }
                    });*/

                    /* Action after submitting the form */
                    $evtAdvSearch.submit(function (event) {
                        event.preventDefault();

                        dataToRemember.textToFind = stripTags($evtAdvSearch.find('.textField').val());
                        dataToRemember.categoryToFind = new Array($evtAdvSearch.find('.category').val());
                        dataToRemember.dateToFindFrom = $evtAdvSearch.find('.dateFrom').val();
                        dataToRemember.dateToFindTo = $evtAdvSearch.find('.dateTo').val();
                        dataToRemember.selectedDateFilter = $evtAdvSearch.find('.dateFilter').val();
                        dataToRemember.widgetID = wID;
                        dataToRemember.resultsIndex = 0;

                        if (sandbox.model[widgetIndex].destinationURL === 'true') {
                            window.location.href = sandbox.model[widgetIndex].searchResultsSectionURL  + '##' + prepareHash(dataToRemember);
                        } else {
                            window.location.hash = '##' + prepareHash(dataToRemember);
                        }

                        sandbox.notify({
                            type: 'eventSearch-makeSearch',
                            data: dataToRemember
                        });
                    });

                    /* Part responsible for getting categories and features lists */
                    sandbox.getScript({
                        url: jsonCategoryURL,
                        callbackVar:'callback',
                        reload: true,
                        jsonP: getCategory
                    });

                    /**
                     * Function to get category and features list
                     * @param data
                     */
                    function getCategory(data) {
                        var $category = $evtAdvSearch.find('.category'),
                            i,
                            result='<option value="-1">Alle kategorier</option>';

                        if (data !== null) {

                            for (i=0; data[i]; i++) {
                                result += '<option value="' + data[i].id + '">' + data[i].name + '</option>';
                            }

                            $category.html(result);
                            mno.utils.form.select($evtAdvSearch, true);
                            $category.val(dataToRemember.categoryToFind[0]);
                            $category.change();
                        }
                    }
                });
            }
        }

        function destroy() {

        }

        return {
            init:init,
            destroy:destroy
        }
    }
});
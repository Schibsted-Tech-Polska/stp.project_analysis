mno.core.register({
    id: 'widget.eventSearch.refineSearch',
    wait: [],
    creator: function (sandbox) {

        /**
         * Function prepares string pass to browser address bar
         */
        function prepareHash(data) {
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

        function convertDate(data) {
            var result = data;
            var pattern=/\//;

            if(pattern.test(data)) {
                var tmpArray = data.split('/');
                result = tmpArray[2] + '-' + tmpArray[1] + '-'+ tmpArray[0];
            }

            return result;
        }

        function init() {
            if (sandbox.container) {
                sandbox.container.each(function (widgetIndex, element) {
                    //console.log('************** Initialized eventSearch refineSearch **************');
                    var wID = sandbox.model[widgetIndex].eventSearchWidgetId,
                        $evtRefSearch = $('#' + wID),
                        categories,
                        categoriesMask = [],
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

                    /* setting data from URL as object */
                    if (window.location.hash !== '') {
                        dataToRemember = decodeHash(window.location.hash);
                    }

                    getCC(dataToRemember, wID);

                    /* Listener waiting to setup filters depending on information comming from other views of the widget */
                    sandbox.listen({
                        'eventSearch-makeSearch': function (data) {
                            dataToRemember = data;
                            dataToRemember.widgetID = sandbox.model[widgetIndex].eventSearchWidgetId;

                            getCC(dataToRemember, wID);
                        }
                    });

                    /**
                     * This function downloads categories, features and common tgs from feed and mark as selected chosen one
                     * @param data
                     * @param wID
                     */
                    function getCC(data, wID) {
                        var $evtRefToSet = $('#' + wID),
                            linkToCount = '',
                            j = 0;

                        linkToCount += '&dateFrom=' + convertDate(data.dateToFindFrom);
                        linkToCount += '&dateTo=' + convertDate(data.dateToFindTo);
                        linkToCount += '&text=' + data.textToFind;
                        if(data.categoryToFind[0] !== "-1") linkToCount += '&categoryId=' + data.categoryToFind[0];

                        sandbox.getScript({
                            url: sandbox.model[widgetIndex].jsonFeedUrl_categoriesListWithCount + '?' + linkToCount,
                            callbackVar: 'callback',
                            reload: true,
                            jsonP: getCategory
                        });

                        sandbox.getScript({
                            url: sandbox.model[widgetIndex].jsonFeedUrl_commonTagsList + '?' + linkToCount,
                            callbackVar: 'callback',
                            reload: true,
                            jsonP: getCommonTags
                        });

                        $evtRefToSet.find(".evtRefCommonTagsClass:checked").attr("checked", false);

                        for (j = 0; j < data.commonTagsToFind.length; j++) {
                            $evtRefToSet.find(".evtRefCommonTagsClass[value='" + data.commonTagsToFind[j] + "']").attr("checked", true);
                        }
                    }

                    function getScript(obj) {
                        //because we have couple of times less requests and changes of headline than stream, we want caching
                        //sandbox.getScript disallows caching by introducing unique callback function name,
                        //so we need to use standard jQuery solution
                        jQuery.ajax({
                            url: obj.url,
                            timeout: 5000,
                            dataType: "jsonP",
                            jsonp: "cb",
                            jsonpCallback: "liveStudioCB" + (sandbox.container.data('widgetId')),
                            cache: true,
                            success: function (data) {
                                obj.jsonP(data);
                            },
                            error: function () {
                                $container.html('');
                            }
                        });
                    }

                    /**
                     * Function to show category and features list
                     * @param data
                     */
                    function getCategory(data) {
                        if (data !== null) {

                            categories = data; // this variable is used in another function - check if needed :)

                            var i,
                                categoryLength = data.length,
                                $categorySection = $evtRefSearch.find('.rs_categories'),
                                result = '<ul class="refCatUl">';

                            result += '<li class="refCatLi_-1"><a href="-1" class="refCatA_-1">Alle kategorier</a></li>';

                            for (i = 0; i < categoryLength; i++) {
                                result += '<li class="refCatLi_' + data[i].id + '">';
                                result += '<a href="' + data[i].id + '" class="refCatA_' + data[i].id + '"';
                                result += '>' + data[i].name + ' <span>(' + data[i].counter + ')</span></a></li>';
                                categoriesMask[data[i].id] = i;
                            }

                            result += '</ul>';

                            $categorySection.html(result);

                            $categorySection.find('a').click(function (event) {
                                event.preventDefault();
                                makeRefineSearch("categorySelect", $(this).attr("href"));
                            });
                            /* when we have list of categories, finally we can mark selected one */
                            selectCategory(dataToRemember.categoryToFind[0]);
                        }
                    }

                    /*
                     This function triggers functions responsible for selecting clicked category or feature
                     This function also triggers notify event
                     */
                    function makeRefineSearch(type, value) {

                        if (type === 'categorySelect') {
                            selectCategory(value);

                            dataToRemember.featuresToFind = [];
                            dataToRemember.categoryToFind = [value];

                        } else if (type === 'featureSelect') {
                            $evtRefSearch.find('.refFeatureUl a').removeClass("selectedFC");
                            $evtRefSearch.find('.refFeaLi_' + value + ' a').addClass("selectedFC");

                            dataToRemember.featuresToFind = [value];

                        } else if (type === 'commonTagSelect') {
                            selectCommonTags(value);
                        }

                        dataToRemember.widgetID = sandbox.model[widgetIndex].eventSearchWidgetId;
                        dataToRemember.resultsIndex = 0;
                        window.location.hash = '##' + prepareHash(dataToRemember);

                        sandbox.notify({
                            type: 'eventSearch-makeSearch',
                            data: dataToRemember
                        });
                    }

                    /*
                     Function that set up the selection on chosen category. Also lists features from selected category
                     */
                    function selectCategory(cat_id) {
                        var $categorySection = $evtRefSearch.find('.rs_categories'),
                            $properLi = $categorySection.find('.refCatLi_' + cat_id);

                        $categorySection.find('a').removeClass("selectedFC");
                        $categorySection.find('.refFeatureUl').remove();

                        $properLi.find('a').addClass("selectedFC");

                        if (cat_id != -1) {
                            var j, k,fValuesCount, fValues;

                            var featuresList = categories[categoriesMask[cat_id]].features;
                            var featuresCount = featuresList.length;
                            var ifExists = -1;

                            if (featuresCount > 0) {
                                var tempRes = '';
                                for (j = 0; j < featuresCount; j++) {
                                    tempRes += '<ul class="refFeatureUl">';
                                    fValues = featuresList[j].values;
                                    fValuesCount = fValues.length;

                                    for(k=0; k < fValuesCount; k++) {
                                        ifExists = dataToRemember.featuresToFind.indexOf(fValues[k].id.toString());

                                        tempRes += '<li class="refFeaLi_' + fValues[k].id + ' features'; //start class definition

                                        if(ifExists !== -1) tempRes += ' selectedFC';
                                        tempRes += '"><a href="' + fValues[k].id + '"'; //end class definition

                                        tempRes += '>' + fValues[k].value + ' <span>(' + fValues[k].counter + ')</span></a></li>';
                                    }
                                }
                                tempRes += '</ul>';
                                $properLi.append(tempRes);

                                var $featureSection = $categorySection.find('.refFeatureUl');
                                $featureSection.find('a').click(function(event){
                                    event.preventDefault();
                                    makeRefineSearch("featureSelect", $(this).attr("href"));
                                });
                            }
                        }
                    }

                    function selectCommonTags(tag_id) {
                        var $commonTagSection = $evtRefSearch.find('.rs_commonTags input[value=' + tag_id + ']'),
                            $properLi = $evtRefSearch.find('.refComLi_' + tag_id);

                        if ($commonTagSection.attr('checked')) {
                            $properLi.find('a').removeClass("selectedFC");
                            $commonTagSection.attr('checked', false);
                        } else {
                            $properLi.find('a').addClass("selectedFC");
                            $commonTagSection.attr('checked', true);
                        }

                        dataToRemember.commonTagsToFind = [];
                        $evtRefSearch.find('.evtRefCommonTagsClass:checked').each(function (index) {
                            dataToRemember.commonTagsToFind.push($(this).val());
                        });
                    }

                    /**
                     * Function to get Common tags List
                     * @param data
                     */
                    function getCommonTags(data) {
                        if (data !== null) {
                            var $commonTagSection = $evtRefSearch.find('.rs_commonTags'),
                                commonTagsList = data[0].values,
                                commonTagsCount = commonTagsList.length,
                                i,
                                ifInData = -1;

                            $commonTagSection.html('');

                            if (commonTagsCount > 0) {
                                var tempRes = '<ul>';
                                for(i = 0; i < commonTagsCount; i++) {
                                    tempRes += '<li class="refComLi_' + commonTagsList[i].id + '">';
                                    tempRes += '<input type="checkbox" name="evtAdvCommonTagsCheckList[]" class="evtRefCommonTagsClass" value="' + commonTagsList[i].id + '"';
                                    ifInData = dataToRemember.commonTagsToFind.indexOf(commonTagsList[i].id.toString());
                                    if(ifInData != -1) tempRes += ' checked="checked" ';
                                    tempRes += '/ > <a href="' + commonTagsList[i].id + '"';
                                    if(ifInData != -1) tempRes += ' class="selectedFC" ';
                                    tempRes += '>' + commonTagsList[i].value + ' <span>(' + commonTagsList[i].counter + ')</span></a></li>';
                                }
                                tempRes += '</ul>';
                                $commonTagSection.html(tempRes);
                            }

                            $commonTagSection.find('a, input').click(function (event) {
                                event.preventDefault();
                                makeRefineSearch("commonTagSelect", $(this).attr("href"));
                            });

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
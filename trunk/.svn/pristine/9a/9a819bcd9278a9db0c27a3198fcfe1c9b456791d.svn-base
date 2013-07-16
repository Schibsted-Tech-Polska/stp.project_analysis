mno.core.register({
	id : 'widget.eventSearch.lineCalendarSearch',
	wait : [],
	creator : function(sandbox) {

		function init() {

			if (sandbox.container) {

				sandbox.container.each(function(widgetIndex, element) {

                    var wID = sandbox.model[widgetIndex].eventSearchWidgetId,
                        $evtLineCalendarSearch = $('#'+ wID),
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
                        },
                        //$dayFields = $evtLineCalendarSearch.find('.day_field'), formatedDate,
                        dayCounter = $evtLineCalendarSearch.find('.day_field').length;

                    if(window.location.hash != '') {
                        dataToRemember = decodeHash(window.location.hash);
                    }

					var baseDate = convertDate(dataToRemember.dateToFindFrom),
                        startDate = baseDate,
                        rangeStart = convertDate(dataToRemember.dateToFindFrom),
                        rangeEnd = convertDate(dataToRemember.dateToFindTo),
                        $prevDayButton = $evtLineCalendarSearch.find('.prev_button'),
                        $nextDayButton = $evtLineCalendarSearch.find('.next_button');

				    initCalendar(startDate, $evtLineCalendarSearch, rangeStart, rangeEnd);

					$prevDayButton.on('click',function(event) {
                        startDate.setDate(baseDate.getDate() - 1);
						initCalendar(startDate, $evtLineCalendarSearch, rangeStart, rangeEnd);
					});

					$nextDayButton.on('click', function(event) {
                        startDate.setDate(baseDate.getDate() + 1);
						initCalendar(startDate, $evtLineCalendarSearch, rangeStart, rangeEnd);
					});

					$evtLineCalendarSearch.find('.day_field').click(function(event) {
                        $evtLineCalendarSearch.find('.day_field').removeClass("selected");
                        $(this).addClass("selected");

                        var $timestamp = $(this).find('a').attr('name');

                        dataToRemember.dateToFindFrom = $timestamp;
                        dataToRemember.dateToFindTo = $timestamp;
                        dataToRemember.selectedDateFilter = 'custom';
                        dataToRemember.resultsIndex = 0;
                        dataToRemember.widgetID = wID;

                        window.location.hash = '##' + prepareHash(dataToRemember);

                        sandbox.notify({
                            type : 'eventSearch-makeSearch',
                            data : dataToRemember
                        });

                    });

                    sandbox.listen({
                        'eventSearch-makeSearch': function (data) {;
                            dataToRemember = data;

                            var newDate = convertDate(dataToRemember.dateToFindFrom);
                            var diff = (newDate - baseDate) / 86400000; //(60*60*24*1000)

                            if(diff > dayCounter || diff < 0) {
                                baseDate = convertDate(dataToRemember.dateToFindFrom);
                                startDate = baseDate;
                            }

                            rangeStart = convertDate(dataToRemember.dateToFindFrom);
                            rangeEnd = convertDate(dataToRemember.dateToFindTo);

                            initCalendar(startDate, $evtLineCalendarSearch, rangeStart, rangeEnd);
                        }
                    });
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
                var dataToSearch = new Object(), tmpArray = new Array();

                hash = hash.substring(2);
                tmpArray = decodeURI(decodeURI(hash)).split("|");
                //console.log(tmpArray);
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
        }

        function initCalendar(date, $container, selectedStart,selectedEnd) {
            var $dayFields = $container.find('.day_field'), formatedDate,
                dayCounter = $dayFields.length;

            jQuery.each($dayFields, function(j) {
                formatedDate = dateToCalendar(date);
                $dayFields[j].innerHTML = createDayField(formatedDate,date);

                $($dayFields[j]).removeClass('selected');
                //alert()
                if (date.getDate() >= selectedStart.getDate() && date.getMonth() == selectedStart.getMonth() && date.getDate() <= selectedEnd.getDate() && date.getMonth() == selectedEnd.getMonth()) {
                    $($dayFields[j]).addClass('selected');
                }
                date.setDate(date.getDate() + 1);
            });

            date.setDate(date.getDate() - dayCounter);

        }

        function createDayField(formatedDateTable, date) {
            var days = ['00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31'];
            var months = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'];

            var goodDate = days[date.getDate()] + "/" + months[date.getMonth()] + "/" + date.getFullYear();

            return '<a name="' + goodDate + '"><span class="month">'
                    + formatedDateTable[0] + '</span><span class="day_num">'
                    + formatedDateTable[2] + '</span><span class="day">'
                    + formatedDateTable[1] + '</span></a>';
        }

        function dateToCalendar(date){
            var months = ['01','02','03','04','05','06','07','08','09','10','11','12'];
            var days = ['00','01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'];
            var nameDays = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
            var monthName = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

            var dateToCheck = new Date(eval('"' + date + '"'));

            var result = [];
            result[0] = monthName[dateToCheck.getMonth()];
            result[1] = nameDays[dateToCheck.getDay()];
            result[2] = days[dateToCheck.getDate()];

            return result;
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

        function convertDate(data) {
            var pattern=/\//;

            if(pattern.test(data)) var tmpArray = data.split('/');

            return new Date(tmpArray[2], tmpArray[1]-1,tmpArray[0],0,0,0,0);
        }

        function destroy() {

        }

        return {
            init : init,
            destroy : destroy
        }
    }
});
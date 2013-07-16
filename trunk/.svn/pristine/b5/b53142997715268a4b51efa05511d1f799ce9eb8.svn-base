mno.core.register({
    id:'widget.code.template.common.btPulsDetSkjer.whatsOn.jsp',
    creator: function (sandbox) {
        return {
            init: function() {
                var $ = sandbox.$;
                var gmapsLoaded = false;

                var feedLocation = "http://event.bt.no/event/feeds";
                var catEventRoot = "event-category-tree";
                var paramTimeframe = 'today'; //today,tomorrow,weekend,dateSpan
                var paramFromDate;
                var paramToDate;
                var paramCategory = 'category_all'; //category_all or #categoryId
                var paramEventId;
                var paramVenueId;

                var searchDate;

                if (sandbox.container) {
                    sandbox.container.each(function(i, element){
                        var model = sandbox.model[i];

                        feedLocation = model.feed;
                        paramCategory = model.categoryRoot;
                        searchDate = new Date();
                        if (jQuery("#whatsOnMain")) {
                            //jQuery.datepicker.setDefaults({useThemeRoller: true});
                            initializeTabs();
                        }
                        else if (jQuery("#eventInfoWrapper")) {
                            populateEventInfo();
                        }

                        else if (jQuery("#venueInfoWrapper")) {
                            populateVenueInfo();
                        }
                        else if (jQuery("#woSearchResult")) {
                            searchEvents();
                        }
                    });

                    $('ul[role="tablist"] a').live('click',function () {
                        var $this= $(this);
                        if ($this.attr('aria-selected') !== 'true') {
                            $('[role="tabpanel"]').not('[aria-labelledby="'+$this.attr('id')+ '"]').css({display:'none'})
                                .attr('aria-hidden', 'true');
                            $('[aria-labelledby="'+$this.attr('id')+ '"]').css({display:'block'})
                                .attr('aria-hidden', "false");
                            $('[role="tablist"] a').not($this).attr('tabindex','-1').attr('aria-selected','false');
                            $this.attr('aria-selected', 'true').attr('tabindex','0');

                            showCalendar($this.attr('tabId'));
                        }
                        return false;
                    });
                }


                /* Initializes the tabs and the corresponding calendars when the tabs are shown */
                function initializeTabs() {
                    jQuery.getJSON(feedLocation+"/categories/?type="+catEventRoot+"&jsoncallback=?",
                    function(data){
                        var tabLinks = "";
                        var tabDivs = "";

                        var isFirst = true;
                        jQuery.each(data.items, function(i,item){
                            var categoryName = item.name;
                            var checkBoxClass = "checkbox"+i;
                            tabLinks = tabLinks + '<li><a tabId="'+i+'"  id="tab' + (i+1) + '" aria-selected="'+isFirst+'" >' + categoryName + '</a></li>';
                            tabDivs = tabDivs + '<div id="tabs-' + (i+1) + '" role="tabpanel" aria-hidden="'+!isFirst+'" aria-labelledby="tab' + (i+1) + '"><div id="woContent" class="woContent"><div class="woCalendar"><div id="woDatePicker' + i + '"/><div class="timeframes"><input type="checkbox" tabId="'+i+'" class="'+checkBoxClass+'" name="timeframe' + i + '" id="timeframe' + i + '"/><label for="timeframe' + i + '">Valgt dato + 3 dager</label></div></div><div id="result' + i + '" class="woResult"/></div></div>';
                            isFirst = false;
                        });

                        jQuery("#tablist").append(tabLinks);
                        jQuery("#tabpanels").append(tabDivs);

                        $('.timeframes input').live('change', function(){
                            dateChanged(searchDate, $(this).attr('tabId'));;
                        });

                        showCalendar(0);
                    });
                }

                /* Show the calendar for the corresponding tab */
                function showCalendar(tabIndex) {
                    jQuery('#woDatePicker'+tabIndex).html('<input name="date_from" id="date_from" type="date" />');
                    jQuery('#woDatePicker'+tabIndex+' input#date_from').live('change', function(){
                        var value = $(this).val().split('/');
                        searchDate = new Date(value[2], (value[1]-1), value[0]);
                        dateChanged(searchDate, tabIndex);
                        jQuery(this).trigger('click');
                    });

                    jQuery('#woDatePicker'+tabIndex+' input#date_from').val(searchDate.getDate()+'/'+(searchDate.getMonth()+1)+'/'+searchDate.getFullYear());
                    jQuery('#woDatePicker'+tabIndex+' input#date_from').trigger('click');

                    dateChanged(searchDate, tabIndex);
                }

                /* Search for events when date changes in calendar */
                function dateChanged(date, tabIndex) {
                    jQuery("#woMaxMin" + tabIndex).css("display", "none");
                    jQuery("#result" + tabIndex).animate({height: 326}, 326);
                    jQuery("#result" + tabIndex).empty();
                    jQuery("#result" + tabIndex).append('<div class="woLoad"/>');

                    var day=date.getDate();
                    var month=date.getMonth() + 1;
                    var year=date.getFullYear();

                    var category = jQuery("#tab" + (parseInt(tabIndex)+1)).html();

                    // format selected date
                    var fromDateSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'00:00:00Z");
                    var searchFromDate = fromDateSimpleDateFormat.format(date);

                    // format to date (with time 23:59:59)
                    var toDateSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd'T23:59:59'Z");
                    var toDate = date;
                    var timeframe = document.getElementById('timeframe'+tabIndex);

                    if (timeframe.checked == true) {
                        toDate.setDate(date.getDate()+3);
                    }
                    else {
                        toDate.setDate(date.getDate());
                    }
                    var searchToDate = toDateSimpleDateFormat.format(toDate);

                    jQuery.getJSON(feedLocation+"/events/?startDate=" + searchFromDate + "&endDate=" + searchToDate + "&categories=" + category + "&jsoncallback=?",
                    function(data){
                        if(data.items.length > 0) {
                            jQuery("#result" + tabIndex).empty();

                            var template = {tabIndex: tabIndex, columns:[]};
                            var column1 = {columnNr: 1, topcolumn: true, events:[]};
                            var column2 = {columnNr: 2, topcolumn: true, events:[]};
                            var column3 = {columnNr: 3, topcolumn: true, events:[]};
                            var column4 = {columnNr: 4, topcolumn: true, events:[]};
                            var column5 = {columnNr: 5, events:[]};
                            var column6 = {columnNr: 6, events:[]};
                            var column7 = {columnNr: 7, events:[]};
                            var column8 = {columnNr: 8, events:[]};

                            template.columns.push(column1);
                            template.columns.push(column2);
                            template.columns.push(column3);
                            template.columns.push(column4);
                            template.columns.push(column5);
                            template.columns.push(column6);
                            template.columns.push(column7);
                            template.columns.push(column8);

                            var columnNo;

                            jQuery.each(data.items, function(i,item){
                                //update size for long titles
                                var fontSize="";
                                var fontSize2="";
                                if(item.eventName.length > 50 ){
                                        fontSize="font-size:90%";
                                }
                                if(item.venueName.length > 41 ){
                                        fontSize2="font-size:80%";
                                }
                                var fEndTime = item.endTime;
                                var fStartTime = item.startTime;
                                                    var endTime = (fEndTime == '23:59') ? '' : ' - ' +  fEndTime;
                                startTime = '';
                                if (fStartTime == '00:01') {
                                    startTime = ', hele dagen ';
                                    endTime = '';
                                } else {
                                    startTime = ', kl. ' + fStartTime;
                                }
                                note = (item.note == "") ? "" :"<b>" +  item.note + "</b><br/>";
                                var eventLinkClass = 'InfoLink'+item.eventId;
                                var venueInfoClass = 'VenueLink'+item.eventId;

                                var event = {
                                    eventHeaderFontSize: fontSize,
                                    eventName: item.eventName,
                                    eventLinkClass: eventLinkClass,
                                    eventTime: note + item.eventDate + startTime + endTime,
                                    venueInfoClass: venueInfoClass,
                                    venueInfoFontSize: fontSize2,
                                    itemVenueName: item.venueName
                                };

                                jQuery("."+eventLinkClass).die('click');
                                jQuery("."+eventLinkClass).live('click',function(){
                                    showEventInfo(item.eventId, item.eventDate);
                                });
                                jQuery("."+venueInfoClass).die('click');
                                jQuery("."+venueInfoClass).live('click',function(){
                                    showVenueInfo(item.venueId);
                                });

                                // add the first 9 events to the 3 left top columns
                                if(i < 9) {
                                    if(i == 0) {
                                        column1.events.push(event);
                                    } else if (i == 1) {
                                        column2.events.push(event);
                                    } else if (i == 2) {
                                        column3.events.push(event);
                                    } else if (i == 3) {
                                        column1.events.push(event);
                                    } else if (i == 4) {
                                        column2.events.push(event);
                                    } else if (i == 5) {
                                        column3.events.push(event);
                                    } else if (i == 6) {
                                        column1.events.push(event);
                                    } else if (i == 7) {
                                        column2.events.push(event);
                                    } else if (i == 8) {
                                        column3.events.push(event);
                                    }
                                } else {
                                    columnNo = 5 + (i % 4);
                                    template.columns[columnNo-1].events.push(event);
                                    jQuery("#result" + tabIndex).animate({height: '100%'}, 326);
                                }
                            });



                            mno.views.render('mno.views.calEventElements',template, function(data){
                               jQuery("#result" + tabIndex).append(data);
                            });
                        } else {
                            jQuery("#result" + tabIndex).html("<strong>Fant ingen hendelser!</strong>");
                        }
                    });
                }

                /* Opens an event info dialog box */
                function showEventInfo(eventId, eventDate) {
                    // get event info and add it to the dialog eventInfo div
                    jQuery.getJSON(feedLocation+"/eventInfo/?eventId=" + eventId + "&jsoncallback=?",
                    function(data){
                        var template = {
                            eventName: data.event.name,
                            shortDescr: data.event.shortDescription,
                            descr: data.event.description,
                            occurences: []
                        };

                        jQuery.each(data.event.eventOccurrences, function(i,occurrence){
                                var fEndTime = occurrence.endTime;
                                var fStartTime = occurrence.startTime;
                                var endTime = (fEndTime == '23:59') ? '' : ' - ' +  fEndTime;
                                startTime = '';
                                if (fStartTime == '00:01') {
                                    startTime = ', hele dagen ';
                                    endTime = '';
                                } else {
                                    startTime = ', kl. ' + fStartTime;
                                }
                                template.occurences.push({
                                    date: occurrence.date + startTime + endTime,
                                    note: occurrence.note
                                });
                        });

                        mno.views.render('mno.views.calEventDialogInfo',template, function(renderedData){
                            jQuery("#whatsOnMain").append(renderedData);
                            mno.utils.dialog({content: jQuery("#eventInfoDialog"), span:6});
                        });
                    });
                }

                /* Populates an article with eventInfo */
                 function populateEventInfo() {
                    // get event info and add it to the dialog eventInfo div
                    jQuery.getJSON(feedLocation+"/eventInfo/?eventId=" + paramEventId + "&jsoncallback=?",
                        function(data){
                            var template = {
                                eventName: data.event.name,
                                shortDescr: data.event.shortDescription,
                                descr: data.event.description,
                                url: '${publication.url}?navigate=venue&venueId='+data.event.venue.id,
                                eventVenueName: data.event.venue.name
                            };

                            mno.views.render('mno.views.calEventInfoWrapper',template, function(renderedData){
                                jQuery("#eventInfoWrapper").append(renderedData);
                            });
                        });
                }

                /* Opens a venue info dialog box */
                function showVenueInfo(venueId) {
                    // get venue info and add it to the dialog venueInfo div
                    jQuery.getJSON(feedLocation+"/venueInfo/?venueId=" + venueId + "&jsoncallback=?",
                    function(data){
                        var template = {
                            venueName: data.venue.name,
                            phone: data.venue.phone,
                            url: data.venue.url,
                            street: data.venue.street + ' ' +data.venue.number,
                            city: data.venue.postalCode + ' '+data.venue.city
                        };

                        mno.views.render('mno.views.calVenueDialogInfo',template, function(renderedData){
                            if(data.venue.gpsCoordinateX.length > 0 && data.venue.gpsCoordinateY.length > 0 ){
                                loadGoogleMaps(function(){
                                    jQuery("#whatsOnMain").append(renderedData);
                                    initializeMap(data.venue.gpsCoordinateX, data.venue.gpsCoordinateY, "woVenueMapCanvas");
                                    mno.utils.dialog({content: jQuery("#venueInfoDialog"), span:6});
                                })
                            }else{
                                jQuery("#whatsOnMain").append(renderedData);
                                mno.utils.dialog({content: jQuery("#venueInfoDialog"), span:6});
                            }
                        });
                    });
                }

                /* Populates an article with venue info */
                function populateVenueInfo() {
                    // get venue info and add it to the dialog venueInfo div
                    jQuery.getJSON(feedLocation+"/venueInfo/?venueId=" + paramVenueId + "&jsoncallback=?",
                    function(data){
                        var template = {
                            venueName: data.venue.name,
                            phone: data.venue.phone,
                            url: data.venue.url,
                            street: data.venue.street + ' ' +data.venue.number,
                            city: data.venue.postalCode + ' '+data.venue.city
                        };

                        mno.views.render('mno.views.calVenueDialogInfo',template, function(renderedData){
                            jQuery("#venueInfoWrapper").append(renderedData);
                            if(data.venue.gpsCoordinateX.length > 0 && data.venue.gpsCoordinateY.length > 0 ){
                                initializeMap(data.venue.gpsCoordinateX, data.venue.gpsCoordinateY, "woVenueMapCanvas");
                            }
                        });
                    });
                }

                /* Displays the venue map in the eventinfo/venueinfo dialog boxes */
                function initializeMap(latitude, longitude, mapCanvas) {
                    try{
                        var myLatLng = new google.maps.LatLng(latitude, longitude);
                        var myOptions = {
                                    zoom: 16,
                                    center: myLatLng,
                                    mapTypeId: google.maps.MapTypeId.ROADMAP
                                };
                        var myMap = new google.maps.Map(jQuery('#'+mapCanvas)[0],myOptions);
                        var marker = new google.maps.Marker({
                            position: myLatLng,
                            map: myMap
                        });
                    }catch(e){
                        mno.core.log(3,"widgets/map/default.js at initMap stack" + e.stack);
                    }
                }

                function loadGoogleMaps(whenGmapsLoaded){
                    sandbox.getScript({
                        url: 'http://maps.google.com/maps/api/js?sensor=false&async=2&v=3',
                        callbackVar:'callback',
                        jsonP:function () {
                            sandbox.notify({
                                type:'pulsGapiReady',
                                data:true
                            })
                        }
                    });

                    sandbox.listen({
                        'pulsGapiReady':function () {
                            whenGmapsLoaded();
                        }
                    });
                }

                /* Show/hide the "more events" icon */
                function maxMinResult(tabIndex) {
                    if(!jQuery("#woMaxMin" + tabIndex).hasClass("woMin")) {
                        jQuery("#result" + tabIndex).animate({height: '100%'}, 100);
                        jQuery("#woMaxMin" + tabIndex).toggleClass("woMin");
                        jQuery("#woMaxMin" + tabIndex).toggleClass("ui-icon-circle-triangle-s");
                        jQuery("#woMaxMin" + tabIndex).toggleClass("ui-icon-circle-triangle-n");
                    } else {
                        jQuery("#result" + tabIndex).animate({height: '100%'}, 100);
                        jQuery("#woMaxMin" + tabIndex).toggleClass("woMin");
                        jQuery("#woMaxMin" + tabIndex).toggleClass("ui-icon-circle-triangle-s");
                        jQuery("#woMaxMin" + tabIndex).toggleClass("ui-icon-circle-triangle-n");
                    }
                }

                function searchEvents() {
                    jQuery("#woSearchResult").empty();
                    jQuery("#woSearchResult").append('<h2>S&oslash;keresultat</h2>');
                    jQuery("#woSearchResult").append('<div class="woLoad"/>');

                    var tempStart;
                    var tempEnd;
                    var startDate;
                    var endDate;

                    if (paramTimeframe == 'dateSpan') {
                        tempStart = Date.parse(paramFromDate);
                        tempEnd = Date.parse(paramToDate);
                        startDate = new Date(tempStart);
                        endDate = new Date(tempEnd);
                    }
                    else if (paramTimeframe == 'today') {
                        startDate = new Date();
                        endDate = new Date();
                    }

                    else if (paramTimeframe == 'tomorrow') {
                        startDate = new Date();
                        startDate.setDate(startDate.getDate()+1);
                        endDate = new Date();
                        endDate.setDate(endDate.getDate()+1);
                    }

                    else if (paramTimeframe == 'weekend') {
                        startDate = new Date();
                        var day = startDate.getDay();
                        var endDay = day;
                        if (day>0 && day<=5) {
                            day = 5 - day;
                            endDay = day+2;
                        }
                        else {
                            if (day == 0)
                                endDay = 0;
                            else
                                endDay = 1;
                            day = 0;
                        }
                        startDate.setDate(startDate.getDate()+day);
                        endDate = new Date();
                        endDate.setDate(endDate.getDate()+endDay);
                    }

                    // format selected startdate
                    var fromDateSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'00:00:00'Z");
                    var searchFromDate = fromDateSimpleDateFormat.format(startDate);

                    // format to enddate (with time 23:59:59)
                    var toDateSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd'T23:59:59'Z");
                    var searchToDate = toDateSimpleDateFormat.format(endDate);

                    var category = paramCategory;

                    jQuery.getJSON(feedLocation+"/events/?startDate=" + searchFromDate + "&endDate=" + searchToDate + "&categories=" + category + "&jsoncallback=?",
                    function(data){
                        if(data.items.length > 0) {
                            jQuery("#woSearchResult").empty();
                            jQuery("#woSearchResult").append('<h2>S&oslash;keresultat</h2>');

                            jQuery.each(data.items, function(i,item){
                                var searchItemDIV = '<div class="woSearchItem">';
                                searchItemDIV += '<div class="woTitle"><a href="${publication.url}?navigate=event&eventId='+item.eventId+'">' + item.eventName + '</a></div>';
                                searchItemDIV += '<div class="woDateTime">' + item.eventDate + ', kl ' + item.startTime + ' - ' + item.endTime + '</div>';
                                searchItemDIV += '<div class="woVenue">' + item.venueName + '</div>';
                                searchItemDIV += '<div class="woCat">' + item.categories + '</div>';
                                searchItemDIV += '</div>';

                                jQuery("#woSearchResult").append(searchItemDIV);
                            });
                        } else {
                            jQuery("#woSearchResult").empty();
                            jQuery("#woSearchResult").append('<h2>S&oslash;keresultat</h2>');
                            jQuery("#woSearchResult").append("<strong>Fant ingen hendelser!</strong>");
                        }

                    });
                }

            },

            destroy: function() {
                $ = null;
            }
        };
    }
});
mno.core.register({
    id:'widget.weather.articleLongtermForecast',
    creator: function (sandbox) {
        var baseUrl;

        function init() {
            if (sandbox.container) {
                sandbox.container.each(function(i, element){
                    var model = sandbox.model[i];
                    baseUrl = model.baseUrl;
                    var showYr = model.showYr;

                    var periodsToShow = [];
                    if(model.showPeriod0){
                        periodsToShow.push('0');
                    }
                    if(model.showPeriod1){
                        periodsToShow.push('1');
                    }
                    if(model.showPeriod2){
                        periodsToShow.push('2');
                    }
                    if(model.showPeriod3){
                        periodsToShow.push('3');
                    }
                    var displayName = model.weatherDisplayName;

                    var hideWind = (model.showWind!=='true');
                    var expandable = (model.forceExpand!='true');

                    sandbox.listen({
                        'weatherSearch-searchPerformed':function (data) {
                            if(data.forecast!=undefined){
                                handleForecast(element, data.forecast, periodsToShow, model.align, hideWind, showYr, displayName, expandable);
                            }else{
                                $(element).hide();
                            }
                        }
                    });

                    if(model.latitude!='' && model.longitude!=''){
                        retrieveForecast(element, model.latitude, model.longitude, periodsToShow, model.align, hideWind, showYr, displayName, expandable);
                    }
                });
            }
        }

        function retrieveForecast(container, latitude, longitude, periodsToShow, align, showWind, showYr, displayName, expandable){
            var fixedLat = parseFloat(latitude).toFixed(4);
            var fixedLng = parseFloat(longitude).toFixed(4);
            var getLatLngUrl = baseUrl+"json/reverseGeoCode.json?latlng="+fixedLat+","+fixedLng+"&provider=yr&callback=?";

            function retrieveForecastUrl(container, url){
                jQuery.ajax({
                    type: "GET",
                    url: url,
                    dataType:'jsonp',
                    cache: true,
                    success:function(data) {
                        retrieveForecast(container, baseUrl+data.local_url+'varsel.json?callback=?')
                    },
                    error:function(jqHXR, textStatus, errorThrown) {
                        mno.core.log(1, 'error retrieveForecast: ' + textStatus + ' ' + errorThrown);
                    }
                });
            }

            function retrieveForecast(container, url){
                jQuery.ajax({
                    type: "GET",
                    url: url,
                    dataType:'jsonp',
                    cache: true,
                    jsonpCallback: 'articleLongtermForecastVarsel',
                    success:function(data) {
                        if(data.error == false){
                            handleForecast(container, data, periodsToShow, align, showWind, showYr, displayName, expandable);
                        }else{
                            mno.core.log(1, 'error retrieveForecast: '+data.error.errorMessage);
                        }
                    },
                    error:function(jqHXR, textStatus, errorThrown) {
                        mno.core.log(1, 'error retrieveForecast: ' + textStatus + ' ' + errorThrown);
                    }
                });
            }

            retrieveForecastUrl(container, getLatLngUrl);
        }

        function handleForecast(container, data, periodsToShow, align, hideWind, showYr, displayName, expandable){

            var monthLabels=['jan','feb','mar','apr','mai','jun','jul','aug','sep','okt','nov','des'];

            function getDate(millis){
                var d = new Date(millis),
                    day = d.getDate();

                return ((day < 10) ? '0' + day : day) +'. '+monthLabels[d.getMonth()];
            }

            function getWindSymbolClass(windspeed){
                if(windspeed<1.6){
                    return 'strength1';
                }else if(windspeed<3.4){
                    return 'strength2';
                }else if(windspeed<5.5){
                    return 'strength3';
                }else if(windspeed<8.0){
                    return 'strength4';
                }else if(windspeed<10.8){
                    return 'strength5';
                }else if(windspeed<13.9){
                    return 'strength6';
                }else if(windspeed<17.2){
                    return 'strength7';
                }else if(windspeed<20.8){
                    return 'strength8';
                }else if(windspeed<24.5){
                    return 'strength9';
                }else if(windspeed<28.5){
                    return 'strength10';
                }else if(windspeed<32.6){
                    return 'strength11';
                }else if(windspeed>=32.6){
                    return 'strength12';
                }
                return false;
            }

            function getDay(millis){
                var dayLabels=['S&oslash;n', 'Man', 'Tirs', 'Ons','Tors', 'Fre','L&oslash;r'];
                return dayLabels[new Date(millis).getDay()] + 'dag'; //Lettere å bare ta bort dag her hvis det trengs
            }

            function getHours(millis){
                var hours = new Date(millis).getHours();
                if(hours<10)hours='0'+hours;
                return hours;
            }

            if(displayName==undefined || displayName==''){
                displayName = data.forecast.name;
            }

            var today = new Date();
            var todayString = today.getDate()+'. '+monthLabels[today.getMonth()];
            if(align=='horizontal'){
                sandbox.render('widgets.weather.view.longtermHorizontal',{place:displayName, periods:data.forecast.text_tabular, periodsToShow:periodsToShow, today:todayString, getDate:getDate, getDay:getDay, getHours:getHours, hideWind:hideWind, getWindSymbolClass:getWindSymbolClass, round:Math.round}, function(html){
                    $(container).html(html);
                    if(showYr=='true'){
                        sandbox.render('widgets.weather.view.yrDisclaimer', {yrUrl:''}, function(html){
                            $(container).append(html);
                        });
                    }
                    $('table.verticalData').delegate('td','mouseover mouseleave', changeClassOnCol);
                    $('table.verticalData').delegate('th','mouseover mouseleave', changeClassOnCol);
                });
            }else{
                sandbox.render('widgets.weather.view.longtermVertical',{place:displayName, periods:data.forecast.text_tabular, periodsToShow:periodsToShow, today:todayString, getDate:getDate, getDay:getDay, getHours:getHours, hideWind:hideWind, getWindSymbolClass:getWindSymbolClass, round:Math.round, expandable:expandable}, function(html){
                    $(container).html(html);
                    if(showYr=='true'){
                        sandbox.render('widgets.weather.view.yrDisclaimer', {yrUrl:''}, function(html){
                            $(container).append(html);
                        });
                    }
                    $('table.horizontalData').delegate('td','mouseover mouseleave', showHours);
                    $('table.horizontalData').delegate('th','mouseover mouseleave', showHours);

                    $('.collapsable').hide();
                    $('.expandCollapse').html('<span class="button">+</span>');
                    $('.expandCollapse').attr('title', 'Vis flere dager');

                    $('.expandCollapse').click(function(){
                        $('.collapsable').toggle();
                        if($(this).html()=='+'){
                            $(this).html('-');
                            $(this).attr('title', 'Vis færre dager');
                        }else{
                            $(this).html('+');
                            $(this).attr('title', 'Vis flere dager');
                        }
                    });
                });
            }
        }

        function changeClassOnCol(e) {
            var hoverIndex = $(this).index();
            if (e.type == 'mouseover' && $(this).index() != 0) {
                var parentTable = $(this).parents('table.verticalData');
                $(parentTable).find('th').eq($(this).index()).addClass('hover');
                $(parentTable).find('td').each(function(i) {
                    if(hoverIndex == $(this).index()) {
                        $(this).addClass('hover');
                        var hours = $(this).find('.timeperiod_hours').html();
                        $(this).parents('tr').find('th.timeperiod span.time').html(hours);
                    }
                });
            }
            else {
                $(this).parents('table.verticalData').find('th').eq($(this).index()).removeClass('hover');
                $(this).parents('table.verticalData').find('td').each(function(i) {
                    if(hoverIndex == $(this).index()) {
                        $(this).removeClass('hover');
                        $(this).parents('tr').find('th.timeperiod span.time').html('');
                    }
                });
            }
        }

        function showHours(e) {
            var hoverRow = $(this).parents('tr');
            if (e.type == 'mouseover' && $(hoverRow).index() != 0) {
                $(hoverRow).find('th').addClass('hover');
                $(hoverRow).find('td').each(function(i) {
                    $(this).addClass('hover');
                    var thisIndex = $(this).index();
                    var hours = $(this).find('.timeperiod_hours').html();
                    $(this).parents('table.horizontalData').find('th').each(function(i){
                        if(thisIndex == $(this).index()){
                            $(this).find('div span.time').html(hours);
                        }
                    })
                });
            }
            else {
                $(hoverRow).find('th').removeClass('hover');
                $(hoverRow).find('td').each(function(i) {
                    $(this).removeClass('hover');
                    $(this).find('.timeperiod_hours').addClass('hidden');
                });
                $(this).parents('table.horizontalData').find('th').each(function(i){
                    $(this).find('div span.time').html('');
                })
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
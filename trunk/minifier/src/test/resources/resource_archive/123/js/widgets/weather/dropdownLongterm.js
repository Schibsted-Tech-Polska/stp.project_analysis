mno.core.register({
    id:'widget.weather.dropdownLongterm',
    creator:function (sandbox) {
        var baseUrl, place, numDays, container, model, searchPage, pentUrl;

        function init() {
            if (sandbox.container) {
                sandbox.container.each(function(i, element) {
                    model = sandbox.model[i];
                    container = sandbox.container[i];
                    numDays = model.numDays - 1; /* TODO: fix count bug in source */
                    place = model.forecastUrls[0].url;
                    pentUrl = model.forecastUrls[0].pentUrl;
                    baseUrl = model.baseUrl;
                    searchPage = model.weatherSearchPage;

                    $(container).find('.weatherSelect').bind('change', function() {
                        var selectedValue = $(this).find(":selected").val();
                        place = model.forecastUrls[selectedValue].url;
                        pentUrl = model.forecastUrls[selectedValue].pentUrl;
                        retrieveForecast(baseUrl + place, pentUrl);
                    });

                    retrieveForecast(baseUrl + place, pentUrl);
                });
            }
        }

        function retrieveForecast(url, pentUrl) {
            jQuery.ajax({
                type: "GET",
                url: url + '?count=' + numDays + '&hourly=false',
                dataType:'jsonp',
                cache: true,
                jsonpCallback: 'dropdownLongterm',
                success:function(data) {
                    if (data.error == false) {
                        showWeather(data, pentUrl);
                    } else {
                        mno.core.log(1, 'error retrieveForecast in dropdownLongterm: ' + data.errorMessage);
                    }
                },
                error:function(jqHXR, textStatus, errorThrown) {
                    mno.core.log(1, 'error retrieveForecast in dropdownLongterm: ' + textStatus + ' ' + errorThrown);
                }
            });
        }

        function showWeather(forecast, pentUrl) {
            if (forecast.forecast.name !== undefined) {

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

                function getPlaceQuery(name){
                    var trimmed = name.replace(' ', '_');
                    return "sted="+escape(trimmed);
                }

                function getDate(millis){
                    var d = new Date(millis),
                        day = d.getDate();

                    return ((day < 10) ? '0' + day : day) +'. '+monthLabels[d.getMonth()];
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

                var monthLabels=['jan','feb','mar','apr','mai','jun','jul','aug','sep','okt','nov','des'];

                var today = new Date();
                var todayString = ((today.getDate() < 10) ? '0' + today.getDate() : today.getDate())+'. '+monthLabels[today.getMonth()];

                sandbox.render('widgets.weather.view.dropdownLongterm', {weather:forecast.forecast.text_tabular, place:forecast.forecast.name, searchPage:searchPage, getPlaceQuery:getPlaceQuery, today:todayString, getDate:getDate, getDay:getDay, getHours:getHours, getWindSymbolClass:getWindSymbolClass, round:Math.round, pentUrl:pentUrl}, function(html) {
                    $(container).find('ul').html(html);
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
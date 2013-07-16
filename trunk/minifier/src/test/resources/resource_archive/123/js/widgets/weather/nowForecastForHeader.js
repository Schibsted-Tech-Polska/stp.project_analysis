mno.core.register({
    id:'widget.weather.nowForecastForHeader',
    creator:function (sandbox) {
        var model, container, baseUrl, place, searchPage, pentSearchPage;

        function init() {
            model = sandbox.model[0];
            container = sandbox.container[0];
            baseUrl = model.baseUrl;
            place = model.place;
            searchPage = model.weatherSearchPage;
            pentSearchPage = model.pentSearchPage;

            getForecastForPlace();

        }

        function getForecastForPlace(){
            jQuery.ajax({
                url: baseUrl+"json/searchLocations.json?country=no",
                dataType: "jsonp",
                jsonpCallback: "searchLocations"+place,
                cache: true,
                data: {
                    term: place
                },
                success: function( data ) {
                    if(data.length>0){
                        var firstHit = data[0].value;
                        var queryToPutInUrl = getPlaceQuery(data[0].name, data[0].kommune, data[0].fylke);
                        retrieveForecast(firstHit, queryToPutInUrl);
                    }else{
                        mno.core.log(1, 'empty result from getForecastForPlace on '+place);
                    }
                }
            });
        }

        function getPlaceQuery(name, kommune, fylke){
            var trimmed = name.replace(' ', '_');
            return "sted="+escape(trimmed)+"&kommune="+escape(kommune)+"&fylke="+escape(fylke)+"&country=no";
        }

        function retrieveForecast(url, queryToPutInUrl){
            jQuery.ajax({
                type: "GET",
                url: url+'?count=1&hourly=true',
                dataType:'jsonp',
                cache: true,
                jsonpCallback: 'retrieveForecastCallback',
                success:function(data) {
                    if(data.error === false){
                        showWeather(data, queryToPutInUrl);
                    }else{
                        mno.core.log(1, 'error retrieveForecast in miniforecast: '+data.errorMessage);
                    }
                },
                error:function(jqHXR, textStatus, errorThrown) {
                    mno.core.log(1, 'error retrieveForecast in miniforecast: ' + textStatus + ' ' + errorThrown);
                }
            });
        }

        function showWeather(forecast, queryToPutInUrl){
            if(forecast.forecast.text_tabular_hourly[0]!==undefined){
                if(pentSearchPage == ''){
                    pentSearchPage = searchPage + "?" + queryToPutInUrl;
                }
                sandbox.render('widgets.weather.view.miniWeather',{weather:forecast.forecast.text_tabular_hourly[0], placeQuery:queryToPutInUrl, place:forecast.forecast.name, searchPage:pentSearchPage}, function(html){
                    $(container).empty().append(html);
                });
            }
        }

        function destroy() {}

        return {
            init:init,
            destroy:destroy
        }
    }
});
mno.core.register({
    id:'widget.weather.weatherSearch',
    wait:['widget.weather.articleLongtermForecast', 'widget.weather.hourByHourMap', 'widget.weather.hourByHour', 'widget.weather.forecastSummary'],
    creator:function (sandbox) {
        var baseUrl;

        function init() {
            sandbox.getScript({
                url: mno.publication.url + 'resources/js/mno/utils/jquery-ui-1_8_16_custom_min.js',
                callback: assetsLoaded
            });
        }

        function assetsLoaded() {
            if (sandbox.container === null) {
                return;
            }
            var container = sandbox.container[0];
            var model = sandbox.model[0];
            baseUrl = model.baseUrl;
            var searchPage = model.weatherSearchPage;

            $(container).find("#autosearch").autocomplete({
                source: function( request, response ) {
                    jQuery.ajax({
                        url: baseUrl+"json/searchLocations.json",
                        dataType: "jsonp",
                        jsonpCallback: "searchLocation"+request.term,
                        cache: true,
                        data: {
                            term: request.term
                        },
                        success: function( data ) {
                            response( jQuery.map( data, function( item ) {
                                return {
                                    label: item.name+' ('+item.kommune+') ('+item.fylke+')',
                                    value: item.name+' ('+item.kommune+') ('+item.fylke+') ('+item.countryCode.toLowerCase()+')',
                                    country: item.countryCode.toLowerCase()
                                }
                            }));
                        }
                    });
                },
                minLength: 2,
                focus: function(event, ui){
                    $(ui.item).addClass('focused');
                }
            }).data("autocomplete")._renderItem = function(ul, item){
                return $('<li></li>')
                        .data("item.autocomplete", item)
                        .append($("<a></a>").html(item.label).append($("<img src='/skins/global/gfx/blank.gif'></img>").addClass('flag').addClass('flag-'+item.country)))
                        .appendTo(ul);
            };

            $(container).find('form').bind('submit', function (event) {
                var weatherSearchInput =  $('form input#autosearch');
                var query =  weatherSearchInput.val().split(' (');
                var queryPlace = query[0];
                if(query.length>1){
                    var queryKommune = query[1].replace(')', '');
                    if(query.length>2){
                        var queryFylke = query[2].replace(')', '');
                        if(query.length>3){
                            var queryCountry = query[3].replace(')', '');
                            window.location = searchPage+'?sted='+escape(queryPlace)+'&kommune='+escape(queryKommune)+'&fylke='+escape(queryFylke)+'&country='+escape(queryCountry);
                        }else{
                            window.location = searchPage+'?sted='+escape(queryPlace)+'&kommune='+escape(queryKommune)+'&fylke='+escape(queryFylke);
                        }
                    }else{
                        window.location = searchPage+'?sted='+escape(queryPlace)+'&kommune='+escape(queryKommune);
                    }
                }else{
                    window.location = searchPage+'?sted='+escape(queryPlace);
                }
                return false;
           });

            var requestParams = mno.utils.params.getAllParameters();
            if(requestParams['sted']!=undefined){
                var place = stripTags(requestParams['sted']);
                var kommune = stripTags(requestParams['kommune']);
                var fylke = stripTags(requestParams['fylke']);
                var list = stripTags(requestParams['list']);
                var country = stripTags(requestParams['country']);
                sandbox.listen({
                    'gapiReady':function () {
                        doSearch(place, kommune, fylke, country, list);
                }});
            }else if(requestParams['lat']!=undefined){
                var lat = stripTags(requestParams['lat']);
                var lng = stripTags(requestParams['lng']);
                sandbox.listen({
                    'gapiReady':function () {
                        doSearchLL(lat, lng);
                }});
            }

            function stripTags(line){
                if(line != undefined){
                    line = line.replace(/&(lt|gt);/g, function (strMatch, p1){ return (p1 == "lt")? "<" : ">";});
                    line = line.replace(/<\/?[^>]+(>|$)/g, "");
                    return line;
                }else{
                    return line;
                }

            }

            function doSearchLL(lat, lng){
                var fixedLat = parseFloat(lat).toFixed(4);
                var fixedLng = parseFloat(lng).toFixed(4);
                var url = baseUrl+"json/reverseGeoCode.json?latlng="+fixedLat+","+fixedLng+"&provider=mixed&callback=?";

                jQuery.ajax({
                    type: "GET",
                    url: url,
                    dataType:'jsonp',
                    cache:'true',
                    success:function(data) {
                        var url = baseUrl+data.local_url+'varsel.json?hourly=true';
                        retrieveForecast(url, lat+','+lng, lat+','+lng);
                    },
                    error:function(jqHXR, textStatus, errorThrown) {
                        mno.core.log(1, 'error retrieveForecast: ' + textStatus + ' ' + errorThrown);
                    }
                });
            }

            function doSearch(place, kommune, fylke, country, list){
                var term = decodeURIComponent(place);
                var searched = place;
                var searchUrl = baseUrl+"json/searchLocations.json?callback=?&term="+term;

                if(kommune!=undefined){
                    var kommuneTerm = decodeURIComponent(kommune);
                    searched = searched +' ('+kommuneTerm+')';
                    searchUrl = searchUrl + '&kommune='+kommuneTerm;
                }
                if(fylke!=undefined){
                    var fylkeTerm = decodeURIComponent(fylke);
                    searched = searched + ' ('+fylkeTerm+')';
                    searchUrl = searchUrl + '&fylke='+fylkeTerm;
                }
                if(list!=undefined){
                    searchUrl = searchUrl + '&list='+list;
                }
                if(country!=undefined){
                    searched = searched + ' ('+country+')';
                    searchUrl = searchUrl + '&country='+country;
                }

                jQuery.ajax({
                    type: 'GET',
                    url: searchUrl,
                    dataType: "jsonp",
                    cache:'true',
                    success: function( data ) {
                        if(data.length>0){
                            var firstHit = data[0].value+'?hourly=true';
                            $(container).find("#autosearch").val(searched);
                            retrieveForecast(firstHit, data[0].latLng, place);
                            if(data.length>1){
                                showResultOptions(data);
                            }
                        }else{
                            mno.core.log(1, 'empty result from weathersearch on '+place);
                            sandbox.notify({
                                type:'weatherSearch-searchPerformed',
                                data:{place:searched}
                            });
                        }
                    }
                });
            }

            function getPlaceQuery(name, kommune, fylke, country){
                var trimmed = name.replace(' ', '_');
                return "sted="+escape(trimmed)+"&kommune="+escape(kommune)+"&fylke="+escape(fylke)+'&country='+country;
            }

            function showResultOptions(data){
                sandbox.render('widgets.weather.view.searchResultOptions',{places:data, searchPage:searchPage, getPlaceQuery:getPlaceQuery}, function(html){
                    $(container).find('#searchResultOptions').html(html).show();
                });
            }

            function retrieveForecast(url, latlng, searchedPlace){
                jQuery.ajax({
                    type: "GET",
                    url: url,
                    dataType:'jsonp',
                    cache: true,
                    jsonpCallback: 'retrieveForecastCallback',
                    success:function(data) {
                        if(data.error === false){
                            sandbox.notify({
                                type:'weatherSearch-searchPerformed',
                                data:{forecast:data, latlng:latlng}
                            });
                        }else{
                            mno.core.log(1, 'error retrieveForecast in search: '+data.errorMessage);
                            sandbox.notify({
                                type:'weatherSearch-searchPerformed',
                                data:{place:searchedPlace}
                            });
                        }
                    },
                    error:function(jqHXR, textStatus, errorThrown) {
                        mno.core.log(1, 'error retrieveForecast in search: ' + textStatus + ' ' + errorThrown);
                    }
                });
            }

            if (navigator.geolocation) {
                var geoButton = jQuery('<button class="floatLeft">Finn meg</button>');
                geoButton.appendTo(sandbox.container.find('form'));
                geoButton.bind('click', function () {
                    var lat, lng;
                    navigator.geolocation.getCurrentPosition(function(position) {
                            lat = position.coords.latitude.toFixed(4);
                            lng = position.coords.longitude.toFixed(4);
                            window.location = searchPage+'?lat='+lat+'&lng='+lng;

                        }, function error() {

                        }, {
                            enableHighAccuracy:true,
                            maximumAge:30000,
                            timeout:27000
                        });
                    navigator.geolocation.watchPosition(function(position) {
                            lat = position.coords.latitude.toFixed(4);
                            lng = position.coords.longitude.toFixed(4);
                            window.location = searchPage+'?lat='+lat+'&lng='+lng;
                        },
                        function error() {

                        }, {
                            enableHighAccuracy:true,
                            maximumAge:30000,
                            timeout:27000
                        });
                        return false;
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


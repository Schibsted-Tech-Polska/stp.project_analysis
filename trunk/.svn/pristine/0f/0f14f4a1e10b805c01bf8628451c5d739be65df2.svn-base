mno.core.register({
    id:'widget.weather.hourByHourMap',
    extend:['widget.map.default'],
    creator:function (sandbox) {
        var map, model, container, markersArray=[], isMobile, baseUrl, searchPage, g;
        var windSymbols = new Image();
        windSymbols.src = sandbox.publication.url+"skins/global/gfx/weather/icons_25x25.png";
        var weatherSymbols = new Image();
        weatherSymbols.src = sandbox.publication.url+"skins/global/gfx/weather/icons_55x55.png";

        var memoizedCreateWeatherImageData = sandbox.memoize(createWeatherImageData);
        var memoizedCreateWindImageData = sandbox.memoize(createWindImageData);


        /*mobile helpers*/
        var dragFlag = false;
        var start = 0, end = 0;

        function init() {
            model = sandbox.model[0];
            container = sandbox.container[0];
            baseUrl = model.baseUrl;
            searchPage = model.weatherSearchPage;
            isMobile = (model.mobileVersion=='true');

            sandbox.listen({
                'gapiReady':function () {
                    g=google.maps;
                    readyForMapDrawing(model);
                }
            });
        }

        function readyForMapDrawing(model){
            if(window.location.href.indexOf(searchPage)==-1){
                initWeatherMap(model.mapData.positionData[0].point.lat, model.mapData.positionData[0].point.lng, model.zoomLevel,model.mapTypeId);
            }
            else{
                sandbox.listen({
                    'weatherSearch-searchPerformed':function (data) {
                        if(data.forecast!=undefined){
                            var lat = data.latlng.split(',')[0];
                            var lng = data.latlng.split(',')[1];
                            var forecast = data.forecast.forecast;
                            initWeatherMap(lat, lng, 9, model.mapTypeId, forecast);
                        }else{
                            showEmptyForecast(data.place);
                        }
                    }
                });
            }
        }

        function initWeatherMap(lat, lng, zoomLevel, mapType, searchResultForecast){
            var element = $(container).find('div.map')[0];
            if(isMobile){
                map = initMobileMap(lat, lng, zoomLevel, g.MapTypeId[mapType], element);
            }else{
                map = initMap(lat, lng, zoomLevel, g.MapTypeId[mapType], element);
            }
            if(model.showYr=='true'){
                sandbox.render('widgets.weather.view.yrDisclaimer', {yrUrl:''}, function(html){
                    $(container).append(html);
                });
            }

            g.event.addListener(map, 'bounds_changed', function() {
                initMapOverlays(map, lat, lng, searchResultForecast);
            });

            g.event.addListener(map, 'click', function(event) {
                var clickLocation = event.latLng;
                setTimeout(function(){goToLocation(clickLocation.lat(), clickLocation.lng())}, 500);
            });
            if(isMobile){
               $(element).bind('touchstart', function(e){
                    dragFlag = true;
                    start = e.originalEvent.touches[0].pageY;
                });
                $(element).bind('touchend', function(){
                    dragFlag = false;
                });
                $(element).bind('touchmove', function(e){
                    if ( !dragFlag ) return;
                    end = e.originalEvent.touches[0].pageY;
                    window.scrollBy( 0,( start - end ) );
                });
            }
        }

        function initMapOverlays(map, lat, lng, searchResultForecast){
            deleteOverlays();
            if(searchResultForecast){
                placeCurrentSearchMarker(lat, lng, searchResultForecast);
            }
            getWeatherMarkers(map.getBounds(), map.getZoom());
        }

        function placeCurrentSearchMarker(lat, lng, searchResultForecast){
            var ll = new g.LatLng(lat, lng);
            var forecast = searchResultForecast.text_tabular_hourly[0];
            createWeatherMarker(forecast.symbol_number, forecast.symbol_var, forecast.windSpeed_mps, forecast.windDirection_code, forecast.temperature_value, searchResultForecast.name, ll);
        }

        function initMap(lat, lng, zoomLevel,mapTypeId, element){
            try{
                /* set map options */
                var myOptions = {
                    zoom: zoomLevel !== null && zoomLevel !== "" ? parseInt(zoomLevel,10) : 10,
                    /* set the first cordinate as center of map */
                    center: new g.LatLng(lat, lng),
                    mapTypeId: mapTypeId,
                    mapTypeControl: true,
                    streetViewControl: false,
                    mapTypeControlOptions: {
                        mapTypeIds:[
                            g.MapTypeId.ROADMAP,
                            g.MapTypeId.SATELLITE,
                            g.MapTypeId.TERRAIN,
                            g.MapTypeId.HYBRID
                        ],
                        position: g.ControlPosition.TOP_RIGHT,
                        style: g.MapTypeControlStyle.DROPDOWN_MENU
                    }
                };
                /* create map */
                return new g.Map(element,myOptions);
            }catch(e){
                mno.core.log(3,"widgets/weather/hourByHourMap.js at initMap stack" + e.stack);
            }
        }

        function initMobileMap(lat, lng, zoomLevel,mapTypeId, element){
            try{
                /* set map options */
                var myOptions = {
                    zoom: zoomLevel !== null && zoomLevel !== "" ? parseInt(zoomLevel,10) : 10,
                    /* set the first cordinate as center of map */
                    center: new g.LatLng(lat, lng),
                    mapTypeId: mapTypeId,
                    streetViewControl: false,
                    mapTypeControl: false,
                    disableDoubleClickZoom:true,
                    draggable:false
                };
                /* create map */
                return new g.Map(element,myOptions);
            }catch(e){
                mno.core.log(3,"widgets/weather/hourByHourMap.js at initMap stack" + e.stack);
            }
        }

        function deleteOverlays() {
            if (markersArray) {
                for (i=0; i < markersArray.length; i++) {
                    markersArray[i].setMap(null);
                }
                markersArray.length = 0;
            }
        }

        function goToLocation(lat, lng){
            var fixedLat = lat.toFixed(4);
            var fixedLng = lng.toFixed(4);
            window.location.href = searchPage+'?lat='+fixedLat+'&lng='+fixedLng;
        }

        function getWeatherMarkers(bounds, zoomLevel){
            var sw = bounds.getSouthWest().toUrlValue(2);
            var ne = bounds.getNorthEast().toUrlValue(2);

            var code = 'P.PPLC';
            if(zoomLevel>11){
                code = 'P.PPL';
            }else if(zoomLevel>9){
                code = 'P.PPLA2';
            }else if(zoomLevel>6){
                code = 'P.PPLA';
            }

            var weatherMarkersUrl = baseUrl+"json/findLocations.json?code="+code+"&latLngSW=" + sw + "&latLngNE=" + ne + "&callback=?";

            jQuery.ajax({
                type: "GET",
                url: weatherMarkersUrl,
                dataType:'jsonp',
                cache:'true',
                jsonpCallback:'weatherMarker',
                success:function(data) {
                    printWeatherMarkers(data);
                },
                error:function(jqHXR, textStatus, errorThrown) {
                    mno.core.log(1, 'error getWeatherMarkers: ' + textStatus + ' ' + errorThrown);
                }
            });
        }

        function printWeatherMarkers(markers){
            jQuery.each(markers.locations,function(i, item){
                placeMarker(item);
            });
        }

        function placeMarker(item){
            var lls = item.latLng.split(",");

            var ll = new g.LatLng(lls[0], lls[1]);

            if(item.text_tabular && item.text_tabular.length>0){
                var weather = item.text_tabular[0];
                createWeatherMarker(weather.symbol_number, weather.symbol_var, weather.windSpeed_mps, weather.windDirection_code, weather.temperature_value, item.name, ll);
            }
        }

        function setWeatherMarker(markerImageData, name, latlng){
            var marker = new g.Marker({
                    position: latlng,
                    icon: markerImageData,
                    title: name,
                    map: map,
                    draggable:false
                });
            markersArray.push(marker);

            g.event.addListener(marker, 'click', function(event) {
                var clickLocation = event.latLng;
                setTimeout(function(){goToLocation(clickLocation.lat(), clickLocation.lng())}, 500);
            });
        }

        function createWeatherMarker(symbolnr, symbolvar, windSpeed, windDir, temperature, name, latlng){
            var testCanvas = document.createElement("canvas");
            if(!testCanvas.getContext){//canvas is not supported
                var symbolYpos = symbolnr*55;
                var night = symbolvar.indexOf('n')!=-1;
                if(night){
                    symbolYpos = symbolYpos+symbolnr*55;
                }
                var image = new g.MarkerImage(sandbox.publication.url+"skins/global/gfx/weather/icons_55x55.png", new g.Size(55, 55), new g.Point(0, symbolYpos));;
                setWeatherMarker(image, name, latlng);
            }else{
                var windImageData = memoizedCreateWindImageData(windSpeed, windDir);
                var windArrow = new Image();
                windArrow.onload = function(){
                    var weatherMarkerImageData = memoizedCreateWeatherImageData(windArrow, symbolnr, symbolvar, temperature);
                    setWeatherMarker(weatherMarkerImageData, name, latlng);
                };
                windArrow.src = windImageData;
            }
        }

        function createWindImageData(windSpeed, windDir){
            /*tegner vindpil i eget canvas først, for å kunne rotere den korrekt, for så å tegne den ferdigroterte pila i hovedcanvaset*/
            var windCanvas = document.createElement("canvas");
            var windCtx = windCanvas.getContext("2d");
            windCtx.width = 25;
            windCtx.height = 25;
            windCtx.translate(25/2, 25/2);
            windCtx.rotate(getRotationDegree(windDir) * Math.PI / 180);
            windCtx.translate(-25/2, -25/2);
            var windYpos = getWindSymbolYPos(windSpeed,25);
            windCtx.drawImage(windSymbols, 0, windYpos, 25, 25, 0, 0, 25, 25);
            return windCanvas.toDataURL();
        }

        function createWeatherImageData(windArrow, symbolnr, symbolvar, temperature){
            var canvas = document.createElement("canvas");
            var ctx = canvas.getContext("2d");
            canvas.width = 80;
            canvas.height = 60;

            /* VIND */
            ctx.fillStyle = '#FFFFFF';
            ctx.beginPath();
            ctx.arc(58,42,16,0,Math.PI*2,true);
            ctx.closePath();
            ctx.fill();
            ctx.drawImage(windArrow, 49, 31);

            ctx.shadowOffsetX = 2;
            ctx.shadowOffsetY = 2;
            ctx.shadowBlur = 2;
            ctx.shadowColor = "rgba(0, 0, 0, 0.7)";

            /* VÆR */
            var symbolYpos = symbolnr*55;
            var night = symbolvar.indexOf('n')!=-1;
            if(night){
                symbolYpos = symbolYpos+symbolnr*55;
            }
            ctx.drawImage(weatherSymbols, 0, symbolYpos, 55, 55, 0, 0, 55, 55);

            /* TEMPERATUR */
            var tempColor = '#007aa6';
            if(temperature>0){
                tempColor = '#990000';
            }
            ctx.fillStyle=tempColor;
            ctx.beginPath();
            ctx.arc(55,20,12,0,Math.PI*2,true);
            ctx.closePath();
            ctx.fill();
            ctx.fillStyle = '#FFFFFF';
            ctx.fillText(temperature+'°C', 45,23)

            return canvas.toDataURL();
        }

        function getRotationDegree(windDir){
            if(windDir=='N'){
                return 180;
            }else if(windDir=='NNE'){
                return 202;
            }else if(windDir=='NE'){
                return 225;
            }else if(windDir=='ENE'){
                return 247;
            }else if(windDir=='E'){
                return 270;
            }else if(windDir=='ESE'){
                return 295;
            }else if(windDir=='SE'){
                return 315;
            }else if(windDir=='SSE'){
                return 337;
            }else if(windDir=='S'){
                return 0;
            }else if(windDir=='SSW'){
                return 22;
            }else if(windDir=='SW'){
                return 45;
            }else if(windDir=='WSW'){
                return 67;
            }else if(windDir=='W'){
                return 90;
            }

        }

        function getWindSymbolYPos(windspeed,symbolHeight){
            if(windspeed<1.6){
                return 35*symbolHeight;
            }else if(windspeed<3.4){
                return 36*symbolHeight;
            }else if(windspeed<5.5){
                return 37*symbolHeight;
            }else if(windspeed<8.0){
                return 38*symbolHeight;
            }else if(windspeed<10.8){
                return 39*symbolHeight;
            }else if(windspeed<13.9){
                return 40*symbolHeight;
            }else if(windspeed<17.2){
                return 41*symbolHeight;
            }else if(windspeed<20.8){
                return 42*symbolHeight;
            }else if(windspeed<24.5){
                return 43*symbolHeight;
            }else if(windspeed<28.5){
                return 44*symbolHeight;
            }else if(windspeed<32.6){
                return 45*symbolHeight;
            }else if(windspeed>=32.6){
                return 46*symbolHeight;
            }
        }


        function showEmptyForecast(place){
            $(container).html('Værvarsel ikke tilgjengelig for '+place);
        }

        function destroy() {}

        return {
            init:init,
            destroy:destroy
        }
    }
});
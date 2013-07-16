mno.core.register({
    id:'widget.weather.hourByHour',
    creator:function (sandbox) {
        var baseUrl, pointHourInterval;

        function init() {
            if (sandbox.container) {
                sandbox.container.each(function(i, element){
                    var model = sandbox.model[i];
                    baseUrl = model.baseUrl;
                    pointHourInterval = model.pointHourInterval;
                    if(pointHourInterval==undefined || pointHourInterval=='') pointHourInterval = 1;

                    sandbox.listen({
                        'weatherSearch-searchPerformed':function (data) {
                            if(data.forecast!=undefined){
                                handleForecast(element, data.forecast, model.showYr, model.weatherDisplayName);
                            }else{
                                $(element).hide();
                            }
                        }
                    });

                    if(model.latitude!='' && model.longitude!=''){
                        retrieveForecast(element, model.latitude, model.longitude, model.showYr, model.weatherDisplayName);
                    }
                });
            }
        }

        function retrieveForecast(container, latitude, longitude, showYr, displayName){
            var fixedLat = parseFloat(latitude).toFixed(4);
            var fixedLng = parseFloat(longitude).toFixed(4);
            var getLatLngUrl = baseUrl+"/json/reverseGeoCode.json?latlng="+fixedLat+","+fixedLng+"&provider=yr&callback=?";

            function retrieveForecastUrl(url){
                jQuery.ajax({
                    type: "GET",
                    url: url,
                    dataType:'jsonp',
                    cache:'true',
                    success:function(data) {
                        retrieveForecast(baseUrl+data.local_url+'varsel.json?hourly=true&callback=?')
                    },
                    error:function(jqHXR, textStatus, errorThrown) {
                        mno.core.log(1, 'error retrieveForecast: ' + textStatus + ' ' + errorThrown);
                    }
                });
            }

            function retrieveForecast(url){
                jQuery.ajax({
                    type: "GET",
                    url: url,
                    dataType:'jsonp',
                    cache: true,
                    jsonpCallback: 'hourByHourVarsel',
                    success:function(data) {
                        if(data.error == false){
                            handleForecast(container, data, showYr, displayName);
                        }else{
                            mno.core.log(1, 'error retrieveForecast: '+data.error.errorMessage);
                        }
                    },
                    error:function(jqHXR, textStatus, errorThrown) {
                        mno.core.log(1, 'error retrieveForecast: ' + textStatus + ' ' + errorThrown);
                    }
                });
            }

            retrieveForecastUrl(getLatLngUrl);
        }

        function getSymbol(symbolnr, symbolvar){
            var symbolYpos = symbolnr*25;
            var night = symbolvar.indexOf('n')!=-1;
            if(night){
                symbolYpos = 375+symbolnr*25;
            }
            var symbol = {
                        url: '/skins/global/gfx/weather/icons_25x25.png',
                        yPos: symbolYpos
                    }
            return symbol;
        }


        function handleForecast(container, data, showYr, displayName){
            var tempData = [];
            var rainMinData = [];
            var rainMaxData = [];
            var wind = [];
            var symbols = [];

            if(data.forecast.text_tabular_hourly && data.forecast.text_tabular_hourly.length>0){
                var periods = data.forecast.text_tabular_hourly;

                /* variabler for å hjelpe til når vi "hopper over" noen tidsintervaller*/
                var from;
                var rainMinTotal = 0.0;
                var rainMaxTotal = 0.0;

                var maxTime;

                jQuery.each(periods, function(i, per){
                    if(i==24){       /* ønsker bare å vise de neste 24 timene */
                        return false;
                    }
                    if(i==0){
                        maxTime = per.time_from_millis + (24*60*60*1000);
                    }else if(per.time_from_millis>maxTime){
                        return false;
                    }

                    if(from==undefined)from = new Date(per.time_from_millis);
                    rainMinTotal = rainMinTotal + (per.precipitation_minvalue>0 ? per.precipitation_minvalue : per.precipitation_value);
                    rainMaxTotal = rainMaxTotal + per.precipitation_maxvalue;

                    if(i%pointHourInterval==0){
                        var to = new Date(per.time_to_millis);
                        var middle = (per.time_from_millis+per.time_to_millis)/2;
                        var tempColor = '#007AA6';
                        if(per.temperature_value>0){
                            tempColor = '#990000';
                        }
                        tempData.push({
                            x:middle,y:per.temperature_value, from:from, to:to, color:tempColor,
                            marker:{fillColor:tempColor, states:{hover:{fillColor:tempColor, radius: 5}}},
                            weather:per.symbol_name});
                        rainMinData.push({x:middle,y:rainMinTotal, from:from, to:to});
                        rainMaxData.push({x:middle,y:(rainMaxTotal-rainMinTotal>0 ? rainMaxTotal-rainMinTotal : 0), from:from, to:to});
                        symbols.push(getSymbol(per.symbol_number, per.symbol_var));
                        wind.push({speed:Math.round(per.windSpeed_mps), direction:per.windDirection_code});

                        rainMinTotal = 0.0;
                        rainMaxTotal = 0.0;
                        from = undefined;
                    }
                });
            }

            if(displayName==undefined || displayName==''){
                displayName = data.forecast.name;
            }

            renderGraph(($(container).find('.hourByHourDiv'))[0], tempData, rainMinData, rainMaxData, symbols, wind, showYr);
            $(container).find('h2').html('Korttidsvarselet for '+displayName);
        }

        function renderGraph(element, temp, rain_min, rain_max, symbols, wind, showYr){
            if (typeof Highcharts === 'undefined') {
                sandbox.getScript({
                    url: sandbox.publication.url + 'resources/js/mno/utils/highcharts.js',
                    callback:function () {
                        renderGraph(element, temp, rain_min, rain_max, symbols, wind, showYr);
                    }
                });
            } else {
                Highcharts.setOptions({
                    global:{
                        useUTC: false
                    }
                });
                var chart = new Highcharts.Chart({
                  chart: {
                     renderTo: element,
                     events: {
                         load: applyGraphColor
                     }
                  },
                  credits:{
                      enabled: false
                  },
                  title: {
                     text: 'Meteogram'
                  },
                  subtitle: {
                     text: function(){if(showYr=='true'){return 'Værvarsel fra <a href="http://yr.no">yr.no</a> levert av <a href="http://met.no">Meterologisk Institutt</a> og <a href="http://nrk.no">NRK</a>';}else{return null;}}()
                  },
                  xAxis: [
                      {
                            type: 'datetime',
	                        tickInterval: pointHourInterval * 3600 * 1000,
                            tickPosition: 'inside',
                            tickLength: 30,
                            gridLineWidth: 1,
                            offset: 40,
                            showLastLabel: true,
                            labels: {
                                formatter: function(){
                                    return Highcharts.dateFormat(
                                        '%H',
                                        this.value
                                    );
                                }
                            },
                         title:{
                             text: ''
                         }
                      },{
							linkedTo: 0,
                            type: 'datetime',
							tickInterval: 24 * 3600 * 1000,
	                        labels: {
	                            formatter: function(){
                                    if(pointHourInterval>1){
                                        return getNorwegianDateShort(this.value);
                                    }
                                    return getNorwegianDateLong(this.value);
	                            },
								align: 'left'
	                        },
							opposite: true,
							tickLength: 20,
							gridLineWidth: 1
						}
                  ],
                  yAxis: [
                      { // Primary yAxis
                         labels: {
                            formatter: function() {
                               return this.value +'°C';
                            }
                         },
                         title: {
                            text: null
                         },
                          gridLineWidth:1
                      },{ // Primary yAxis
                         labels: {
                            formatter: function() {
                               return this.value +'°C';
                            }
                         },
                         title: {
                            text: null
                         },
                         opposite:true,
                         linkedTo:0,
                         gridLineWidth:0
                      }, { // Secondary yAxis
                         title: {
                            text: null
                         },
                          labels:{
                              enabled:false
                          },
                          gridLineWidth:0
                      }
                  ],
                  tooltip: {
                     formatter: function() {
                        return 'kl.'+
                           Highcharts.dateFormat('%H',this.point.from)+'-'+Highcharts.dateFormat('%H',this.point.to) +': '+
                                (this.series.name=='Nedbør_max' ? 'max '+Highcharts.numberFormat(this.total, 1, ',') : (this.series.name=='Nedbør_min' ? 'min ' +Highcharts.numberFormat(this.y, 1, ',') : this.y)) +
                           (this.series.name == 'Temperatur' ? '°C, '+this.point.weather : 'mm');
                     }
                  },
                  legend: {
                     enabled:false
                  },
                  plotOptions:{
                     spline:{
                        lineWidth: 2,
                            states: {
                               hover: {
                                  enabled: true,
                                  lineWidth: 3
                               }
                            },
                            marker: {
                               enabled: true,
                               states: {
                                  hover: {
                                     enabled: true,
                                     symbol: 'circle',
                                     radius: 5,
                                     lineWidth: 3
                                  }
                               }
                        }
                     },
                      column: {
                        stacking: 'normal'
                     }
                  },
                  series: [{
                     name: 'Nedbør_max',
                     color: '#B4C9E2',
                     type: 'column',
                     yAxis: 2,
                     data: rain_max,
                     groupPadding: 0,
                     pointPadding: 0,
                     dataLabels:{
                         enabled:true,
                         color:'#4572A7',
                         y:12,
                         formatter:function(){
                             if(this.total==0){
                                 return '';
                             }
                             return Highcharts.numberFormat(this.total, 1, ',');
                         }
                     }

                  }, {
                     name: 'Nedbør_min',
                     color: '#4572A7',
                     type: 'column',
                     groupPadding: 0,
                     pointPadding: 0,
                     yAxis: 2,
                     data: rain_min,
                     dataLabels:{
                         color: '#B4C9E2',
                         enabled:true,
                         y:12,
                         formatter:function(){
                             if(this.y=='0'){
                                 return '';
                             }
                             return Highcharts.numberFormat(this.y, 1, ',');
                         }
                     }

                  },{
                     name: 'Temperatur',
                     type: 'spline',
                     color: '#666',
                     yAxis: 0,
                     data: temp
                  }]
               }, function(chart) {

                        var chartContainer = $(element).find('.highcharts-container');

						$.each(chart.series[2].data, function(i, point) {
                            var clipRect = chart.renderer.clipRect(
                                  point.plotX + chart.plotLeft - 15,
                                  point.plotY + chart.plotTop - 29,
                                  25,
                                  25
                             )
                             chart.renderer.image(
                                  symbols[i].url,
                                  point.plotX + chart.plotLeft - 15,
                                  point.plotY + chart.plotTop - 30-symbols[i].yPos,
                                  25,
                                  1175
                             )
                             .clip(clipRect)
                             .attr({
                                  zIndex: 5
                             })
                             .add();

							// Draw the wind arrows
                            var windDiv = document.createElement('div');
                            var windDirDiv = document.createElement('div');
                            var windSpeedDiv = document.createElement('div');
                            $(windSpeedDiv).html(wind[i].speed);

                            $(chartContainer).append(windDiv);
                            $(windDiv).append(windDirDiv);
                            $(windDiv).append(windSpeedDiv);
                            $(windDiv).addClass('wind');
                            $(windDirDiv).addClass('direction').addClass(getWindSymbolClass(wind[i].speed)).addClass('degree'+wind[i].direction);
                            $(windSpeedDiv).addClass('speed');
                            $(windDiv).css('position', 'absolute').css('left', point.plotX + chart.plotLeft - 15).css('top', 335);
						});

                        var windLabelDiv = document.createElement('div');
                        $(windLabelDiv).html('m/s').addClass('wind').css('position', 'absolute').css('left', chart.plotLeft-34).css('top', 357);
                        $(chartContainer).append(windLabelDiv);

                        var hourLabel = document.createElement('div');
                        $(hourLabel).html('kl.').css('position', 'absolute').css('left', chart.plotLeft-24).css('top', 370);
                        $(chartContainer).append(hourLabel);

	                });
            }

            function applyGraphColor() {
                // Options
                var threshold = 0.1,
                    colorAbove = '#990000',
                    colorBelow = '#007AA6';

                // internal
                var series = this.series[2],
                    i,
                    point;

                if (this.renderer.box.tagName === 'svg') {

                    var translatedThreshold = series.yAxis.translate(threshold),
                        y1 = Math.round(this.plotHeight - translatedThreshold),
                        y2 = y1 + 0.01;

                    // Apply gradient to the path
                    series.graph.attr({
                        stroke: {
                            linearGradient: [0, y1, 0, y2],
                            stops: [
                                [0, colorAbove],
                                [1, colorBelow]
                            ]
                        }
                     });


                }

                // Apply colors to the markers
                for (i = 0; i < series.data.length; i++) {
                    point = series.data[i];
                    point.color = point.y < threshold ? colorBelow : colorAbove;
                    if (point.graphic) {
                        point.graphic.attr({
                            fill: point.color
                        });
                    }
                }

                // prevent the old color from coming back after hover
                delete series.pointAttr.hover.fill;
                delete series.pointAttr[''].fill;

            }
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
        }

        function getNorwegianDateLong(date){
            var month = Highcharts.dateFormat('%m', date);
            var nDate = Highcharts.dateFormat('%e', date);
            var day = Highcharts.dateFormat('%a', date);

            var nMonth;
            var nDay;

            switch(month){
                case '01':
                    nMonth = 'januar';
                    break;
                case '02':
                    nMonth = 'februar';
                    break;
                case '03':
                    nMonth = 'mars';
                    break;
                case '04':
                    nMonth = 'april';
                    break;
                case '05':
                    nMonth = 'mai';
                    break;
                case '06':
                    nMonth = 'juni';
                    break;
                case '07':
                    nMonth = 'juli';
                    break;
                case '08':
                    nMonth = 'august';
                    break;
                case '09':
                    nMonth = 'september';
                    break;
                case '10':
                    nMonth = 'oktober';
                    break;
                case '11':
                    nMonth = 'november';
                    break;
                case '12':
                    nMonth = 'desember';
                    break;
            }

            switch(day){
                case 'Mon':
                    nDay = 'Mandag';
                    break;
                case 'Tue':
                    nDay = 'Tirsdag';
                    break;
                case 'Wed':
                    nDay = 'Onsdag';
                    break;
                case 'Thu':
                    nDay = 'Torsdag';
                    break;
                case 'Fri':
                    nDay = 'Fredag';
                    break;
                case 'Sat':
                    nDay = 'Lørdag';
                    break;
                case 'Sun':
                    nDay = 'Søndag';
                    break;
            }

            return '<span style="font-size: 12px; font-weight: bold">'+nDay+'</span> '+nDate+'.'+nMonth;
        }

        function getNorwegianDateShort(date){
            var month = Highcharts.dateFormat('%m', date);
            var nDate = Highcharts.dateFormat('%e', date);
            var day = Highcharts.dateFormat('%a', date);

            var nMonth;
            var nDay;

            switch(month){
                case '01':
                    nMonth = 'jan.';
                    break;
                case '02':
                    nMonth = 'feb.';
                    break;
                case '03':
                    nMonth = 'mar.';
                    break;
                case '04':
                    nMonth = 'apr.';
                    break;
                case '05':
                    nMonth = 'mai';
                    break;
                case '06':
                    nMonth = 'jun.';
                    break;
                case '07':
                    nMonth = 'jul.';
                    break;
                case '08':
                    nMonth = 'aug.';
                    break;
                case '09':
                    nMonth = 'sep.';
                    break;
                case '10':
                    nMonth = 'okt.';
                    break;
                case '11':
                    nMonth = 'nov.';
                    break;
                case '12':
                    nMonth = 'des.';
                    break;
            }

            switch(day){
                case 'Mon':
                    nDay = 'Man.';
                    break;
                case 'Tue':
                    nDay = 'Tirs.';
                    break;
                case 'Wed':
                    nDay = 'Ons.';
                    break;
                case 'Thu':
                    nDay = 'Tors.';
                    break;
                case 'Fri':
                    nDay = 'Fre.';
                    break;
                case 'Sat':
                    nDay = 'Lør.';
                    break;
                case 'Sun':
                    nDay = 'Søn.';
                    break;
            }

            return '<span style="font-size: 12px; font-weight: bold">'+nDay+'</span> '+nDate+'.'+nMonth;
        }

        function destroy() {
        }

        return {
            init:init,
            destroy:destroy
        }
    }
});
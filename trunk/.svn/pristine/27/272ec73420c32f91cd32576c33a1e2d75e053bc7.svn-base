/**
 * Created by IntelliJ IDEA.
 * User: ARISINAB
 * Date: 03.des.2010
 * Time: 16:17:59
 * To change this template use File | Settings | File Templates.
 */
mno.core.register({
    id: 'widget.map.default',
    creator: function (sandbox) {
       function init () {
                var that = this;

                sandbox.getScript({
                    url: 'http://maps.google.com/maps/api/js?sensor=false&async=2&v=3',
                    callbackVar:'callback',
                    jsonP:function () {
                        sandbox.notify({
                            type:'gapiReady',
                            data:true
                        });
                    }
                });
                sandbox.listen({
                    'gapiReady':function () {
                        that.helper(sandbox);    
                    }
                });
            }

       function _isType(mType,type) {
           return (mType.indexOf(type) !== -1) ? true : false;
       }

       function initMap(data, zoomLevel,mapTypeId, element){
                try{
                    /* set map options */
                    var myOptions = {
                        zoom: zoomLevel !== null && zoomLevel !== "" ? parseInt(zoomLevel,10) : 10,
                        /* set the first cordinate as center of map */
                        center: new google.maps.LatLng(data.positionData[0].point.lat, data.positionData[0].point.lng),
                        mapTypeId: mapTypeId/*google.maps.MapTypeId.ROADMAP*/,
                        mapTypeControl: true,
                        mapTypeControlOptions: {
                            mapTypeIds:[
                                google.maps.MapTypeId.ROADMAP,
                                google.maps.MapTypeId.SATELLITE,
                                google.maps.MapTypeId.TERRAIN,
                                google.maps.MapTypeId.HYBRID
                            ],
                            position: google.maps.ControlPosition.TOP_RIGHT,
                            style: google.maps.MapTypeControlStyle.DROPDOWN_MENU
                        }
                    };
                    /* create map */
                    return new google.maps.Map(element,myOptions);
                }catch(e){
                    mno.core.log(3,"widgets/map/default.js at initMap stack" + e.stack);
                }
            }

       function helper(sandbox){

                var $ = sandbox.$,
                        $j = window.jQuery;
                var helpers = {
                    printMarkes: function(data, map, markerIcon){
                        try{
                            var latlng,
                            markers = [],
                            markersFromJson = [];
                            if(typeof data.articles !== "undefined"){
                                $j.each(data.articles,function(i, element){
                                    markersFromJson = markersFromJson.concat(element.positionData);
                                });
                            }
                            else
                            {
                                markersFromJson = data.positionData;
                            }
                            $j.each(markersFromJson,function(i, item){
                                if(typeof item.locInfo !== "undefined"){
                                    latlng = new google.maps.LatLng(item.point.lat, item.point.lng);

                                    /* print marker */
                                    var marker = new google.maps.Marker({
                                        position: latlng,
                                        map: map,
                                        title:item.locInfo.address,
                                        icon: markerIcon
                                    });

                                    /* print label on marker if label is set to a number getJson widget will try to get an article title and the first related picture */
                                    if(typeof item.locInfo !== "undefined" && typeof item.locInfo.label !== "undefined" && item.locInfo.label.length > 0){
                                        var infowindow = new google.maps.InfoWindow({
                                            content: item.locInfo.label
                                        });
                                        google.maps.event.addListener(marker, 'click', function() {
                                            infowindow.open(map,marker);
                                        });
                                    }else if(typeof item.locInfo !== "undefined" && typeof item.locInfo.articleTitle !== "undefined" && typeof item.locInfo.articleUrl !== "undefined"){
                                        var infowindow = new google.maps.InfoWindow({
                                            content: (typeof item.locInfo.articleImg !== "undefined" && item.locInfo.articleImg !== null && item.locInfo.articleImg.length > 0
                                                    ? '<div><a href="' + item.locInfo.articleUrl + '"><img src="' + item.locInfo.articleImg + '" alt="' + item.locInfo.articleTitle + '" /></a><div>' : '')+
                                                    '<div><a href="' + item.locInfo.articleUrl + '">' + item.locInfo.articleTitle + '</a></div>'
                                        });
                                        google.maps.event.addListener(marker, 'click', function() {
                                            infowindow.open(map,marker);
                                        });
                                    }

                                    /* set the article urls for cluster list */
                                    if(typeof item.locInfo !== "undefined" && typeof item.locInfo.articleUrl !== "undefined"){
                                        marker.articleUrl = item.locInfo.articleUrl;
                                    }
                                    else{
                                        marker.articleUrl = null;
                                    }

                                    /* set the article titles for cluster list */
                                    if(typeof item.locInfo !== "undefined" && typeof item.locInfo.articleTitle !== "undefined"){
                                        marker.title = item.locInfo.articleTitle;
                                    }else if(typeof item.locInfo !== "undefined" && typeof item.locInfo.label !== "undefined"){
                                        marker.title = item.locInfo.label;
                                    }else{
                                        marker.title = null;
                                    }
                                    /* ad all the markers in a array for marker cluster to manage */
                                    markers.push(marker);
                                }
                            });
                            return markers;
                        }catch(e){
                            /* use core log 1 = log 2 = warn 3 = error */
                            mno.core.log(3,"widgets/map/default.js at printmarkers stack" + e.stack);
                        }
                    },
                    initClustring: function(markers, map, clusterIcon, markerIcon, styles){
                        try{
                        /* cluster object */
                        var mc = new MarkerClusterer(map,markers,
                        {
                            styles : styles,
                            zoomOnClick: false
                        });

                        /* Listen for a cluster to be clicked */
                        var infoWindow;
                        google.maps.event.addListener(mc, 'clusterclick',function(cluster) {

                            var content = '';
                            var i;
                            /* Get all markers */
                            var clusterMarkers = cluster.getMarkers();
                            /* create html for infowindow */
                            content = content += '<table>';
                            var loopLimit = 3;
                            if(clusterMarkers.length < loopLimit)
                            {
                                loopLimit = clusterMarkers.length;
                            }
                            for(i=0; i<loopLimit;i++){
                                content = content +
                                        '<tr>'+
                                        '<td>' +
                                        '<img src="'+ markerIcon+'" />' +
                                        '</td>' +
                                        '<td>' +
                                        ( clusterMarkers[i].articleUrl !== null ?
                                                '<a class="goToArticle" href="'+  clusterMarkers[i].articleUrl +'">' + clusterMarkers[i].title + '</a>' :
                                                '<a class="clusterZoomIn" href="#">' + clusterMarkers[i].title + '</a>'
                                                ) +

                                '</td>' +
                                '</tr>';
                            }
                            content = content + '</table>';
                            /* create marker zoom in button */
                            if(clusterMarkers.length > loopLimit)
                            {
                                content = content + '<div>' + (clusterMarkers.length - loopLimit) + ' andre punkt</div>';
                            }
                            content = content + '<div><a class="clusterZoomIn" href="/">Zoom inn</a></div>';


                            /* Convert lat/lng from cluster object to a usable MVCObject */
                            var info = new google.maps.MVCObject();
                            info.set('position', cluster.getCenter());

                            infoWindow = new google.maps.InfoWindow();

                            infoWindow.setContent(content);
                            infoWindow.open(map,info);
                            /* if a zoomIn is clicked */
                            $("a.clusterZoomIn").unbind("click");
                            $("a.clusterZoomIn").live("click",function(){
                                infoWindow.close();
                                map.setZoom(map.getZoom()+2);
                                map.setCenter(cluster.getCenter());
                                return false;
                            });

                        });
                        }catch(e){
                             /* use core log 1 = log 2 = warn 3 = error */
                            mno.core.log(3,"widgets/map/default.js at initclustring stack" + e.stack);
                        }
                    }

                };

                if (sandbox.container) {
                    sandbox.container.each(function(i, element){

                        //var widgetId = $(element).attr("data-widget-id");
                        var $element = $(element);

                        var url,
                            zoomLevel,
                            markerIcon = "",
                            clusterIcon,
                            clusteredMarkers,
                            mapData,
                            mapTypeId = google.maps.MapTypeId.ROADMAP,
                            styles = [{
                                    height: 23,
                                    url: clusterIcon,
                                    width: 39,
                                    backgroundPosition: "0px 0px"
                                }],
                            model = sandbox.model[i],map;
                        if (model !== null) {
                            mapTypeId = ((typeof model.mapTypeId !== 'undefined' && model.mapTypeId !== null) ?
                                        google.maps.MapTypeId[model.mapTypeId] : google.maps.MapTypeId.ROADMAP);
                            if (_isType(model.type,'widget.map') || _isType(model.type, 'widget.storyContent')) {
                                url = model.AJAXSOURCE;
                                markerIcon = model.ICONURL;
                                clusterIcon = model.CLUSTERICONURL;
                                zoomLevel = parseInt(model.ZOOMLEVEL !== "" ? model.ZOOMLEVEL : 10,10);
                                clusteredMarkers = model.CLUSTEREDMARKERS;
                                styles = [{
                                    height: 23,
                                    url: clusterIcon,
                                    width: 40
                                }];
                            } else if (_isType(model.type, 'widget.trafficMap')) {
                                url = model.AJAXSOURCE;
                                markerIcon = model.ICONURL;
                                clusterIcon = model.CLUSTERICONURL;
                                zoomLevel = parseInt(model.ZOOMLEVEL !== "" ? model.ZOOMLEVEL : 10,10);
                                clusteredMarkers = model.CLUSTEREDMARKERS;
                                styles = [{
                                    height: 34,
                                    url: clusterIcon,
                                    width: 20
                                }];
                            }


                            // new way to get data
                            if (_isType(model.type, 'widget.slideshow') || _isType(model.type, 'widget.storyContent') || _isType(model.type, 'widget.map') || _isType(model.type, 'widget.mobileStoryContent')) {
                                markerIcon = (typeof model.mapData !== 'undefined' ? model.mapData.iconUrl : model.iconUrl);
                                clusterIcon = (typeof model.mapData !== 'undefined' ? model.mapData.clusterIconUrl : model.clusterIconUrl);
                                zoomLevel = (typeof model.mapData !== 'undefined' ? parseInt(model.mapData.zoomLevel !== "" ? model.mapData.zoomLevel : 10,10)
                                        : parseInt(model.zoomLevel !== "" ? model.zoomLevel : 10,10));
                                clusteredMarkers = ( typeof model.mapData !== 'undefined' ? model.mapData.clusteredMarkers :
                                                    (function(){
                                                        try{
                                                            return Boolean(model.clusteredMarkers);
                                                        }catch(e){
                                                            return false;
                                                        }
                                                    }()));
                                mapTypeId = (typeof model.mapData !== 'undefined' ?
                                                ((typeof model.mapData.mapTypeId !== 'undefined' && model.mapData.mapTypeId !== null) ?
                                                    google.maps.MapTypeId[model.mapData.mapTypeId] : google.maps.MapTypeId.ROADMAP) :
                                                ((typeof model.mapTypeId !== 'undefined' && model.mapTypeId !== null) ?
                                                    google.maps.MapTypeId[model.mapTypeId] : google.maps.MapTypeId.ROADMAP));
                                var markers, wasHiddenInStart = false;
                                styles = [{
                                    height: 23,
                                    url: clusterIcon,
                                    width: 40,
                                    backgroundPosition: "0px 0px"
                                }];

                                /* fix for google maps if map is hidden */
                                /*if($element.css('display') === 'none'){
                                    wasHiddenInStart = true;
                                    $element.show();    
                                }*/

                                if(typeof model.articles !== 'undefined' && model.articles.length > 0){
                                     /* init map */
                                    map = initMap(model.articles[0],zoomLevel,mapTypeId, element);
                                    /* print all markers */
                                    markers = helpers.printMarkes(model,map, markerIcon);

                                }
                                else if(typeof model.mapData !== 'undefined' && model.mapData.positionData.length > 0){
                                    /* init map */
                                    map = initMap(model.mapData,zoomLevel,mapTypeId, element);
                                    /* print all markers */
                                    markers = helpers.printMarkes(model.mapData,map, markerIcon);
                                }
                                /* if clustring is enabled code below will cluster all the nearby markers */
                                if(clusteredMarkers){
                                    helpers.initClustring(markers, map, clusterIcon, markerIcon,styles);
                                }
                                
                                /* fix for google maps if map is hidden */
                                /*if(wasHiddenInStart){
                                    $element.hide();
                                }*/

                            }
                            else{

                                /* get map data in old way */
                                $j.ajax({
                                    url: url,
                                    type: "POST",

                                    success: function(data){
                                        var map, markers;
                                        if(data !== null && typeof data.articles !== "undefined" && data.articles.length > 0){
                                             /* init map */
                                            map = initMap(data.articles[0],zoomLevel,mapTypeId, element);
                                            /* print all markers */
                                            markers = helpers.printMarkes(data,map, markerIcon);

                                        }
                                        else if(data !== null && data.positionData.length > 0){
                                            /* init map */
                                            map = initMap(data,zoomLevel,mapTypeId, element);
                                            /* print all markers */
                                            markers = helpers.printMarkes(data,map, markerIcon);
                                        }
                                        /* if clustring is enabled code below will cluster all the nearby markers */
                                        if(clusteredMarkers){

                                            helpers.initClustring(markers, map, clusterIcon, markerIcon,styles);
                                        }

                                    },

                                    error: function(jXHR, textStatus, errorThrown){
                                         /* use core log 1 = log 2 = warn 3 = error */
                                        mno.core.log(3,'Error while calling map in widget/map/default.js jXHR: '+jXHR+', textStatus: '+textStatus+', errorThrown: '+errorThrown);
                                    }

                                });
                            }
                            sandbox.listen({
                                'mapResize' : function(){
                                    google.maps.event.trigger(map, 'resize');
                                }
                            });
                        }
                    });
                }
       }

        function destroy(){
            /*var $ = null;*/
        }

        return  {
            init: init,
            helper: helper,
            initMap: initMap,
            destroy: destroy
        };
    }
});

/**
 * Created by IntelliJ IDEA.
 * User: ARISINAB
 * Date: 03.des.2010
 * Time: 16:17:59
 * To change this template use File | Settings | File Templates.
 */
mno.core.register({
    id: 'widget.shipTraffic.mapsettings',
    creator: function (sandbox) {
        return {
            init: function () {
                var runShipTraffic;


                runShipTraffic = function(){
                    try
                    {
                        //Returns an XMLHttp instance to use for asynchronous downloading.
                        function createXmlHttpRequest() {
                            try {
                                if (typeof ActiveXObject !== 'undefined') {
                                    return new ActiveXObject('Microsoft.XMLHTTP');
                                } else if (window.XMLHttpRequest) {
                                    return new XMLHttpRequest();
                                }
                            } catch (e) {
                                changeStatus(e);
                            }
                            return null;
                        }


                        // Wraps XMLHttpRequest open/send function.
                        var timeout;
                        function downloadUrl(url, callback) {
                            var status = -1;
                            var request = createXmlHttpRequest();
                            if (!request) {
                                return false;
                            }

                            request.onreadystatechange = function() {
                                if (request.readyState === 4) {
                                    try {
                                        status = request.status;
                                    } catch (e) {
                                        // Usually indicates request timed out in FF.
                                    }
                                    if ((status === 200) || (status === 0)) {
                                        callback(request.responseText, request.status);
                                        request.onreadystatechange = function() {
                                        };
                                    }
                                }
                            };
                            request.open('GET', url + "?" + Math.random(), true);
                            try {
                                request.send(null);
                            } catch (e) {
                                changeStatus(e);
                            }

                        }


                        // Parses the given XML string and returns the parsed document in a DOM data structure.
                        function xmlParse(str) {
                            if (typeof ActiveXObject !== 'undefined' && typeof GetObject !== 'undefined') {
                                var doc = new ActiveXObject('Microsoft.XMLDOM');
                                doc.loadXML(str);
                                return doc;
                            }

                            if (typeof DOMParser !== 'undefined') {
                                return (new DOMParser()).parseFromString(str, 'text/xml');
                            }

                            return createElement('div', null);
                        }

                        // Appends a JavaScript file to the page.
                        function downloadScript(url) {
                            var script = document.createElement('script');
                            script.src = url;
                            document.body.appendChild(script);
                        }

                        // Google maps code
                        var side_bar_html = "";
                        var gmarkers = [];
                        var gicons = [];
                        var map = null;

                        var infowindow = new google.maps.InfoWindow(
                        {
                            size: new google.maps.Size(150, 50)
                        });

                        // Create the marker and set up the event window
                        function createMarker(latlng, name, html, category) {
                            var contentString = html;
                            var marker = new google.maps.Marker({
                                position: latlng,
                                //icon: gicons[category],
                                icon: "/template/externalservices/shipTraffic/img/icon_orange.png",
                                map: map,
                                title: name,
                                zIndex: Math.round(latlng.lat() * -100000) << 5
                            });
                            // Store the category and name info as a marker properties
                            marker.mycategory = category;
                            marker.myname = name;
                            gmarkers.push(marker);

                            google.maps.event.addListener(marker, 'click', function() {
                                infowindow.setContent(contentString);
                                infowindow.open(map, marker);
                            });
                        }

                        // Shows all markers of a particular category, and ensures the checkbox is checked
                        function show(category) {
                            var i;
                            for (i = 0; i < gmarkers.length; i++) {
                                if (gmarkers[i].mycategory === category) {
                                    gmarkers[i].setVisible(true);
                                }
                            }
                            // Check the checkbox
                               if ($('#categories').length !== 0) {
                                    document.getElementById(category + "box").checked = true;
                                } /*else {
                                    //console.log('No categories elements found');
                                }*/

                        }
                        // Hides all markers of a particular category, and ensures the checkbox is cleared
                        function hide(category) {
                            var i;
                            for (i = 0; i < gmarkers.length; i++) {
                                if (gmarkers[i].mycategory === category) {
                                    gmarkers[i].setVisible(false);
                                }
                            }
                            // Clear the checkbox
                            document.getElementById(category + "box").checked = false;
                            // == close the info window, in case its open on a marker that we just hid
                            infowindow.close();
                        }


                        // Rebuilds the sidebar to match the markers currently displayed
                        function makeSidebar() {
                            var html = "", i;
                            for (i = 0; i < gmarkers.length; i++) {
                                if (gmarkers[i].getVisible()) {
                                    html += '<a href="javascript:void(0);">' + gmarkers[i].myname + '<\/a><br>';
                                }
                            }
                            document.getElementById("side_bar").innerHTML = html;
                            sandbox.container.find('#side_bar a').bind('click', function () { // Adds listener to the sidebar. If a boat is clicked, it's position will be showed in the map.
                                var selectedShip = $(this).text();
                                for (i = 0; i < gmarkers.length; i++) {
                                    if (gmarkers[i].myname== selectedShip) {
                                         myclick(i);
                                    }
                                 }
                            });
                        }

                        // A checkbox has been clicked
                        function boxclick(box, category) {
                            if (box.checked) {
                                show(category);
                            } else {
                                hide(category);
                            }
                            // Rebuild the side bar
                            makeSidebar();
                        }

                        function myclick(i) {
                            google.maps.event.trigger(gmarkers[i], "click");
                        }

                        function moveToArea(lat, lng, zoom) {
                            var area = new google.maps.LatLng(lat, lng);

                            map.setCenter(area);
                            map.setZoom(zoom);
                            //var zoom = map.getZoom();

                            /*var myLatlng = new google.maps.LatLng(lat, lng);
                            var myOptions = {
                              zoom: zoom,
                              center: myLatlng,
                              mapTypeId: google.maps.MapTypeId.ROADMAP
                            }
                            map = new google.maps.Map(document.getElementById("map"), myOptions);  */


                        }

                        // Hide the categories initially
                        function hideAll() {
                            hide("military");
                            hide("fishing");
                            hide("towing");
                            hide("sailing");
                            hide("pleasure");
                            hide("highspeed");
                            hide("pilot");
                            hide("search");
                            hide("tug");
                            hide("passenger");
                            hide("cargo");
                            hide("tanker");
                            hide("notdefined");
                            // Build the initial sidebar
                            makeSidebar();
                        }

                        // Show the categories initially
                        function showAll() {
                            show("military");
                            show("fishing");
                            show("towing");
                            show("sailing");
                            show("pleasure");
                            show("highspeed");
                            show("pilot");
                            show("search");
                            show("tug");
                            show("passenger");
                            show("cargo");
                            show("tanker");
                            show("notdefined");
                            // Build the initial sidebar
                            makeSidebar();
                        }

                        //google.setOnLoadCallback(initialize);

                        //Jquery functions
                        if(sandbox.container.find("#map").length >0){
                            $(function() {

                                //function initialize() {

                                //create map on document ready
                                var myOptions = {
                                    zoom: 14,
                                    center: new google.maps.LatLng(60.3925258, 5.323331),
                                    mapTypeId: google.maps.MapTypeId.ROADMAP //TERRAIN,HYBRID,ROADMAP,SATELLITE
                                };
                                map = new google.maps.Map(document.getElementById("map"), myOptions);


                                google.maps.event.addListener(map, 'click', function() {
                                    infowindow.close();
                                });


                                // Read the data
                                downloadUrl("/external/shipTraffic/shipData.xml", function(doc) {
                                    var xml = xmlParse(doc);
                                    var markers = xml.documentElement.getElementsByTagName("marker");
                                    var i;
                                    for (i = 0; i < markers.length; i++) {
                                        // obtain the attribues of each marker
                                        var lat = parseFloat(markers[i].getAttribute("lat"));
                                        var lng = parseFloat(markers[i].getAttribute("lng"));
                                        var point = new google.maps.LatLng(lat, lng);
                                        var status = markers[i].getAttribute("status");
                                        var name = markers[i].getAttribute("shipname");
                                        var mmsi = markers[i].getAttribute("mmsi");
                                        //var mtime = markers[i].getAttribute("mtime");
                                        var speed = markers[i].getAttribute("speed");
                                        var type = markers[i].getAttribute("type");
                                        var course = markers[i].getAttribute("course");
                                        var length = markers[i].getAttribute("length");
                                        var width = markers[i].getAttribute("width");
                                        var draft = markers[i].getAttribute("draft");
                                        var callsign = markers[i].getAttribute("callsign");
                                        var dest = markers[i].getAttribute("dest");
                                        var eta = markers[i].getAttribute("eta");
                                        var imo = markers[i].getAttribute("imo");


                                        var html = "<strong>" + name + "</strong><hr><div style=\"font-family:verdana;font-size:10px;\">Status:" + status + "<br />Type: " + type + "<br />Unik ID(mmsi): " + mmsi + "<br />Fart: " + speed + "(kn)<br />Kurs: " + course + "<br />Lengde: " + length + "m<br />Bredde: " + width + "m<br />Dybde: " + draft + "m<br />Destinasjon: " + dest + "<br />Kallesignal: " + callsign + "<br />Forventet ankomst: " + eta + "<br />Rammenummer(imo): " + imo + "</div>";
                                        var category = markers[i].getAttribute("category");
                                        // create the marker
                                        /*var marker = */createMarker(point, name, html, category);
                                    }

                                    // Show the categories initially
                                    show("military");
                                    show("fishing");
                                    show("towing");
                                    show("sailing");
                                    show("pleasure");
                                    show("highspeed");
                                    show("pilot");
                                    show("search");
                                    show("tug");
                                    show("passenger");
                                    show("cargo");
                                    show("tanker");
                                    show("notdefined");
                                    // Create the initial sidebar

                                    if ($('#side_bar').length !== 0) {
                                        makeSidebar();
                                    } /*else {
                                        //console.log('No sidebar elements found');
                                    }    */


                                });
                                //}
                                //end initialize()
                                function splitCoordinates() {
                                    //$(this).addClass("highlight");
                                    var coordinates = $(this).attr('title');
                                    var coordArray = coordinates.split(",");
                                    var lat = coordArray[0];
                                    var lng = coordArray[1];
                                    var zoom = coordArray[2];
                                    moveToArea(lat,lng,parseInt(zoom,10));
                                    //console.log(lat + lng + "zoom" + parseInt(zoom));
                                }
                                // Hide all categories
                                $("#hideAll").click(function() {
                                    //console.log("Hide all categories");
                                    hideAll();

                                });

                                // Show all categories
                                $("#showAll").click(function() {
                                    //console.log("Show all categories");
                                    showAll();

                                });

                                //show and hide different categories
                                $("form input:checkbox").click(function() {
                                  var currentId = $(this).attr('value');
                                    /* use core log 1 = log 2 = warn 3 = error */
                                    mno.core.log(1,currentId + " is clicked");
                                  boxclick(this,currentId);
                                });

                                //pan to different areas
                                $(".mapView").click(splitCoordinates);

                                $("#pan").each(splitCoordinates);




                            });
                        }
                    }catch(e){

                        if(typeof console.trace === "function"){
                            console.trace();
                        }
                        if(typeof printStackTrace === "function"){
                            printStackTrace({e: e});
                        }
                    }
                };
                if(typeof sandbox.container !== "undefined" && sandbox.container !== null) {
                    sandbox.getScript({
                        url: 'http://maps.google.com/maps/api/js?sensor=false',
                        callbackVar:'callback',
                        jsonP: function () {
                            runShipTraffic();
                        }
                    });
                }

            },
            destroy: function(){
                /*var $ = null;*/

            }
        };
    }
});


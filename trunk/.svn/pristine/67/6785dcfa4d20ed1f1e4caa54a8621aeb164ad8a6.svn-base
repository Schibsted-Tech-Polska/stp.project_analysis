mno.core.register({
    id:'widget.eventDetails.allInformation',
    extend:['widget.moodboard.default'],
    wait: [],
    creator:function (sandbox) {
    	var runMoodBoardInit;
        function init() {
				
        	if (sandbox.container) {
                var runInitPlaceDetails = this.initPlaceDetails;
                runMoodBoardInit = this.initMoodBoard;
                runInitPlaceDetails(sandbox, sandbox.container, sandbox.model[0]);
                
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
        }
        
        function initPlaceDetails( sandbox, container, model) {
		
            var eventID = parseInt(model.eventId,10);

            /*extend model with fields necessary for userrating*/
            model['groupid'] = 200; //100 for place, 200 for event
            model['template'] = 'widgets.moodboard.views.userrating';
            model['scale'] = 6;
            model['siteId'] = 'OsloBy';
            model['objectId'] =  eventID ;
            runMoodBoardInit(sandbox,model, container.find('div#rating'));
        }
		
		function initMap(data, zoomLevel,mapTypeId){


			try{
				
				/* set map options */
				var myOptions = {
					zoom: zoomLevel !== null && zoomLevel !== "" ? parseInt(zoomLevel,10) : 10,
					/* set the first cordinate as center of map */
					center: new google.maps.LatLng(data.positionData[0].point.lat, data.positionData[0].point.lng),
					mapTypeId: mapTypeId,
					mapTypeControl: true,
					streetViewControl: false,
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
				
				return new google.maps.Map(document.getElementById("venue_map_canvas"),myOptions);
			}catch(e){
				mno.core.log(3,"widgets/eventDetails/allInformation.js at initMap stack" + e.stack);
			}
		}
		
		function helper(sandbox){

                var $ = sandbox.$,
                        $j = window.jQuery;
                var helpers = {
                    printMarkes: function(data, map){
                        try{
                            var latlng,
                            markers = [],
                            markersFromJson = [];
                                                       
                            markersFromJson = data.positionData;
                            
                            $j.each(markersFromJson,function(i, item){
                            	
                            	latlng = new google.maps.LatLng(item.point.lat, item.point.lng);
            					
            					var marker = new google.maps.Marker({
                                                    position: latlng,
                                                    map: map
                                                });
                               
                            });
                            return markers;
                        }catch(e){
                            /* use core log 1 = log 2 = warn 3 = error */
                            mno.core.log(3,"widgets/eventDetails/allInformation.js at printmarkers stack" + e.stack);
                        }
                    }

                };

                if (sandbox.container) {
                    sandbox.container.each(function(i, element){

                        var $element = $(element);

                        var url,
                            zoomLevel,
                            markerIcon = "",
                            mapData,
                            mapTypeId = google.maps.MapTypeId.ROADMAP,
                            styles = [{
                                    height: 23,
                                    width: 39,
                                    backgroundPosition: "0px 0px"
                                }],
                            model = sandbox.model[i],map;
                        if (model !== null) {
                            mapTypeId = google.maps.MapTypeId.ROADMAP;

							styles = [{
								height: 23,
								width: 40,
								backgroundPosition: "0px 0px"
							}];

							var positionData = new Array();
							var point = new Object();
							point.lat = model.placeLat;
							point.lng = model.placeLng;
							
							positionData[0] = new Object();
							positionData[0].point = point;
							model.positionData = positionData;
							
							map = initMap(model,15,mapTypeId);
				
							markers = helpers.printMarkes(model,map);
   
                            sandbox.listen({
                                'mapResize' : function(){
                                    google.maps.event.trigger(map, 'resize');
                                }
                            });
                        }
                    });
                }
       }

        function destroy() {

        }

        return {
            init:init,
			helper: helper,
			initMap: initMap,
            destroy:destroy,
            initPlaceDetails:initPlaceDetails
            
        }
    }
});
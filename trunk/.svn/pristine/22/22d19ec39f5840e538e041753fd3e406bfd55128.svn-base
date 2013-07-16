mno.core.register({
    id:'widget.eventPlaceDetails.default',
    extend:['widget.moodboard.default'],
    wait: [],
    creator:function (sandbox) {
        var runMoodBoardInit;
        function init(){
            if (sandbox.container) {
                var runInitPlaceDetails = this.initPlaceDetails;
                runMoodBoardInit = this.initMoodBoard;
                runInitPlaceDetails(sandbox, sandbox.container, sandbox.model[0]);

				/** map init **/
				sandbox.getScript({
					url: 'http://maps.google.com/maps/api/js?sensor=false&async=2&v=3',
					callbackVar: 'callback',
					jsonP: function () {
						sandbox.notify({
							type: 'gapiReady',
							data: true
						});
					}
				});

				sandbox.listen({
					'gapiReady': function () {
						initMap(sandbox.model[0]);
					}
				});
				
            }
            else {
                console.log('************ evtPlaceDetails/default.js not initialized************');
            }
			
			
			function createMap(data, mapCanvas) {
			console.log(data);
				try {
					/* set map options */
					var myOptions = {
						zoom: 12,
						/* set the first cordinate as center of map */
						center: new google.maps.LatLng(data.positionData[0].point.lat, data.positionData[0].point.lng),
						mapTypeId: google.maps.MapTypeId.ROADMAP,
						mapTypeControl: true,
						streetViewControl: false,
						mapTypeControlOptions: {
							mapTypeIds: [
								google.maps.MapTypeId.ROADMAP,
								google.maps.MapTypeId.SATELLITE,
								google.maps.MapTypeId.TERRAIN,
								google.maps.MapTypeId.HYBRID
							],
							position: google.maps.ControlPosition.TOP_RIGHT,
							style: google.maps.MapTypeControlStyle.DROPDOWN_MENU
						}
					};
					
					return new google.maps.Map(mapCanvas, myOptions);
				} catch (e) {
					mno.core.log(3, "widgets/eventDetails/allInformation.js at initMap stack" + e.stack);
				}
			}
			
			function createMarker(data, map) {
				try {

					var latlng = new google.maps.LatLng(data.positionData[0].point.lat, data.positionData[0].point.lng);

					var marker = new google.maps.Marker({
						position: latlng,
						map: map,
						title: data.placeName
					});
					return marker;
				} catch (e) {
					/* use core log 1 = log 2 = warn 3 = error */
					mno.core.log(3, "widgets/eventDetails/allInformation.js at printmarkers stack" + e.stack);
				}
			}
			
			function initMap(model) {
			
				var	map,
					firstPlace,
					positionData = [],
					point = {};
					
				point.lat = model.placeGeoLatitude;
				point.lng = model.placeGeoLongitude;

				positionData[0] = {};
				positionData[0].point = point;
				model.positionData = positionData;
				firstPlace = document.getElementById('map_canvas');
				
				map = createMap(model, firstPlace);
				marker = createMarker(model, map);
				
				sandbox.listen({
					'mapResize': function () {
						google.maps.event.trigger(map, 'resize');
					}
				});
				
			
			}
        }

        function initPlaceDetails( sandbox, container, model) {
            var placeID = parseInt(model.placeId,10);

            /*extend model with fields necessary for userrating*/
            model['groupid'] = setGroupId(model);
            model['template'] = 'widgets.moodboard.views.userrating';
            model['scale'] = 6;
            model['siteId'] = 'OsloBy';
            model['objectId'] =  placeID;
            runMoodBoardInit(sandbox,model, container.find('div#rating'));
        }

        function destroy() {

        }

        function setGroupId(model){
            if(model.categories == null || model.categories.length < 1){
                return 100;//100 for place with no category, 200 for event
            }

            for(var i=0; i< model.categories.length; i++){
               var categoriId = model.categories[i].categoryId;
                if(categoriId == '1'){ //Restaurant og cafè documentation: http://eventtest4.aftenposten.no/evt/json/placeCategories
                    return 1;
                }
            }
            return 100;
        }

        return {
            init:init,
            destroy:destroy,
            initPlaceDetails:initPlaceDetails
        }
    }
});
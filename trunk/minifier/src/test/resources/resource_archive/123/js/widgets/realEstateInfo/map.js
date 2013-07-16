mno.core.register({
    id:'widget.realEstateInfo.map',
    extend:['widget.realEstateInfo.common'],

    creator:function (sandbox) {

        function init() {
            if (sandbox.container) {
                // loop through instances of the widget
                this.getData(function (objData) {

                    sandbox.container.each(function (widgetIndex, element) {
                        // assign locally a model variable for the current instance
                        var model = sandbox.model[widgetIndex];
                        var props = objData.properties;

                        var $mapElement = $(element);
                        var $mapContainer = $mapElement.find('.mapContainer');

                        /*if (props.address1 && props.addressPostcode && props.postalName) {
                            $mapElement.children('header').html('<h3>' + props.address1 + ', ' + props.addressPostcode + ' ' + props.postalName + '</h3>');
                        }*/

                        if (props['geoLocation.latitude'] && props['geoLocation.longitude']) {
                            var mapBox = new mapRender(props['geoLocation.latitude'], props['geoLocation.longitude'], 13, $mapContainer.get(0), props.heading);
                            $mapContainer.css('display', 'block');
                            mapBox.showMap;
                        } else {
                            $mapContainer.remove();
                        }

                    });


                    function mapRender(mapLat, mapLng, mapZoom, mapElement, mapDescription) {
                        var that = this;
                        this.mapLat = mapLat || -34.397;
                        this.mapLng = mapLng || 150.644;
                        this.mapZoom = mapZoom || 16;
                        this.mapElement = mapElement || element;
                        this.mapDescription = mapDescription || 'Default localization';

                        this.mapLatLng = new google.maps.LatLng(this.mapLat, this.mapLng);

                        this.mapMarker = new google.maps.Marker({
                            position:that.mapLatLng,
                            title:that.mapDescription
                        });

                        this.mapOptions = {
                            zoom:this.mapZoom,
                            center:this.mapLatLng,
                            scrollwheel: false,
                            mapTypeId:google.maps.MapTypeId.ROADMAP
                        };

                        this.mapInitialize = function () {
                            var map = new google.maps.Map(that.mapElement, that.mapOptions);
                            that.mapMarker.setMap(map);
                        };

                        this.showMap = this.mapInitialize();
                    }
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
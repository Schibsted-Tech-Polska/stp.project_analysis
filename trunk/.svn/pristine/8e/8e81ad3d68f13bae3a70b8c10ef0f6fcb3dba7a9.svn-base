mno.core.register({
    id:'widget.propertyAds.ad',
    extend:['mno.utils.rubrikk'],
    creator: function (sandbox) {
        var $ = sandbox.$;
        var that = this;

        function formatCurrency(num) {
            num = Math.floor(num * 100 + 0.50000000001);
            num = Math.floor(num / 100).toString();
            for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
                num = num.substring(0, num.length - (4 * i + 3)) + '.' + num.substring(num.length - (4 * i + 3));
            return(num);
        }

        function formatDate(pDate) {
            var m_names = new Array("januar", "februar", "mars", "april", "mail", "juni", "juli", "august", "september", "oktober", "november", "desember");

            var month = parseInt(pDate.substring(5, 7), 10);
            var day = parseInt(pDate.substring(8, 10), 10);

            return day + ". " + m_names[month - 1];
        }

        function callback(data) {
            var adBean = data.message.success && typeof data.message.records !== "undefined";

            if (adBean !== false && data.message.records.length > 0) {
                adBean = data.message.records[0];
                var mobile = (sandbox.model[0].isMobile==true) ? 'MOBILE_':'';
                var imgWidth = (sandbox.model[0].isMobile==true) ? sandbox.model[0].max_image_width:466;
                var mainImage = "";
                var isWide = false;
                var otherImagesArr = [];
                var propertyImages = adBean.propertyImages;
                for(var i = 0; i < propertyImages.length; i++){
                    var adPic = propertyImages[i];
                    if(adPic.imageType.propertyImageTypeValue == "COMPLETE_AD_IMAGE"){
                        if(adPic.isAspectRatioWidth){
                            isWide = true;
                        }
                        mainImage = adPic.imagePath;
                    } else if(adPic.imageType.propertyImageTypeValue != "COMPLETE_AD_IMAGE" && adPic.imageType.propertyImageTypeValue != "EXTRACTED_HIDDEN_IMAGE"){
                        otherImagesArr.push(adPic.imagePath);
                    }
                }
                var address = adBean.address;
                var streetaddress = address.addressLine1;
                if(address.addressLine2 && address.addressLine2 != ""){
                    if(address.addressLine2 != address.postNumber.city) streetaddress += " " + address.addressLine2;
                }
                var postaddress = address.postNumber.postNumberName + " " + address.postNumber.city;
                var price = (adBean.salesPrice !== undefined) ? formatCurrency(adBean.salesPrice) : '';
                var monthlyCost = (adBean.monthlyCost !== undefined) ? formatCurrency(adBean.monthlyCost) : '';
                var size = adBean.sizeLivingArea;
                var rooms = adBean.noOfRooms;
                var finnlink = adBean.externalAdReference;
                var published = true;
                if (adBean.status != 'PUBLISHED')
                    published = false;
                var viewings = [];
                var propertyViewings = adBean.propertyViewings;
                if (propertyViewings && propertyViewings.length > 0) {
                    for (var j = 0; j < propertyViewings.length; j++)
                        viewings.push(formatDate(propertyViewings[j].viewingDate));
                }
                var companyUrl, logo, phone, phone2,email;
                var company = adBean.company;
                var companyName = company.name;
                if(company.phone)
                    phone = company.phone;
                if(company.phone2)
                    phone2 = company.phone2;
                if(company.email)
                    email = company.email;
                if(company.url)
                    companyUrl = company.url;
                var hasLogo = false;
                for(var k = 0; k > company.companyLogos.length; k++){
                    logo = company.companyLogos[k];
                    hasLogo = true;
                }
                var adclicktag = adBean.adClickTag.xmlCDataContent;

                var item = {
                    mainImage: mainImage,
                    otherImages: otherImagesArr,
                    hasLogo: hasLogo,
                    logo: logo,
                    companyName: companyName,
                    companyUrl: companyUrl,
                    adclicktag: adclicktag,
                    finnlink: finnlink,
                    rooms: rooms,
                    size: size,
                    phone: phone,
                    phone2: phone2,
                    email: email,
                    viewings: viewings,
                    published: published,
                    price: price,
                    monthlyCost: monthlyCost,
                    streetaddress: streetaddress,
                    postaddress: postaddress,
                    lisaLevel: this.lisaLevel,
                    imgWidth: imgWidth
                };

                if (sandbox.container) {
                    sandbox.render('widgets.propertyAds.views.ad', item, function (html) {
                        sandbox.container.empty();
                        sandbox.container.append(html);
                        if(adBean.longitude && adBean.latitude){
                            initMap(sandbox.container.find('.adMap')[0], adBean.longitude, adBean.latitude, streetaddress);
                        }
                    });
                }

            }
        }

        function initMap(mapContainer, lng, lat, address){
            if (typeof google === 'undefined') {
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
                        initMap(mapContainer, lng, lat, address);
                    }
                });
            } else {

                var map = createMap(lat, lng, 15, google.maps.MapTypeId.ROADMAP, mapContainer);
                placeCurrentAdMarker(map, lat, lng, address);
            }
        }

        function createMap(lat, lng, zoomLevel,mapTypeId, element){
            try{
                /* set map options */
                var myOptions = {
                    zoom: zoomLevel,
                    center: new google.maps.LatLng(lat, lng),
                    mapTypeId: mapTypeId/*google.maps.MapTypeId.ROADMAP*/,
                    mapTypeControl: true,
                    streetViewControl: true,
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
                mno.core.log(3,"widgets/propertyAds/ad.js at createMap stack" + e.stack);
            }
        }

        function placeCurrentAdMarker(map, lat, lng, content){
            var g = google.maps;
            var ll = new g.LatLng(lat, lng);
            var image = new g.MarkerImage(sandbox.publication.url+"skins/publications/ap/gfx/icons/mapBlueMarker.png");
            var marker = new g.Marker({
                position: ll,
                icon: image,
                map: map,
                draggable:false
            });
            var infowindow = new g.InfoWindow();
            infowindow.setContent(content);
            infowindow.open(map, marker);

            g.event.addListener(marker, 'click', function() {
                infowindow.open(map,marker);
            });
        }

        cbPropertyAd = function(data) {
            callback.call(that.instance, data);
        };

        function init() {
            if (sandbox.container) {
                var params = mno.utils.params,
                   jsonUrl = 'propertyad.json?renderType=public&propertyAdId=' + params.getParameter('propertyAdId') + '&cb=cbPropertyAd',
                   wholeUrl = this.rubrikkCacheUrl + jsonUrl;
                if (params.getParameter('rnd')) {
                    wholeUrl = wholeUrl + '&rnd=' + params.getParameter('rnd');
                }
                sandbox.getScript({
                    url:wholeUrl
                });
            }
        }

        function destroy() {

        }

        return {
            init:init,
            destroy:destroy
        };
    }
});
mno.core.register({
	id: 'widget.eventPlaceSearch.resultsTable',
	extend: ['widget.moodboard.default', 'widget.eventPlaceSearch.main'],
	wait: [],
	creator: function (sandbox) {
        var that = this.instance,
            currentPageIndex = 0;

        /* pagination initialization */
        function initPagination(data) {
            var count = Math.ceil(data / 10),
                item = {
                    data:[],
                    count:count
                },
                rightAdded = false,
                leftAdded = false;

            for (var pc = 0; pc < count; pc += 1) {

                /** first 6 and last 6 counters visible + first & last items always visible + elem +- 2 visible **/
                if (((pc < 6 && currentPageIndex < 4) || pc === 0) ||
                    ((pc > count - 7 && currentPageIndex > count - 5) || pc === count - 1) ||
                    (currentPageIndex >= pc - 2 && currentPageIndex <= pc + 2)) {

                    item.data.push({
                        label:pc+1,
                        name:pc,
                        selected: pc === currentPageIndex
                    });
                } else if (pc + 2 > currentPageIndex && !rightAdded) {
                    rightAdded = true;
                    item.data.push({
                        label:'&hellip;',
                        selected:false
                    });
                } else if (pc - 2 < currentPageIndex && !leftAdded) {
                    leftAdded = true;
                    item.data.push({
                        label:'&hellip;',
                        selected:false
                    });
                }
            }

            sandbox.render('widgets.eventPlaceSearch.views.pagination', item, function(html) {
                html.find('button').on('click', function (){
                    var $this = $(this);

                    if ($this.hasClass('nextPage') && currentPageIndex < count - 1) {
                        currentPageIndex += 1;
                    } else if ($this.hasClass('prevPage') && currentPageIndex > 0) {
                        currentPageIndex -= 1;
                    } else if (currentPageIndex !== $this.attr('data-name')) {
                        currentPageIndex = parseInt($(this).attr('data-name'),10);
                    } else {
                        return false;
                    }

                    that.updateSearch(sandbox.model[0].jsonURLFeed_FindRestaurant, {
                        resultsIndex: currentPageIndex
                    })
                });
                sandbox.container.find('.pagination').empty().append(html);
            });
        }

        if (sandbox.container) {
            sandbox.container.each(function (widgetIndex, element) {

                var model = sandbox.model[widgetIndex],
                    $this = $(this);

                sandbox.listen({
                    'eventPlaceSearch-search':function (data) {
                        var cache,
                            placesIds = [];

                        for (var i = 0;data[i]; i++) {
                            placesIds.push(data[i].id);
                            data[i].link = model['external_references_place_link'] + 'article' + data[i].articleId + '.ece';

                            for (var j = 0; data[i].featureValues[j]; j++) {
                                cache = data[i].featureValues[j];
                                if (cache.feature.id === 4) {
                                    data[i].priceClass = cache.value;
                                }
                                if (cache.value === 'recommended') {
                                    data[i].recommended = true;
                                }
                            }

                            if (data[i].multimediaId !== null) {
                                data[i].image = model.imagesUrl + data[i].multimediaId;
                            }

                        }
                        sandbox.render('widgets.eventPlaceSearch.views.tiledEvtSearchResults', data, function (html) {
                            $this.find('.result').empty().append(html);
                            /** rates init **/
                            model.placesIds = placesIds;
                            initRatesDetails.call(that,sandbox);
                        });
                    },
                    'eventPlaceSearch-searchQuery': function (data) {
                        sandbox.getScript({
                            url: that.constructSearchUrl(data, model.jsonURLFeed_CountRestaurants),
                            callbackVar: 'callback',
                            reload: true,
                            jsonP: function (data) {
                                initPagination(data)
                            }
                        });
                    }
                });



            });
        }
        function init() {
            var resultsPerPage = 10; // TODO
        }
		function initold() {

			if (sandbox.container) {
				runMoodBoardInit = this.initMoodBoard;

				var that = this,
					mapLoaded = false,
					showMap = false,
					reloadMap = true,
					$evtResultsTable,
					URLBase,
					PCURLBase,
					countRestaurantsURL,
					findRestaurantURL,
					currentPageIndex = 0,
					dataToRemember = {
						textToFind: '',
						cuisineToFind: [-1],
						priceToFind: [-1],
						resultsPerPage: 10,
						resultsIndex: 0,
						featuresToFind: [-1]
					};

				sandbox.container.each(function (widgetIndex, element) {

					var model = sandbox.model[widgetIndex];

					URLBase = model.jsonURLFeed_FindRestaurant + '?';
					PCURLBase = model.jsonURLFeed_CountRestaurants + '?';

					$evtResultsTable = $('#' + model.eventPlaceSearchWidgetId);

					/* tab navigation - list and map view */
					$evtResultsTable.find('.tab').click(function (event) {

						if ($(this).hasClass('listTab')) {
						/* list tab clicked */
							showMap = false;
							$evtResultsTable.find('.listView').css('display', 'block');
							$evtResultsTable.find('.mapView').css('display', 'none');
							$evtResultsTable.find('.pagination').css('display', 'block');
							$evtResultsTable.find('.mapTab').removeClass('selected');
							$evtResultsTable.find('.listTab').addClass('selected');
							mno.utils.form.select($evtResultsTable, true);
						} else {
						/* map tab clicked */
							showMap = true;
							$evtResultsTable.find('.mapView').css('display', 'block');
							$evtResultsTable.find('.listView').css('display', 'none');
							$evtResultsTable.find('.pagination').css('display', 'none');
							if (!that.mapLoaded) {
								prepareMapScript(that);
							}
							$evtResultsTable.find('.listTab').removeClass('selected');
							$evtResultsTable.find('.mapTab').addClass('selected');
							if (reloadMap) {
								makeSearch(dataToRemember);
								reloadMap = false;
							}
						}
					});

					/* results list initialization */
					if (window.location.hash !== '') {
						dataToRemember = decodeHash(dataToRemember, window.location.hash);
					}
					makeSearch(dataToRemember);

					/* results per page selector */
					$evtResultsTable.find('.itemsPerPage').on('change', function (event) {
						makeSearch(dataToRemember);
					});
					
					/* refine search listener */
					sandbox.listen({
						'eventPlaceSearch-makeRefineSearch': function (data) {
							makeSearch(data);
						}
					});

					/* advanced search listener */
					sandbox.listen({
						'eventPlaceSearch-makeSearch': function (data) {
							makeSearch(data);
						}
					});
				});
			}

			/* additional functions */
			function prepareHash(data) {

				var hash = '';
				if(data.textToFind.length > 0) {
					hash += 'textToFind=' + encodeURI(data.textToFind) + '|';
				}
				if(data.cuisineToFind.length > 0) {
					hash += 'cuisineToFind=' + data.cuisineToFind.join(',') + '|';
				}	
				if(data.priceToFind.length > 0)	{
					hash += 'priceToFind=' + data.priceToFind.join(',') + '|';
				}	
				if(data.featuresToFind.length > 0)	{
					hash += 'featuresToFind=' + data.featuresToFind.join(',') + '|';
				}
				if(data.resultsPerPage.length > 0)	{
					hash += 'resultsPerPage=' + data.resultsPerPage + '|';
				}
				if(data.resultsIndex.length > 0)	{
					hash += 'resultsIndex=' + data.resultsIndex.join(',') + '|';
				}
				
				return encodeURI(hash);
			}

			function decodeHash(returnObject, hash) {
				var tmpArray = [];

				hash = hash.substring(2);
				
				tmpArray = getUrlVars(hash);
				if(tmpArray.hasOwnProperty('textToFind')) {
					returnObject.textToFind = decodeURI(tmpArray.textToFind);
				}			
				if(tmpArray.hasOwnProperty('cuisineToFind')) {
					returnObject.cuisineToFind = tmpArray.cuisineToFind.split(',');
				}
				if(tmpArray.hasOwnProperty('priceToFind')) {
					returnObject.priceToFind = tmpArray.priceToFind.split(',');
				}
				if(tmpArray.hasOwnProperty('featuresToFind')) {
					returnObject.featuresToFind = tmpArray.featuresToFind.split(',');
				}
				if(tmpArray.hasOwnProperty('resultsPerPage')) {
					returnObject.resultsPerPage = tmpArray.resultsPerPage;
				}
				if(tmpArray.hasOwnProperty('resultsIndex')) {
					returnObject.resultsIndex = tmpArray.resultsIndex;
				}
				return returnObject;
			}
			
			function getUrlVars(hashedParams)
			{
				var decodedURL = decodeURI(hashedParams);
				var vars = [], hash;
				var hashes = decodedURL.slice(decodedURL.indexOf('?') + 1).split('|');
				for(var i = 0; i < hashes.length; i++)
				{
					hash = hashes[i].split('=');
					vars.push(hash[0]);
					vars[hash[0]] = hash[1];
				}
				return vars;
			}

			function loadMapData(data) {
				sandbox.model[0].places = data;
				if (that.mapLoaded) {
					mapHelper(sandbox);
				}
			}
			
			/* search function */
			function makeSearch(data) {

				var resultsPerPage = $evtResultsTable.find('.itemsPerPage').val();

				$evtResultsTable.find('.mapView').empty();
				$evtResultsTable.find('.placeSearchResult').empty();

				dataToRemember = data;
				
				if(showMap) {
					dataToRemember.resultsPerPage = -1;
					findRestaurantURL = prepareJsonUrl(dataToRemember, URLBase);
					findRestaurantURL += '&sortByColumn=distance';
					sandbox.getScript({
						url: findRestaurantURL,
						callbackVar: 'callback',
						reload: true,
						jsonP: loadMapData
					});
				}	
				
				dataToRemember.resultsPerPage = resultsPerPage;
				findRestaurantURL = prepareJsonUrl(dataToRemember, URLBase);
				countRestaurantsURL = prepareJsonUrl(dataToRemember, PCURLBase);

				sandbox.getScript({
					url: countRestaurantsURL,
					callbackVar: 'callback',
					reload: true,
					jsonP: initPagination
				});
				
				sandbox.getScript({
					url: findRestaurantURL,
					callbackVar: 'callback',
					reload: true,
					jsonP: loadData
				});
				
				reloadMap = true;
				
				window.location.hash = '##' + prepareHash(dataToRemember);
						
			}

			

			/* loading results table */
			function loadData(data) {

				if (data !== undefined) {				
					var results = {},
						i,
						j,
						len,
						placesCount = data.length,
						placesIds = '',
						dataToShow = [],
						item = {},
						priceClass = '',
						recommended = false,
						featureValue,
						imageLink;

					if (placesCount > 0) {

						for (i = 0; i < placesCount; i += 1) {
							item = {};

							placesIds += data[i].id;
							if (i + 1 < placesCount) {
								placesIds += ',';
							}

							/******************* informationPart ************************/
							item.place_link = sandbox.model[0].external_references_place_link + 'article' + data[i].articleId + '.ece';
							item.name = data[i].name;
							item.articleId = data[i].articleId;
							item.categories = data[i].cousine.join(", ");
							item.place = '';

							if (data[i].streetAddress !== null) {
								item.place += data[i].streetAddress;
							}
							if (data[i].zipCode !== null) {
								item.place += ', ' + data[i].zipCode;
							}
							if (data[i].city !== null) {
								item.place += ' ' + data[i].city;
							}

							/** rates div **/
							item.rating_id = 'rating_' + data[i].id;
							priceClass = '';
							recommended = false;

							for (j = 0, len = data[i].featureValues.length; j < len; j += 1) {
								featureValue = data[i].featureValues[j];
								if (featureValue.feature.id === 4) {
									priceClass = featureValue.value;
								}
								if (featureValue.value === 'recommended') {
									recommended = true;
								}
							}

							item.priceClass = priceClass;
							item.recommended = recommended;

							/******************* imagePart ************************/
							if (data[i].multimediaId !== null) {

								imageLink = sandbox.model[0].imagesUrl + data[i].multimediaId + '&width=150';
								item.image = '<img src="' + imageLink + '" />';
							}

							dataToShow.push(item);
						}

						sandbox.render('widgets.eventPlaceSearch.views.tiledEvtSearchResults', dataToShow, function (html) {

							$('.placeSearchResult').html(html);
							/** rates init **/
							sandbox.model[0].placesIds = placesIds;
							initRatesDetails(sandbox, sandbox.container, sandbox.model[0]);
						});

					} else {
						$('.placeSearchResult').append('No results :(');
					}

					$evtResultsTable.find('.results').css('display', 'block');
					if ($evtResultsTable.find('.listTab').hasClass('selected')) {
						$evtResultsTable.find('.listView').css('display', 'block');
					}
				} 

				mno.utils.form.select($evtResultsTable, true);
			}

			/* preparing json link */
			function prepareJsonUrl(data, baseURL) {

				var resultsJsonURL = baseURL,
					i,
					len;

				len = data.cuisineToFind.length;
				for (i = 0; i < len; i += 1) {
					if (data.cuisineToFind[i] !== '-1' && data.cuisineToFind[i] !== -1) {
						resultsJsonURL += 'featureValueId=' + data.cuisineToFind[i] + '&';
					}
				}

				len = data.priceToFind.length;
				for (i = 0; i < len; i += 1) {
					if (data.priceToFind[i] !== '-1' && data.priceToFind[i] !== -1) {
						resultsJsonURL += 'featureValueId=' + data.priceToFind[i] + '&';
					}
				}

				len = data.featuresToFind.length;
				for (i = 0; i < len; i += 1) {
					if (data.featuresToFind[i] !== '-1' && data.featuresToFind[i] !== -1) {
						resultsJsonURL += 'featureValueId=' + data.featuresToFind[i] + '&';
					}
				}

				resultsJsonURL += 'text=' + data.textToFind + '&';
				resultsJsonURL += 'firstIndex=' + data.resultsIndex * data.resultsPerPage + '&';
				if(data.resultsPerPage !== -1)
					resultsJsonURL += 'count=' + data.resultsPerPage;

				return resultsJsonURL;
			}

			/* pagination initialization */
			function initPagination(data) {

				var resultsPerPage = $evtResultsTable.find('.itemsPerPage').val(),
					pagesCounterHtml = '',
					placesCount = data,
					$pagesList = $('.pagesList'),
					label = '',
					pagesCount = Math.ceil(placesCount / resultsPerPage),
					rightAdded = false,
					leftAdded = false,
					pc;

				$('.resultsCount').html(placesCount + ' results found.');

				/* creating pagination html */
				$pagesList.html('');
				$pagesList.append('<li class="prevPage navBtn"><a>&#171;</a></li>');

				for (pc = 0; pc < pagesCount; pc += 1) {

					/** first 6 and last 6 counters visible + first & last items always visible + elem +- 2 visible **/
					if (((pc < 6 && currentPageIndex < 4) || pc === 0) ||
							((pc > pagesCount - 7 && currentPageIndex > pagesCount - 5) || pc === pagesCount - 1) ||
							(currentPageIndex >= pc - 2 && currentPageIndex <= pc + 2)) {

						label = pc + 1;
						pagesCounterHtml += '<li class="pageIndex navBtn ';

						if (pc === currentPageIndex) {
							pagesCounterHtml += 'selected';
						}
						pagesCounterHtml += '" name="' + pc + '"><a>' + label;
						pagesCounterHtml += '</a></li>';

					} else if (pc + 2 > currentPageIndex && !rightAdded) {
						rightAdded = true;
						pagesCounterHtml += '<li>&hellip;</li>';
					} else if (pc - 2 < currentPageIndex && !leftAdded) {
						leftAdded = true;
						pagesCounterHtml += '<li>&hellip;</li>';
					}
				}

				$pagesList.append(pagesCounterHtml);
				$pagesList.append('<li class="nextPage navBtn"><a>&#187;</a></li>');

				/* adding click event to buttons */
				$pagesList.find('.navBtn').click(function (event){
					if ($(this).hasClass('nextPage') && currentPageIndex < pagesCount - 1) {
						currentPageIndex += 1;
						dataToRemember.resultsIndex = currentPageIndex;
						makeSearch(dataToRemember);
					} else if ($(this).hasClass('prevPage') && currentPageIndex > 0) {
						currentPageIndex -= 1;
						dataToRemember.resultsIndex = currentPageIndex;
						makeSearch(dataToRemember);
					} else if ($(this).hasClass('pageIndex') && currentPageIndex !== $(this).attr('name')) {
						currentPageIndex = parseInt($(this).attr('name'));
						dataToRemember.resultsIndex = currentPageIndex;
						makeSearch(dataToRemember);
					}
				});
			}

			/* map initialization functions */
			function prepareMapScript(that) {

				/** map view init **/
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
						that.mapLoaded = true;
						dataToRemember.resultsPerPage = -1;
						findRestaurantURL = prepareJsonUrl(dataToRemember, URLBase);
						sandbox.getScript({
							url: findRestaurantURL,
							callbackVar: 'callback',
							reload: true,
							jsonP: loadMapData
						});
					}
				});
			}
			
			function mapHelper(sandbox) {

				var model = sandbox.model[0],
					map,
					firstPlace = model.places[0],
					positionData = [],
					point = {};

				if (model !== null) {
					if (firstPlace !== undefined) {
						point.lat = firstPlace.geoLatitude;
						point.lng = firstPlace.geoLongitude;
					} else {
						point.lat = 59.91515;
						point.lng = 10.7369;
					}

					positionData[0] = {};
					positionData[0].point = point;
					model.positionData = positionData;

					map = initMap(model, $evtResultsTable.find('.mapView')[0]);
					markers = initMarkers(model, map);

					sandbox.listen({
						'mapResize': function () {
							google.maps.event.trigger(map, 'resize');
						}
					});
				}
			}

			function initMarkers(data, map) {
				try {

					var latlng,
						markers = [],
						markersFromJson = data.places,
						content;
					var prev_infowindow =false;
					jQuery.each(markersFromJson, function (i, item) {

						latlng = new google.maps.LatLng(item.geoLatitude, item.geoLongitude);

						content = '<div class="place_det">';

						if (item.streetAddress !== null) {
							content += item.streetAddress;
						}
						if (item.zipCode !== null) {
							content += ', ' + item.zipCode;
						}
						if (item.city !== null) {
							content += ' ' + item.city;
						}

						content += '</div> ';

						var marker = new google.maps.Marker({
							position: latlng,
							map: map,
							title: item.name
						});

						var infowindow = new google.maps.InfoWindow({
							content: '<div>' + item.name + '</div>' + content
						});
						google.maps.event.addListener(marker, 'click', function () {
							if(prev_infowindow) {
								prev_infowindow.close();
							}
							prev_infowindow = infowindow;
							infowindow.open(map, marker);
						});

						markers.push(marker);
					});
					return markers;
				} catch (e) {
					/* use core log 1 = log 2 = warn 3 = error */
					mno.core.log(3, "widgets/eventDetails/allInformation.js at printmarkers stack" + e.stack);
				}
			}
			
			function initMap(data, mapCanvas) {

			try {

				/* set map options */
					var myOptions = {
						zoom: 15,
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
		}

		/* rates initializer */
		function initRatesDetails(sandbox) {
            var model = sandbox.model[0],
                that = this;
			jQuery.each(model.placesIds, function (j) {
				var placeID = model.placesIds[j];//parseInt(model.eventId,10);
				model.groupid = 1; //1 for place, 2 for event
				model.template = 'widgets.moodboard.views.rates';
				model.scale = 6;
				model.siteId = 'OsloBy';
				model.objectId = placeID;

				that.initMoodBoard(sandbox, model, sandbox.container.find('div#rating_' + placeID));
			});
		}

		function destroy() {}

		return {
			init: init,
			destroy: destroy,
			initRatesDetails: initRatesDetails
		};
	}
});
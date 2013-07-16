mno.core.register({
    id: 'widget.eventPlaceSearch.advancedSearch',
    creator: function (sandbox) {

        function init() {
            var that = this;
            if (sandbox.container) {
				var dataToRemember = {
                        textToFind: '',
                        cuisineToFind: ['-1'],
                        priceToFind: ['-1']
                    },
					jsonRestaurantFeaturesURL,
					restaurantFeatures,
					priceClasses,
					dataToBrowserBar = '',
					$evtAdvSearch;

                sandbox.container.each(function (widgetIndex, element) {
                    $evtAdvSearch = $('#' + sandbox.model[widgetIndex].eventPlaceSearchWidgetId);

                    $evtAdvSearch.submit(function (event) {
                        event.preventDefault();

                        dataToRemember.textToFind = stripTags($evtAdvSearch.find('.evtAdvTextField').val());
						dataToRemember.cuisineToFind = [$evtAdvSearch.find('.evtAdvCuisineTypes').val()];
						dataToRemember.priceToFind = [$evtAdvSearch.find('.evtAdvPriceClass').val()];
						
						dataToBrowserBar = prepareHash(dataToRemember);

						if (sandbox.model[widgetIndex].destinationURL === 'true') {
                            window.location.href = sandbox.model[widgetIndex].searchResultsSectionURL + '##' + dataToBrowserBar;
                        } else {
                            window.location.hash = '##' + dataToBrowserBar;
                        }


                        sandbox.notify({
                            type: 'eventPlaceSearch-makeSearch',
                            data: dataToRemember
                        });
                    });

                    /**
                     * Part responsible for getting restaurant features lists
                     */
					jsonRestaurantFeaturesURL = sandbox.model[widgetIndex].jsonURLFeed_RestaurantFeatures;
					sandbox.getScript({
						url: jsonRestaurantFeaturesURL,
						callbackVar: 'callback',
						reload: true,
						jsonP: getRestaurantFeatures
					});
                });
            }

			/**
			 * Function to get restaurant features list
			 * @param data
			 */
			function getRestaurantFeatures(data) {

				if (data !== null) {
					var i, len, result;
					for (i = 0, len = data.length; i < len; i += 1) {
						/** hardcoded id of cuisine feature and price class feature**/
						if (data[i].id === 3) {
							restaurantFeatures = data[i].values;
						} else if (data[i].id === 4) {
							priceClasses =  data[i].values;
						}
					}
					/** setting cuisines **/
					result = '<option value="-1">Alle kjøkken</option>';
					for (i = 0, len = restaurantFeatures.length; i < len; i += 1) {
						result += '<option value="' + restaurantFeatures[i].id + '">' + restaurantFeatures[i].value + '</option>';
					}
					$evtAdvSearch.find('.evtAdvCuisineTypes').html(result);
					$evtAdvSearch.find('.evtAdvCuisineTypes').change();
					/** setting price classes **/
					result = '<option value="-1">Alle prisnivå</option>';
					for (i = 0, len = priceClasses.length; i < len; i += 1) {
						result += '<option value="' + priceClasses[i].id + '">' + priceClasses[i].value + '</option>';
					}
					$evtAdvSearch.find('.evtAdvPriceClass').html(result);
					$evtAdvSearch.find('.evtAdvPriceClass').change();
					mno.utils.form.select($evtAdvSearch, true);
				}

				if (window.location.hash !== '') {
					dataToRemember = decodeHash(window.location.hash);
					selectValues(dataToRemember);
				}
			}

            function stripTags(data) {
                return data.replace(/<\w+(\s+("[^"]*"|'[^']*'|[^>])+)?>|<\/\w+>/gi, '');
            }

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
				
				return encodeURI(hash);
			}

			function decodeHash(hash) {
				var dataToSearch = {}, tmpArray = [];
				hash = hash.substring(2);
				tmpArray = getUrlVars(hash);
				if(tmpArray.hasOwnProperty('textToFind')) {
					dataToSearch.textToFind = decodeURI(tmpArray.textToFind);
				}			
				if(tmpArray.hasOwnProperty('cuisineToFind')) {
					dataToSearch.cuisineToFind = tmpArray.cuisineToFind.split(',');
				}
				if(tmpArray.hasOwnProperty('priceToFind')) {
					dataToSearch.priceToFind = tmpArray.priceToFind.split(',');
				}
				
				return dataToSearch;
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
			
			function selectValues(data) {
				$evtAdvSearch.find('.evtAdvTextField').val(data.textToFind);
				$evtAdvSearch.find('.evtAdvCuisineTypes option[value="' + data.cuisineToFind[0] + '"]').attr('selected', true);
				$evtAdvSearch.find('.evtAdvCuisineTypes').change();
				$evtAdvSearch.find('.evtAdvPriceClass option[value="' + data.priceToFind[0] + '"]').attr('selected', true);
				$evtAdvSearch.find('.evtAdvPriceClass').change();
			}
        }

        function destroy() {}

        return {
            init: init,
            destroy: destroy
        };
    }
});
mno.core.register({
	id: 'widget.eventPlaceSearch.refineSearch',
    wait: [],
    creator: function (sandbox) {
        function decodeHash(hash) {
            var tmpArray = [],
                featureIds;

            function addFeatureIds () {
                var args = Array.prototype.slice.call(arguments),
                    ret = [];

                for (var i = 0; args[i]; i++) {
                    for (var j = 0; args[i][j]; j++) {
                        if (args[i][j] !== -1) {
                            ret.push(args[i][j]);
                        }
                    }
                }
            }

            hash = hash.substring(2);
            tmpArray = decodeURI(decodeURI(hash)).split('|');

            return {
                text: tmpArray[0],
                featureIds: addFeatureIds(tmpArray[1].split(','), tmpArray[2].split(','),tmpArray[5].split(',')),
                resultsPerPage: tmpArray[3],
                resultsIndex: tmpArray[4]
            }
        }

        function prepareJsonUrl(data, baseURL) {
            var returnJsonURL = baseURL,
                len,
                i;

            len = data.cuisineToFind.length;
            for (i = 0; i < len; i += 1) {
                if (data.cuisineToFind[i] !== '-1' && data.cuisineToFind[i] !== -1) {
                    returnJsonURL += 'featureValueId=' + data.cuisineToFind[i] + '&';
                }
            }

            len = data.priceToFind.length;
            for (i = 0; i < len; i += 1) {
                if (data.priceToFind[i] !== '-1' && data.cuisineToFind[i] !== -1) {
                    returnJsonURL += 'featureValueId=' + data.priceToFind[i] + '&';
                }
            }

            len = data.featuresToFind.length;
            for (i = 0; i < len; i += 1) {
                if (data.featuresToFind[i] !== '-1' && data.cuisineToFind[i] !== -1) {
                    returnJsonURL += 'featureValueId=' + data.featuresToFind[i] + '&';
                }
            }

            returnJsonURL += 'text=' + data.textToFind + '&';

            return returnJsonURL;
        }

        function init() {
            var filters = {
                    text: '',
                    featureIds: [],
                    resultsPerPage: 10,
                    resultsIndex: 0
                },
                model;

            if (sandbox.container) {
                sandbox.container.each(function (widgetIndex, element) {
                    model = sandbox.model[widgetIndex];

                    console.log(filters);
                });
            }
        }

		function initOLD() {
			var numberOfTopElements = 10,
				selectedFilters = {
					textToFind: '',
					cuisineToFind: [-1],
					priceToFind: [-1],
					resultsPerPage: 10,
					resultsIndex: 0,
					featuresToFind: [-1]
				},
				URLBase,
				jsonURL,
				$evtRefSearch,
				showAllCuisines = false;

			if (sandbox.container) {
				sandbox.container.each(function (widgetIndex, element) {

					URLBase = sandbox.model[widgetIndex].jsonURLFeed_CountRestaurantsFeatures + '?';
					$evtRefSearch = $('#' + sandbox.model[widgetIndex].eventPlaceSearchWidgetId + '');
					
					if (window.location.hash !== '') {
						selectedFilters = decodeHash(selectedFilters, window.location.hash);
					}

					jsonURL = prepareJsonUrl(selectedFilters, URLBase);

					//showTop param for more/less link
					jsonURL += 'showTop=' + numberOfTopElements;
					sandbox.getScript({
						url: jsonURL,
						callbackVar: 'callback',
						reload: true,
						jsonP: loadFeaturesData
					});
					
					$evtRefSearch.find('.clearAllFilters').click(function (event){
						
						$evtRefSearch.find(':checkbox').each(function (){
							$(this).attr('checked', false);
						});
						
						selectedFilters.cuisineToFind = ['-1'];
						selectedFilters.priceToFind = ['-1'];
						selectedFilters.featuresToFind = ['-1'];
						
						window.location.hash = '##' + prepareHash(selectedFilters);

						jsonURL = prepareJsonUrl(selectedFilters, URLBase);
						jsonURL += 'showTop=' + numberOfTopElements;
					
						notifier(jsonURL);
					});
					

					/** listen for event from advanced search view **/
					sandbox.listen({
                        'eventPlaceSearch-makeSearch': function (data) {
							var query = '',
								jsonURL,
								len,
								i;

							selectedFilters.cuisineToFind = ['-1'];
							selectedFilters.priceToFind = ['-1'];

							len = data.cuisineToFind.length;
							for (i = 0; i < len; i += 1) {
								if (data.cuisineToFind[i] !== '-1') {
									if (selectedFilters.cuisineToFind.indexOf(data.cuisineToFind[i]) === -1) {
										selectedFilters.cuisineToFind.push(data.cuisineToFind[i]);
									}
								}
							}
						
							len = data.priceToFind.length;
							for (i = 0; i < len; i += 1) {
								if (data.priceToFind[i] !== '-1') {
									if (selectedFilters.priceToFind.indexOf(data.priceToFind[i]) === -1) {
										selectedFilters.priceToFind.push(data.priceToFind[i]);
									}
								}
							}


							if (data.hasOwnProperty('textToFind')) {
								query += 'text=' + data.textToFind + '&';
								selectedFilters.textToFind = data.textToFind;
							} else {
								query += 'text=&';
							}

							jsonURL = URLBase + query;

							sandbox.getScript({
								url: jsonURL,
								callbackVar: 'callback',
								reload: true,
								jsonP: loadFeaturesData
							});
						}
					});
				});
			}
			/* additional functions */
			function loadFeaturesData(data) {

				var i,
					len,
					commonFeatures = {
						values: []
					};

				if (data !== undefined) {
					for (i = 0, len = data.length; i < len; i += 1) {
						if (data[i].id === 3) {	/** hardcoded id of cuisine type feature **/
							generateCuisineTypes(data[i]);
						} else if (data[i].id === 4) {	/** hardcoded id of price class feature **/
							generatePriceClasses(data[i]);
						} else {
							for(var j = 0, len = data[i].values.length; j < len; j += 1) {
								commonFeatures.values.push(data[i].values[j]);
							}
						}
					}
					generateFeatures(commonFeatures);
				}
			}

			function generateCuisineTypes(data) {

				var $cusineTypesSection = $evtRefSearch.find('.rs_cusineTypes'),
					result = '<ul class="refCuisineTypesUl">',
					isChecked,
					isInTop,
					i,
					len;

				for (i = 0, len = data.values.length; i < len; i += 1) {

					isChecked = false;
					if (selectedFilters.cuisineToFind.indexOf(data.values[i].id.toString()) !== -1) {
						isChecked = true;
					}
					isInTop = false;
					if (data.values[i].position < numberOfTopElements) {
						isInTop = true;
					}
					
					result += '<li name="refCatLi_' + data.values[i].id + '"';
					if (!isInTop) {
						result += ' class="lowCounter"';
					}
					result += '>';
					result += '<input type="checkbox"';
					if (isChecked) {
						result += ' checked="checked" ';
					}
					result += '/>' + data.values[i].value + ' <span>(' + data.values[i].counter + ')</span>';
					result += '</li>';
				}

				result += '</ul>';
				if (showAllCuisines) {
					result += '<span class="showMoreLess less" name="low">Færre</span>';
				} else {
					result += '<span class="showMoreLess" name="top">Flere</span>';
				}				

				$cusineTypesSection.html(result);

				//hide low counter
				if (!showAllCuisines) {
					$cusineTypesSection.find('li').each(function () {
						if ($(this).hasClass('lowCounter')) {
							$(this).hide();
						}
					});
				}

				/** adding click on li element **/
				addOptionListener($cusineTypesSection, selectedFilters.cuisineToFind);

				$cusineTypesSection.find('.showMoreLess').click(function (event) {

					if ($(this).attr('name') === 'top') {
						$(this).attr('name', 'low');
						$(this).html('less');
						$(this).addClass('less');
						showAllCuisines = true;
						$cusineTypesSection.find('li').each(function () {
							if ($(this).hasClass('lowCounter')) {
								$(this).show();
							}
						});
					} else if ($(this).attr('name') === 'low') {
						$(this).attr('name', 'top');
						$(this).html('more');
						$(this).removeClass('less');
						showAllCuisines = false;
						$cusineTypesSection.find('li').each(function () {
							if ($(this).hasClass('lowCounter')) {
								$(this).hide();
							}
						});
					}
				});
			}

			function generatePriceClasses(data) {

				var $priceRangeSection = $evtRefSearch.find('.rs_priceRanges'),
					result = '<ul class="refPriceRangesUl">',
					isChecked,
					i,
					len;
				for (i = 0, len = data.values.length; i < len; i += 1) {

					isChecked = false;
					if (selectedFilters.priceToFind.indexOf(data.values[i].id.toString()) !== -1) {
						isChecked = true;
					}
					result += '<li name="refCatLi_' + data.values[i].id + '">';
					result += '<input type="checkbox"';
					if (isChecked) {
						result += ' CHECKED ';
					}
					result += '/>' + data.values[i].value + ' <span>(' + data.values[i].counter + ')</span>';
					result += '</li>';
				}

				result += '</ul>';
				$priceRangeSection.html(result);

				/** adding click on li element **/
				addOptionListener($priceRangeSection, selectedFilters.priceToFind);
			}

			function generateFeatures(data) {

				var $featuresSection = $evtRefSearch.find('.rs_features'),
					result = '<ul class="refFeaturesUl">',
					isChecked,
					i,
					len;

				for (i = 0, len = data.values.length; i < len; i += 1) {

					isChecked = false;
					if (selectedFilters.featuresToFind.indexOf(data.values[i].id.toString()) !== -1) {
						isChecked = true;
					}
					result += '<li name="refCatLi_' + data.values[i].id + '">';
					result += '<input type="checkbox"';
					if (isChecked) {
						result += ' CHECKED ';
					}
					result += '/>' + data.values[i].value + ' <span>(' + data.values[i].counter + ')</span>';
					result += '</li>';
				}

				result += '</ul>';
				$featuresSection.html(result);

				/** adding click on li element **/
				addOptionListener($featuresSection, selectedFilters.featuresToFind);
			}
			
			function addOptionListener($section, featuresValuesTable) {
			
				$section.find('li').click(function (event) {
					var $checkbox = $(this).children(':checkbox'),
						featureId,
						featuresJsonURL;

					if (event.target.type !== 'checkbox') {
						if ($checkbox.attr('checked')) {
							$checkbox.attr('checked', false);
						} else {
							$checkbox.attr('checked', true);
						}
					}

					$(this).removeClass('checked');
					featureId = $(this).attr('name').split('_')[1];

					if ($checkbox.attr('checked')) {
						featuresValuesTable.push(featureId);
						$(this).addClass('checked');
					} else {
						featuresValuesTable.splice(featuresValuesTable.indexOf(featureId), 1);
					}

					featuresJsonURL = prepareJsonUrl(selectedFilters, URLBase);
					notifier(featuresJsonURL);
				});
			}

			function notifier(featuresJsonURL) {

				selectedFilters.resultsPerPage = 10;
				selectedFilters.resultsIndex = 0;

				window.location.hash = '##' + prepareHash(selectedFilters);

				sandbox.notify({
					type: 'eventPlaceSearch-makeRefineSearch',
					data: selectedFilters
				});

				sandbox.getScript({
					url: featuresJsonURL,
					callbackVar: 'callback',
					reload: true,
					jsonP: loadFeaturesData
				});
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

			function decodeHash(dataToSearch, hash) {
				var tmpArray = [];
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
				if(tmpArray.hasOwnProperty('featuresToFind')) {
					dataToSearch.featuresToFind = tmpArray.featuresToFind.split(',');
				}
				if(tmpArray.hasOwnProperty('resultsPerPage')) {
					dataToSearch.resultsPerPage = tmpArray.resultsPerPage;
				}
				if(tmpArray.hasOwnProperty('resultsIndex')) {
					dataToSearch.resultsIndex = tmpArray.resultsIndex;
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

			/* preparing json link */
			function prepareJsonUrl(data, baseURL) {

				var returnJsonURL = baseURL,
					len,
					i;
				if(data.hasOwnProperty('cuisineToFind')) {
					len = data.cuisineToFind.length;
					for (i = 0; i < len; i += 1) {
						if (data.cuisineToFind[i] !== '-1' && data.cuisineToFind[i] !== -1) {
							returnJsonURL += 'featureValueId=' + data.cuisineToFind[i] + '&';
						}
					}
				}
				if(data.hasOwnProperty('priceToFind')) {
					len = data.priceToFind.length;
					for (i = 0; i < len; i += 1) {
						if (data.priceToFind[i] !== '-1' && data.priceToFind[i] !== -1) {
							returnJsonURL += 'featureValueId=' + data.priceToFind[i] + '&';
						}
					}
				}
				if(data.hasOwnProperty('featuresToFind')) {
					len = data.featuresToFind.length;
					for (i = 0; i < len; i += 1) {
						if (data.featuresToFind[i] !== '-1' && data.featuresToFind[i] !== -1) {
							returnJsonURL += 'featureValueId=' + data.featuresToFind[i] + '&';
						}
					}
				}
				returnJsonURL += 'text=' + data.textToFind + '&';

				return returnJsonURL;
			}

		}
		function destroy() {}

        return {
            init: init,
            destroy: destroy
        };
	}
});
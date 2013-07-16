mno.core
		.register({
			id : 'widget.relatedContents.eventEngineObjects',
			extend : [ 'widget.moodboard.default' ],
			wait : [],
			creator : function(sandbox) {
				var runMoodBoardInit;
				function init() {
					if (sandbox.container) {
						var runinitRatesDetails = this.initRatesDetails;
						runMoodBoardInit = this.initMoodBoard;
						runinitRatesDetails(sandbox, sandbox.container,
								sandbox.model[0]);

					} else {
						console
								.log('************ relatedContents/eventEngineObjects.js not initialized************');
					}
				}

				function initRatesDetails(sandbox, container, model) {

					var eventsIds = model['eventsIds'].split(',');

					jQuery.each(eventsIds, function(j) {

						var eventID = eventsIds[j];// parseInt(model.eventId,10);
						model['groupid'] = 2; // 1 for place, 2 for event
						model['template'] = 'widgets.moodboard.views.rates';
						model['scale'] = 5;
						model['siteId'] = 'OsloBy';
						model['objectId'] = eventID;

						runMoodBoardInit(sandbox, model, container
								.find('div#rating_' + eventID));

					});

				}

				function destroy() {

				}

				return {
					init : init,
					destroy : destroy,
					initRatesDetails : initRatesDetails
				}
			}
		});
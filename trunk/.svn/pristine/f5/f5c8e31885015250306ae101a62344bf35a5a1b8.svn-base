mno.core.register({
    id:'widget.personalia.list',
    creator:function (sandbox) {
        var $ = sandbox.$,
                   page=1,
            /*personaliaSortDev sortCol = "date",
            sortDir = "asc",*/
                   appUrl = (typeof sandbox.model[0] !== 'undefined') ? sandbox.model[0].personaliaAppUrl : '',
                   adLocation = (typeof sandbox.model[0] !== 'undefined') ? sandbox.model[0].personaliaAdLocation : '',
                   adType = (typeof sandbox.model[0] !== 'undefined') ? sandbox.model[0].personaliaAdType : '',
                   pagesize = (sandbox.model !== null && sandbox.model.length > 0 ? sandbox.model[0].pagesize : (function(){
                    /* warn that pagesize is not set and return default value 20 */
                    mno.core.log(2,"pagesize not set in widget.personalia.list default 20"); return 20
                    }())),
                   params = mno.utils.params,
                   that,
                   resultElement = $('#listWrapper');


        function createPaging(argTotalRecords) {
            var totalPages = Math.ceil(argTotalRecords / pagesize),
                groupSize = 7,
                currentGroup = Math.ceil(page / groupSize),
                groupStartPage = (currentGroup - 1) * groupSize + 1,
                groupEndPage = currentGroup * groupSize,
                list = {
                    'olClass':'pager',
                    'items':[]
                },
                p;

            if (totalPages > 1) {
                for (p = groupStartPage; p <= totalPages && p <= groupEndPage; p++) {
                    if (p === page) {
                        list.items.push({value:'<span class="button active" title="Side ' + p + '">' + p + '</span>'});
                    } else {
                        list.items.push({value:'<a class="button" href="#'+p+'" title="Side ' + p + '">' + p + '</a></li>'});
                    }
                }
                if (currentGroup > 1) {
                    list.items.push({value:'<a class="button" href="#'+ (groupStartPage - groupSize) + '" title="Forrige gruppe">Forrige</a>'});
                }
                if ((totalPages / groupSize) > currentGroup) {
                    list.items.push({value:'<a class="button" href="#' + (groupStartPage + groupSize) + '" title="Neste gruppe">Neste</a>'});
                }
                list.items.push({value:'<a class="button" href="#1" title="F&oslash;rste side">F&oslash;rste</a>'});
                list.items.push({value:'<a class="button" href="#' + totalPages + '" title="Siste side">Siste</a>'});
            }
            return list;
        }

        /*personaliaSortDev function createSorting() {
            var list = {
                'ulClass':'sorter',
                'items':[]
            };

            jQuery.each({'lastName':'Navn', 'date':'Dato'}, function(key, value){
                if(key === sortCol) {
                    list.items.push({value:'<a class="button active '+ sortDir +'" title="Sorter på '+ value +'" data-action-sortCol="'+ key +'" data-action-sortDir="'+ sortDir +'">'+ value +'</a>'});
                } else {
                    list.items.push({value:'<a class="button" title="Sorter på '+ value +'" data-action-sortCol="'+ key +'">'+ value +'</a>'});
                }
            });

            return list;
        }*/

        function callback(data) {
            if(data.message.records){
                resultElement.empty();
                var item = {
                        items: data.message.records,
                        appUrl: appUrl,
                        adLocation: adLocation
                    };
                /*personaliaSortDev if (sandbox.container) {
                    sandbox.render('widgets.personalia.views.list', item, function (html) {
                        var pagingList = createPaging(data.message.totalRecords),
                                                sortingList = createSorting();

                        sandbox.render('mno.views.unorderedList', sortingList, function (sortingListHtml) {
                            if (pagingList.items.length !== 0) {
                                sandbox.render('mno.views.orderedList', pagingList, function (pagingListHtml) {
                                    resultElement.append(sortingListHtml).append(html).append(pagingListHtml);
                                });
                            } else {
                                resultElement.append(sortingListHtml).append(html);
                            }
                        });
                    });
                }*/
                    if (sandbox.container) {
                        sandbox.render('widgets.personalia.views.list', item, function (html) {
                            var list = createPaging(data.message.totalRecords);
                            if (list.items.length !== 0) {
                                sandbox.render('mno.views.orderedList', list, function (html2) {
                                    resultElement.append(html);
                                    resultElement.append(html2);
                                });
                            }else{
                                resultElement.append(html);
                            }
                        });
                    }
            }
        }

        function getFeed() {
            var personaliaAction,
                parameters = params.getAllParameters();
            if(parameters.submit){
                /*Do a search*/
                personaliaAction = 'search.htm?searchText='+ (escape(parameters.searchText) || '') +
                    '&adType='+ parameters.adType +
                    '&srchMode='+ (parameters.srchMode || '');
                if(parameters.srchMode==='adv') {
                    personaliaAction += '&date_from='+ (parameters.date_from.replace(/\//g,'.') || '') +
                        '&date_to='+ (parameters.date_to.replace(/\//g,'.') || '');
                }
                else {
                    personaliaAction += '&searchTime=365';
                }
            }
            else{
                /*Do a listing*/
                personaliaAction = 'listAds.htm?activeTab='+ (parameters.adType || adType);
            }
            personaliaAction += '&page='+ page +
                '&size='+ pagesize +
                '&view=json';

            sandbox.getScript({
                url: appUrl + personaliaAction,
                callbackVar:'callback',
                jsonP:callback
            });
        }

        function init() {
            if(sandbox.container){
                that = this;
                getFeed(page);
                 /*had move this event binding out side of rendering or else it would bind every time you switch page*/
                sandbox.container.find('.pager a').live('click', function (e) {
                    var href = $(this).attr("href");
                    // ie7 fix beacause ie7 always gives full url
                    var nrToParse = href.substring(href.indexOf('#') + 1,href.length);
                    page = parseInt(nrToParse,10);
                    getFeed();
                    e.preventDefault();
                    return false;
                });

                /*personaliaSortDev sandbox.container.find('.sorter a').live('click', function(e) {
                    e.preventDefault();
                    return false;
                });*/
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
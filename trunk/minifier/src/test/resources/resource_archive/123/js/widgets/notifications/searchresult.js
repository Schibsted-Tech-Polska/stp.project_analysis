mno.core.register({
    id:'widget.notifications.searchresult',
    extend:['mno.utils.rubrikk'],
    creator:function (sandbox) {
        var $ = sandbox.$,
            page=1,
            size= (sandbox.model !== null && sandbox.model.length > 0 ? sandbox.model[0].pagesize : (function(){
                    /* warn that pagesize is not set and return default value 10 */
                    mno.core.log(2,"pagesize not set in widget.notifications.searchresult default 10"); return 10
            }())),
            adUrl = (typeof sandbox.model[0] !== 'undefined') ? sandbox.model[0].adUrl : '',
            params = mno.utils.params,
            that,
            resultElement = $('#resultsWrapper');

        function createPaging(argTotalRecords) {
            var totalPages = Math.ceil(argTotalRecords / size),
                groupSize = 7,
                currentGroup = Math.ceil(page / groupSize),
                groupStartPage = (currentGroup - 1) * groupSize + 1,
                groupEndPage = currentGroup * groupSize,
                list = {
                    'olClass':'pager',
                    'items':[]
                },
                p;
                /*mno.core.log(1,"totalPages: " + totalPages + "groupSize: " + groupSize + "currentGroup: " + currentGroup + "groupStartPage: " + groupStartPage + "groupEndPage: " + groupEndPage + "totalPages: " + totalPages + "totalPages: " + totalPages );*/
//            if (currentGroup == 0) currentGroup = 1;

            if (totalPages > 1) {
                for (p = groupStartPage; p <= totalPages && p <= groupEndPage; p++) {
                    if (p === page) {
                        list.items.push({value:'<span class="button active" title="Side ' + p + '">' + p + '</span>'});
                    } else {
                        list.items.push({value:'<a class="button" href="#'+p+'" title="Side ' + p + '">' + p + '</a></li>'});
                    }
                }
                if (currentGroup > 1) {
                    list.items.push({value:'<a class="button" href="#'+ (groupStartPage - groupSize) + '" title="Forrige gruppe">Forrige gruppe</a>'});
                }
                if ((totalPages / groupSize) > currentGroup) {
                    list.items.push({value:'<a class="button" href="#' + (groupStartPage + groupSize) + '" title="Neste gruppe" class="f- 000">Neste gruppe</a>'});
                }
                list.items.push({value:'<a class="button" href="#1" title="F&oslash;rste side">F&oslash;rste</a>'});
                list.items.push({value:'<a class="button" href="#' + totalPages + '" title="Siste side">Siste</a>'});
            }
            return list;
        }

        function callback(data) {
            var message = data.SearchMessage;
            if (message.success === true) {
                var list = {
                    'items':[],
                    'olClass':'resultList withImg'
                    },
                    records = message.records,
                    item,
                    html ='',
                    company;

                resultElement.empty();

                for (var i = 0; i < records.length; i++) {
                    item = records[i];
                    html = '',
                    company = item.company;

                    if (typeof company.companyLogos[0] !== 'undefined') {
                        html += '<img src="http://' + that.lisaLevel + '.aftenposten.no/utils/img.php?src='+company.companyLogos[0].companyLogoPath + '&maxHeight=70&maxWidth=70" alt=""/>';
                    }
                    html += '<a class="searchresult-title" href="' + adUrl + '?notificationAdId=' + item.notificationAdId+'">' + item.adTitle + '</a>';
                    html += '<div class="companyName" itemprop="name">' + company.name + '</div>';
                    html += '<div class="category">Kategori: ' + item.categories[0].categoryName + '</div>';
                    html += '<div class="date">Gjelder til: ' + item.validTo + '</div>';

                    list.items.push({
                        attributes:'itemscope ="itemscope" itemtype="http://data-vocabulary.org/Organization"',
                        value:'<div class="resultList-inner">'+ html + '</div>'
                    });
                }

                sandbox.render('mno.views.orderedList', list, function (data) {
                    var list = createPaging(message.totalRecords);
                    if (list.items.length !== 0) {
                        sandbox.render('mno.views.orderedList', list, function (data2) {
                            resultElement.append(data);
                            resultElement.append(data2);
                        });
                    } else {
                        resultElement.append(data);
                    }
                });


            }
        }

        function getFeed() {
            var parameters = params.getAllParameters(),
                order = $('#freetextorder').val(),
                categoryId='';

            if (typeof parameters.categoryId !== 'undefined') {
                if (parameters.categoryId.constructor === Array) {
                    categoryId = '&categoryId=' + parameters.categoryId.join('&categoryId=');
                } else {
                    categoryId = '&categoryId='+parameters.categoryId;
                }
            }

            if(parameters.query === undefined || parameters.query == "Søk"){
                parameters.query = '';
            }

            sandbox.getScript({
                url: 'http://rubrikk.aftenposten.no/onlineClassifieds/search/notificationads.json?renderType=default&query=' + ( escape(parameters.query) ||'') + categoryId +'&size='+size+'&utf8=true&page=' + page + '&order=' + order,
                jsonP:callback
            });
        }

        function init() {
            if(sandbox.container){
                that = this;
                getFeed(page);
                $('#freetextorder').bind('change', getFeed);

                /* had move this event binding out side of rendering or else it would bind every time you switch page */
                sandbox.container.find('.pager a').live('click', function (e) {

                    var href = $(this).attr("href");
                    // ie7 fix beacause ie7 always gives full url
                    var nrToParse = href.substring(href.indexOf('#') + 1,href.length);
                    page = parseInt(nrToParse,10);
                    /*mno.core.log(1,page);*/
                    getFeed();
                    e.preventDefault();
                    return false;
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


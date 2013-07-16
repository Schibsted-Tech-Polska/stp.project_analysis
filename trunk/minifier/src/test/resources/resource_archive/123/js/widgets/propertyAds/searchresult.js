mno.core.register({
    id:'widget.propertyAds.searchresult',
    extend:['mno.utils.rubrikk'],
    creator:function (sandbox) {
        var $ = sandbox.$,
            page=1,
            size= (sandbox.model !== null && sandbox.model.length > 0 ? sandbox.model[0].pageSize : (function(){
                    /* warn that pagesize is not set and return default value 10 */
                    mno.core.log(2,"pagesize not set in widget.propertyAds.searchresult default 10"); return 10
            }())),
            adUrl = (sandbox.model !== null && sandbox.model.length > 0) ? sandbox.model[0].adUrl : '',
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


                    for (var j = 0; j < item.propertyImages.length; j++) {
                        if (item.propertyImages[j].imageType.propertyImageTypeValue == 'THUMBNAIL')
                            html += '<img src="http://' + that.lisaLevel + '.aftenposten.no/utils/img.php?src='+item.propertyImages[j].imagePath + '&maxHeight=90&maxWidth=120" alt="' + item.adTitle + '"/>';
                    }

                    html += '<a class="searchresult-title" href="' + adUrl + '?propertyAdId='+ item.propertyAdId+'" title="Se boligannonse" target="_blank">' + item.address.addressLine1 + '</a>';
                    html += '<div class="companyName" itemprop="name">' +  item.address.postNumber.postNumberName + ' ' + item.address.postNumber.city  + '</div>';
                    if (item.propertyViewings && item.propertyViewings.length > 0) {
                        html += '<div class="f-small">Visning: ';
                        for (var v = 0; v < item.propertyViewings.length; v++) {
                            if (v > 0) html += ', ';
                            html += formatDate(item.propertyViewings[v].viewingDate);
                        }
                        html += '</div>';
                    }
                    if (item.salesPrice) {
                        html += '<p class="f-85">Prisantydning: ' + formatCurrency(item.salesPrice) + '</p>';
                    }


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
                categories='',
                dates='',
                searchurl;

            if (typeof parameters.categoryId !== 'undefined') {
                if (parameters.categoryId.constructor === Array) {
                    categories = '&categoryId=' + parameters.categoryId.join('&categoryId=');
                } else {
                    categories = '&categoryId='+parameters.categoryId;
                }
            }

            if (typeof parameters.date !== 'undefined') {
                if (parameters.date.constructor === Array) {
                    dates = '&date=' + parameters.date.join('&date=');
                } else {
                    dates = '&date='+parameters.date;
                }
            }

            if(parameters.freetextsearch == "Søk"){
                parameters.freetextsearch = '';
            }

            searchurl = that.rubrikkCacheUrl + 'search/propertyads.json?';
            if (parameters.freetextsearch) searchurl += '&freetextsearch=' + escape(parameters.freetextsearch);
            if (parameters.priceFrom && parameters.priceFrom != 'Pris fra...') searchurl += '&priceFrom=' + parameters.priceFrom;
            if (parameters.priceTo && parameters.priceTo != 'Pris til...') searchurl += '&priceTo=' + parameters.priceTo;

            sandbox.getScript({
                url: searchurl + categories + dates + '&size='+size+'&utf8=true&page=' + page + '&order=' + order,
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


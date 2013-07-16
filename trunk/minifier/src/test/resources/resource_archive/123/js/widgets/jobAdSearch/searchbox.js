var cbJobCategories;
var clickedCategoryId = '';
mno.core.register({
    id:'widget.jobAdSearch.searchbox',
    extend:['mno.utils.rubrikk'],
    creator: function (sandbox) {
        var $ = sandbox.$;
        var that = this;
        var arrayOfCatId = mno.utils.params.getParameter('categoryId');
        if(arrayOfCatId.constructor === String){
            arrayOfCatId = [arrayOfCatId];       
        } else if(!(arrayOfCatId.constructor === Array)){
            arrayOfCatId = [];
        }

        function callback(data) {
            sandbox.container.each(function(i, el) {
                var $this = $(this);
                if (data.message.records) {
                    var categoryList = $('#jobAdSearch-categoryList'),
                        numCats = data.message.records.length,
                        model = sandbox.model[i];


                    if (typeof model !== 'undefined') {
                        var items = {
                                split:model.columns,
                                splitNum:model.splitNum,
                                jobbUrl:model.jobbUrl,
                                topItems:[],
                                otherItems:[],
                                allCategoriesQString:''
                            },
                            hideCats = model.hideEmptyCats,
                            topCategoryCount = 0,
                            otherCategoryCount = 0,
                            extraListHtml = '',
                            hiddenCheckboxChecked = false,
                            i,
                            cat;

                        for (i = 0; i < numCats; i++) {

                            cat = data.message.records[i];
                            cat.categoryName = cat.categoryName.replace('Informasjon / Kommunikasjon / Media', 'Informasjon / Kommunikasjon');
                            cat.categoryName = cat.categoryName.replace('IT / IKT / Telekommunikasjon', 'IT / Telekommunikasjon');
                            cat.categoryName = cat.categoryName.replace('Utdanning / Undervisning / Forskning', 'Utdanning/ Undervisning');
                            cat.categoryName = cat.categoryName.replace('Olje / Gass / Off-, On-shore / Maritim', 'Olje / Gass/ Off-, On-shore');
                            cat.categoryName = cat.categoryName.replace('Administrasjon / Kontor/ Personal', 'Administrasjon / Personal');
                            cat.categoryName = cat.categoryName.replace('H\345ndverk / Bygg / Anlegg / Mekanikk / Arkitekter', 'H\345ndverk / Bygg / Anlegg');
                            cat.categoryName = cat.categoryName.replace('Offentlige tjenester / Forvaltning', 'Offentlige tjenester');

                            items.allCategoriesQString += (i === 0 ? '?' : '&') + 'categoryId=' + cat.categoryId;

                            cat.checked = (arrayOfCatId.indexOf(cat.categoryId + '') !== -1 ? ' checked="checked" ' : '');

                            if (model.categoryIdList.indexOf(cat.categoryId) !== -1) {
                                items.topItems.push(cat);
                            } else if (!hideCats || cat.countedAds > 0) {
                                if (arrayOfCatId.indexOf(cat.categoryId + '') !== -1) {
                                    hiddenCheckboxChecked = true;
                                }
                                items.otherItems.push(cat);
                            }
                        }

                        if (model.showCategories === undefined || model.showCategories === 'true') {
                            sandbox.render('widgets.jobAdSearch.views.categories', items, function (html) {
                                categoryList.append(html);
                                // fixes IE7  height issue
                                categoryList.css("height", "auto");
                                // attach show hide event to categorylist

                                $this.find('.showCategories a').click(function(e){
                                    var $link = $(this);
                                    e.preventDefault();
                                    $this.find('.other').show();
                                    var $parent = $link.closest('.showCategories');
                                    $parent.hide();
                                    $parent.siblings('.hideCategories').show();

                                });

                                $this.find('.hideCategories a').click(function(e){
                                    var $link = $(this);
                                    e.preventDefault();
                                    $this.find('.other').hide();
                                    var $parent = $link.closest('.hideCategories');
                                    $parent.hide();
                                    $parent.siblings('.showCategories').show();
                                });

                                if(hiddenCheckboxChecked){
                                    $this.find('.showCategories a').click();
                                }
                                /* Adds category id's as search parameters*/
                                $this.find('#jobAdSearch-categoryList li input').click(function (event) {
                                    var checkBoxId = event.target.value;
                                    if(clickedCategoryId.search(checkBoxId)== '-1'){
                                        clickedCategoryId += "&categoryId=" + checkBoxId;
                                    }
                                    else{
                                        var replaceString = '&categoryId=' + checkBoxId;
                                        clickedCategoryId = clickedCategoryId.replace(replaceString,'');
                                    }
                                });
                            });
                        } else {
                            categoryList.remove();
                        }
                    }
                }

            });
        }

        /* Unchecks all check boxes after a search*/
        function unCheckCheckBoxes(){
            window.onload = function() {
                $(":input").attr('checked', false);
            }
        }

        cbJobCategories = function(data) {
            callback.call(that.instance, data);
            unCheckCheckBoxes();
        };

        return  {
            init: function () {
                sandbox.getScript({
                    url:this.jsonUrl + 'jobCategories.json'
                });
                sandbox.container.each(function(i, element){
                   $('form#jobbSearch').bind('submit', function (event) {
                       var jobSearchInput =  $('form#jobbSearch input[name="freetextsearch"]');  //Finner input-feltet "search"
                       var query =  escape(jobSearchInput.val());// input.val() henter inntastet streng. Escape gjør strengen portabel.
                       var param = jobSearchInput.attr('name');  //Henter navnet "search"
                       if (query == jobSearchInput.attr('placeholder')) {
                          jobSearchInput.val('');
                       } else  {
                          // Lager en fullstendig URL manuelt  (bruk av encodeURI ga problemer). Legger til categoryId på slutten hvis disse er avhuket.
                          document.location.href = $(this).attr('action') + "?" + param + "=" + query + clickedCategoryId;
                          return false;
                       }
                   });
                })
            },
            destroy: function () {
            }
        };

    }
});

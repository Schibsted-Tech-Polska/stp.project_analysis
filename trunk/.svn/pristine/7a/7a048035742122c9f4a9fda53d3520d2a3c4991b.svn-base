mno.core.register({
    id:'widget.propertyAds.searchbox',
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
           if(sandbox.container){
                var $this = $(this);
                if (data.message.records) {
                    var categoryList = $('#propertyAds-categoryList'),
                        numCats = data.message.records.length,
                        model = sandbox.model[0];


                    if (typeof model !== 'undefined') {
                        var items = {
                                searchUrl:model.searchUrl,
                                topItems:[],
                                allCategoriesQString:''
                            },
                            topCategoryCount = 0,
                            i,
                            cat;

                        for (i = 0; i < numCats; i++) {
                            cat = data.message.records[i];
                            items.allCategoriesQString += (i === 0 ? '?' : '&') + 'categoryId=' + cat.categoryId;

                            cat.checked = (arrayOfCatId.indexOf(cat.categoryId + '') !== -1 ? ' checked="checked" ' : '');
                            items.topItems.push(cat);
                        }

                        sandbox.render('widgets.propertyAds.views.categories', items, function (html) {
                            categoryList.append(html);
                            // fixes IE7  height issue
                            categoryList.css("height", "auto");
                            // attach show hide event to categorylist

/*
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
*/                          categoryList.find('.categories').mnoTree();
                        });
                    }


                }

            }
        }


        cbPropertyCategories = function(data) {
            callback.call(that.instance, data);
        };

        return  {
            init: function () {
                sandbox.getScript({
                    url:this.jsonUrlBolig + 'propertyCategories.json'
                });
            },
            destroy: function () {
            }
        };

    }
});

mno.core.register({
    id:'widget.weather.list',
    creator:function (sandbox) {
        var baseUrl;

        function init() {
            if (sandbox.container) {
                sandbox.container.each(function(i, element){
                    var model = sandbox.model[i];
                    baseUrl = model.baseUrl;

                    handleList(element, model.showListSelector, model.listCategory, model.listId, model.weatherSearchPage, model.showYr);
                });
            }
        }

        function handleList(container, showListSelector, category, id, searchPage, showYr){
            var currentCategory = category;
            var currentId = id;
            var url = baseUrl+"json/showList.json?categoryId="+currentCategory+"&listId="+currentId+"&callback=?";

            function retrieveList(container, url){
                jQuery.ajax({
                    type: "GET",
                    url: url,
                    dataType:'jsonp',
                    cache:'true',
                    success:function(data) {
                        if(data.items.length>0){
                            printList(container, data);
                        }else{
                            mno.core.log(1, 'no items in the list '+data.list.name);
                        }
                    },
                    error:function(jqHXR, textStatus, errorThrown) {
                        mno.core.log(1, 'error retrieveList: ' + textStatus + ' ' + errorThrown);
                    }
                });
            }

            function findHours(time){
                var date = new Date(time);
                var hours = date.getHours();
                if(hours == 0){
                    hours = 24;
                }
                return hours;
            }

            function getPlaceQuery(name, kommune, fylke){
                var trimmed = name.replace(' ', '_');
                return "sted="+escape(trimmed)+"&kommune="+escape(kommune)+"&fylke="+escape(fylke);
            }

            function printList(container, data){
                sandbox.render('widgets.weather.view.list',{list:data.list, items:data.items, findHours:findHours, searchPage:searchPage, getPlaceQuery:getPlaceQuery}, function(html){
                    $(container).html(html);
                    if(showListSelector=="true"){
                        retrieveExistingLists();
                    }else if(showYr=='true'){
                        sandbox.render('widgets.weather.view.yrDisclaimer', {yrUrl:''}, function(html){
                            $(container).append(html);
                        });
                    }
                });
            }

            function retrieveExistingLists(){
                jQuery.ajax({
                    type: "GET",
                    url: baseUrl+'json/getallcategories.json',
                    dataType:'jsonp',
                    cache:'true',
                    success:function(data) {
                        printListSelector(data);
                    },
                    error:function(jqHXR, textStatus, errorThrown) {
                        mno.core.log(1, 'error retrieveExistingLists: ' + textStatus + ' ' + errorThrown);
                    }
                });
            }

            function printListSelector(data){
                sandbox.render('widgets.weather.view.listSelector', {allCategories:data.categories}, function(html){
                    $(container).append(html);
                    $(container).find('.weatherSelect option[value='+currentCategory+'_'+currentId+']').attr('selected', true);
                    $(container).find('.weatherSelect').change(function(){
                        var category = $(this).val().split('_')[0];
                        var id = $(this).val().split('_')[1];
                        handleList(container, showListSelector, category, id);
                    });
                    mno.utils.form.select(container);

                    if(showYr=='true'){
                        sandbox.render('widgets.weather.view.yrDisclaimer', {yrUrl:''}, function(html){
                            $(container).append(html);
                        });
                    }
                });
            }

            retrieveList(container, url);
        }

        function destroy() {}

        return {
            init:init,
            destroy:destroy
        }
    }
});
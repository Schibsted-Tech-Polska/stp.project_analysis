mno.core.register({
    id:'widget.weather.tabbedLists',
    creator:function (sandbox) {
        var baseUrl;

        function init() {
            if (sandbox.container) {
                sandbox.container.each(function(i, element){
                    var model = sandbox.model[i];
                    var container = $(element);
                    var lists = [];
                    var numOfLists = model.lister.length;
                    baseUrl = model.baseUrl;

                    jQuery.each(model.lister, function(index, list){
                        retrieveList(lists, container, list, index, numOfLists, model.weatherSearchPage, model.showYr);
                    });
                });
            }

        }

        function retrieveList(lists, container, list, index, numOfLists, searchPage, showYr){
            jQuery.ajax({
                type: "GET",
                url: baseUrl+"json/showList.json?categoryId="+list.category+"&listId="+list.id+"&callback=?",
                dataType:'jsonp',
                cache:'true',
                success:function(data) {
                    if(data.items.length>0){
                        lists[index] = data;
                    }else{
                        mno.core.log(1, 'no items in list '+data.list.name);
                    }

                    if(lists.length==numOfLists){
                        renderLists(lists, container, searchPage, showYr);
                    }
                },
                error:function(jqHXR, textStatus, errorThrown) {
                    mno.core.log(1, 'error retrieveTabbedList: ' + textStatus + ' ' + errorThrown);
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

        function renderLists(lists, container, searchPage, showYr){
            sandbox.render('widgets.weather.view.tabbedLists', {uniqueId:Math.ceil(Math.random()*100000), lists:lists, findHours:findHours, searchPage:searchPage, getPlaceQuery:getPlaceQuery}, function (html) {
                container.html(html);

                if(showYr=='true'){
                    sandbox.render('widgets.weather.view.yrDisclaimer', {yrUrl:''}, function(html){
                        container.append(html);
                    });
                }
            });
        }

        function destroy() {}

        return {
            init:init,
            destroy:destroy
        }
    }
});


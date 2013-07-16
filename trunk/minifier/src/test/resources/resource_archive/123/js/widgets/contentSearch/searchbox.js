
mno.core.register({
    id: 'widget.contentSearch.searchbox',
    /*require:['widgets.contentSearch.navigation'],*/
    creator: function (sandbox) {

        var applyOldNavigation = function() {
            var breadcrumbsElement = sandbox.container.find("#search_form_breadcrumbs");
            var oldBreadcrumbsElement = sandbox.container.find("#search_form_old_breadcrumbs");
            if (breadcrumbsElement.length === 1 && oldBreadcrumbsElement.length === 1) {
                breadcrumbsElement.val(oldBreadcrumbsElement.val());
                return true;
            }
            return false;
        };

        sandbox.listen({
            'contentSearch-navigator-change': function(data) {
                mno.core.log(1,data);
                var breadcrumbsElement = sandbox.container.find("#search_form_breadcrumbs");
                if (breadcrumbsElement.length === 1) {
                    if(breadcrumbsElement.length === 1) {
                        breadcrumbsElement.val(data.param1 + data.param2);
                    } else{
                        breadcrumbsElement.val(data.param2);
                    }
                }

                data.e.stopPropagation();
                data.e.preventDefault();
                sandbox.container.submit();
            },
            'contentSearch-paging-change': function(data) {
                var offsetElement = sandbox.container.find("#search_form_offset"),
                    searchFromBreadcrumbs = sandbox.container.find("#search_form_breadcrumbs");

                searchFromBreadcrumbs.val(Base64.decode(searchFromBreadcrumbs.val()));
                offsetElement.val(data.param1);
                sandbox.container.submit();
            }
        });

        var submitSearch = function() {

            var searchForm = sandbox.container; //byId("search_form");
            if(!sandbox.container.find("input[type='radio'][value='exact_from']").attr("checked"))
            {
                sandbox.container.find("#date_from").val("");
                sandbox.container.find("#date_to").val("");
            }
            if(sandbox.container.find("#date_to").val() === "")
            {
                sandbox.container.find("#chosen_to").attr("checked",false);
            }
            if(!sandbox.container.find("#chosen_to").attr("checked")){
                sandbox.container.find("#date_to").val("");                
            }


            //if(search)

            // ticket 17295
            var breadCrumbs = sandbox.container.find("#search_form_breadcrumbs"); //byId('search_form_breadcrumbs');
            var docVector =  sandbox.container.find("#search_form_similar_to"); //byId('search_form_similar_to');
            var breadCrumbsString = "";
            if (breadCrumbs.length === 1){
                breadCrumbsString = String(breadCrumbs.val());
                breadCrumbsString = Base64.encode(breadCrumbsString);
                breadCrumbs.val(breadCrumbsString);
            }
            var docVectorString = "";
            if (docVector.length === 1) {
                docVectorString = String(docVector.val());
            }
            var sum = breadCrumbsString.length + docVectorString.length;

            // revert to post if breadcrumbs and docvector grows to large (prevent path url to get over IE max limit on approx 2380)

            var browser=window.navigator.appName;
            var browserString = String(browser);

            // revert only for IE
            if(sum > 1700 && browserString === "Microsoft Internet Explorer") {
                searchForm.attr("method","post");
            }

            // remove the empty fields, used for javascript
            var search_form_old_similar_to = sandbox.container.find("#search_form_old_similar_to");//byId("search_form_old_similar_to");
            if (search_form_old_similar_to.length === 1){
                search_form_old_similar_to.remove();
            }
            var search_form_old_breadcrumbs = sandbox.container.find("#search_form_old_breadcrumbs");// byId("search_form_old_breadcrumbs");
            if (search_form_old_breadcrumbs.length === 1){
                search_form_old_breadcrumbs.remove();
            }

            var search_form_old_similar_type = sandbox.container.find("#search_form_old_similar_type");// byId("search_form_old_similar_type");
            if (search_form_old_similar_type.length === 1){
                search_form_old_similar_type.remove();
            }

            var previous_sort_by = sandbox.container.find("#previous_sort_by"); //byId("previous_sort_by");
            if (previous_sort_by.length === 1){
                previous_sort_by.remove();
            }

            var previous_sort_order = sandbox.container.find("#previous_sort_by");//byId("previous_sort_order");
            if (previous_sort_order.length === 1){
                previous_sort_order.remove();
            }
        };

        var advancedSearchInit = function(){
            var dateFromQ = "date_from",
                dateToQ = "date_to",
                timeQ = "time",
                params = mno.utils.params,
                dateFrom = params.getParameter(dateFromQ),
                dateTo = params.getParameter(dateToQ),
                time = params.getParameter(timeQ);


            /* check if params are strings if not there is no date in the params*/
            if(typeof dateFrom === "string"  && dateFrom !== "") {

                sandbox.container.find("#date_from").val(dateFrom);

                sandbox.container.find("#chosen_from").attr("checked",true);
                if(typeof dateTo === "string" && dateTo !== ""){
                    sandbox.container.find("#chosen_to").attr("checked",true);
                    sandbox.container.find("#date_to").val(dateTo);
                }
                sandbox.container.find('#advSearchToggle').click();
            } else if(typeof time === "string") {
                sandbox.container.find("input[type='radio'][value='" + time + "']").attr("checked",true);
                sandbox.container.find('#advSearchToggle').click();
            }
        };

        function init() {
            var dateFromAndDateTo = sandbox.container.find("#date_from,#date_to"),
                dateTo = sandbox.container.find("#date_to"),
                chosenFrom = sandbox.container.find("#chosen_from"),
                chosenTo = sandbox.container.find("#chosen_to"),
                advState=false;

            sandbox.container.submit(submitSearch);
            sandbox.container.find("#search_form button").click(function(){
                sandbox.container.submit();
                return false;
            });

            sandbox.container.find('#advSearchToggle').bind('click', function (e) {
                if (advState === false) {
                    sandbox.container.find('#advancedSearch').show(250);
                    advState = true;
                } else {
                    sandbox.container.find('#advancedSearch').hide(250);
                    $('#chosen_from').trigger('click');
                    $('#date_from').val('');
                    advState = false;
                }
                e.preventDefault();
            });
            dateFromAndDateTo.bind("click",function(){
                chosenFrom.attr("checked",true);
                $(this).next(".ui-datepicker-trigger").click();
            });
            

            dateFromAndDateTo.bind("change",function(){
                chosenFrom.attr("checked",true);
                dateTo.attr("disabled",false);
            });

            dateTo.bind("change",function(){
                chosenTo.attr("checked",true);
            });

            chosenTo.bind("change",function(){
                if(!chosenTo.attr("checked") && dateTo.val() !== ""){
                    dateTo.attr("disabled",true);   
                    /* to do: do something here */
                }
                else{
                    dateTo.attr("disabled",false);   
                }
            });
            dateTo.bind("change",function(){
                if(dateTo.val() === ""){
                    chosenTo.attr("checked",false);
                }
            });


            advancedSearchInit();
            checkSectionSearch();
        }

        function checkSectionSearch(){
            $("form").submit(function() {
            var query =  sandbox.container.find("#search_form_query");
            if(query.val()!=""){
                sandbox.container.find("#sectionName")[0].value="";
            }
            });
        }

        function destroy() {

        }

        return {
            init: init,
            destroy: destroy
        };
    }
});

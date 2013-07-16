mno.core.register({
    id:'widget.sectionStories.list',
    creator: function (sandbox) {
        var sectionUniqueName;

        // Listen to events when section is changed
        sandbox.listen({
            'section-navigator-change': function(data) {
                    if (typeof(data.e) == 'object') {
                        data.e.stopPropagation();
                        data.e.preventDefault();
                    }
                    initialLoad(data.param1);
            }
        });
        // Listen to a loadmore data eveent
        sandbox.listen({
            'section-navigator-loadmore': function(data) {
                    if (typeof(data.e) == 'object') {
                        data.e.stopPropagation();
                        data.e.preventDefault();
                    }
                    loadMoreData(sandbox.container.find("dx.status").attr("data-section"),parseInt(sandbox.container.find("dx.status").attr("data-end-id")));
            }
        });

        /**
         * Load more data in to the article list
         *
         * @param section
         * @param lastId
         */
        function loadMoreData(section, lastId){
            $.ajax({
                type:'get',
                url: '/?service=widget&widget=sectionStories&view=list&contentId=2205858&ajax=true&sectionUniqueName='+section+'&begin='+(lastId+1)+'&end='+(lastId+16)+'&more=true&width=980&pictureformat=43&rnd=' + Math.floor(Math.random() * 1111111111111),
                success:function (data) {
                    data = $(data);
                    if(data.length > 0){
                        // Remove old tag containing offset of loaded data
                        sandbox.container.find("dx").remove();
                        // Appending the result
                        sandbox.container.find("ul").append(data);
                    }
                    // Binding click events to the favourite icons
                    sandbox.container.find('span.favourite').each(function(e) {
                        $(this).unbind('click');
                        bindSaveArticleToClick($(this));
                    });
                }
            });
        }

        /*
         * Bind saveArticle to favourite icon
          *
         * @param item
         */
        function bindSaveArticleToClick(item){
            item.bind('click', function(e) {
                e.preventDefault();
                e.stopPropagation;
                sandbox.notify({
                    type:'save-article',
                    data:{
                        id:item.attr('data-article-id'),
                        e:e
                    }
                });
                item.addClass('saved');
            });
        }

        /**
         * Loads the article upon initial load.
         *
         * @param uniqueSection
         */
        function initialLoad(uniqueSection) {
            $.ajax({
                type:'get',
                url: '/?service=widget&widget=sectionStories&view=list&contentId=2205858&ajax=true&sectionUniqueName='+uniqueSection+'&width=980&pictureformat=43&rnd=' + Math.floor(Math.random() * 1111111111111),
                success:function (data) {
                    data = $(data);
                    if(data.length > 0){
                        // Bind a click event to the delete urls in the article list
                        sandbox.container.html(data);
                        sandbox.container.find('span.favourite').each(function(e) {
                            $(this).unbind('click');
                            bindSaveArticleToClick($(this));
                        });
                    }
                    sandbox.notify({
                        type:'sectionstories-section-init',
                        data:{
                            section:uniqueSection
                        }
                    });
                }
            });
        }

        /**
         * Called when the widget is started
         */
        function init() {
            var $ = sandbox.$;
            // Load the list upon init...
            sectionUniqueName = sandbox.model[0].sectionUniqueName;
            initialLoad(sectionUniqueName);
        }

        return {
            init: init,
            destroy: function() {
                //var $ = null;
            }
        };
    }
});
mno.core.register({
    id:'widget.moodboard.list',
    creator: function (sandbox) {
        function _initMoodBoardList(model, moodboardDiv) {
            sandbox.render('widgets.moodboard.views.list', {uniqueId: Math.ceil(Math.random()*100000), userRatings:model.userRatings, showAllTab:model.showAllTab, showRvTabs:model.showRvTabs}, function (data) {
                moodboardDiv.append(data);
            });
        }

        function init() {
            sandbox.container.each(function(i) {
                var model = sandbox.model[i];
                _initMoodBoardList(model, $(this));
            });
        }

        function destroy() {}
        return {
            init: init,
            destroy: destroy
        };
    }
});

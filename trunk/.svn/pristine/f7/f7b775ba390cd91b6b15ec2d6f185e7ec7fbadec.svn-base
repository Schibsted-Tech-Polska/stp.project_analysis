
mno.core.register({
    id: 'widget.facebook.default',
    creator: function (sandbox) {
        var $ = sandbox.$;
        return {
            init: function(){
                if (sandbox.container) {
                    var debateInfo = $('#debateInfo');
                    var item =  {
                        rulesUrl: sandbox.model[0].rulesUrl
                    };
                    sandbox.render('widgets.facebook.views.debateInfo', item, function (html) {
                        debateInfo.empty();
                        debateInfo.append(html);
                    });
                }
            },
            destroy: function(){
            }
        };
    }
});



mno.core.register({
    id:'widget.pageTools.main',
    creator: function (sandbox) {
        function loadAddThis(sandbox, cb) {
            cb = cb || function() {};

            window.addthis_config = {
                ui_use_css:false,
                data_track_clickback:true, //Track back - We can see how many reads the shared link has gotten
                ui_language: 'no',
                pubid: sandbox.model[0].pubID,
                data_track_textcopy: true,
                data_track_addressbar: true,
                data_ga_property: mno.publication.googleAnalytics
            };
            window.addthis_share = {
                url:window.location.href,
                templates: {
                    twitter:'{{url}} ' // TODO: twitter hash
                }
            };
            sandbox.getScript({
                url:sandbox.model[0].url + '#pubid=' + sandbox.model[0].pubID,
                callback: cb
            });
        }

        function init() {}
        function destroy() {}

        return {
            loadAddThis:loadAddThis,
            init:init,
            destroy:destroy
        }
    }
});
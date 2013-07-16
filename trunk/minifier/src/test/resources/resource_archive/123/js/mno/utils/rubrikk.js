mno.core.register({
    id:'mno.utils.rubrikk',
    forceStart: true,
    creator: function () {
        return {
            init:function () {},
            destroy:function () {},
            adUrl: mno.publication.url + 'jobb/',
            rubrikkUrl:'http://rubrikk.aftenposten.no/onlineClassifieds/',
            rubrikkCacheUrl:'http://rubrikkcache.aftenposten.no/onlineClassifieds/',
            lisaLevel:'lisacache', 
            jsonUrl:"/external/rubrikk/jobb/json-feeds/",
            jsonUrlBolig:"/external/rubrikk/bolig/json-feeds/",
            jsonUrlNotifications:"/external/rubrikk/kunngjoring/json-feeds/"
        };
    }
});
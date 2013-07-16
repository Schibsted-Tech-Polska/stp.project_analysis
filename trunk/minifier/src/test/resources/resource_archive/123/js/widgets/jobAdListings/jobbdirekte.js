mno.core.register({
    id:'widget.jobAdListings.jobbdirekte',
    extend:['mno.utils.rubrikk'],
    forceStart:function () {
        // todo Denne retter kun en bug. Jobbdirekte kommer ikke i widgetlisten
        return (window.location.href.indexOf('jobb') !== -1);
    }(),
    creator: function (sandbox) {
        var that = this,
            globalJobbdirekteData;

        var vTickerMethods = {
             options : {
                speed: 700
                ,pause: 4000
                ,showItems: 3
                ,mousePause: true
                ,height: 0
                ,isPaused: false
                ,imgDirectory: 'http://bt.oasfile.aftenposten.no/jobbdirekte/img/'
             }

             ,init : function(options) {

                vTickerMethods.options = $.extend(vTickerMethods.options, options);

                return this.each(function(){

                    var obj = $(this);

                    obj.css({overflow: 'hidden', position: 'relative'})
                        .children('ul').css({position: 'absolute', marginTop: '3px'});

                    obj.height(vTickerMethods.options.height);

                    var interval = setInterval(function(){
                            obj.vTicker('moveUp');
                    }, vTickerMethods.options.pause);

                    if(vTickerMethods.options.mousePause)
                    {
                        obj.bind("mouseenter",function(){
                            vTickerMethods.options.isPaused = true;
                        }).bind("mouseleave",function(){
                            vTickerMethods.options.isPaused = false;
                        });
                    }

                });
             }

            ,moveUp : function(stop) {

                if (vTickerMethods.options.isPaused) { return; }

                var obj = $(this).children('ul'),
                    clone = obj.children('li:first').clone(true),
                    height = obj.children('li:first').outerHeight(true),
                    speed = vTickerMethods.options.speed;

                obj.animate({top: '-' + height + 'px'}, speed, function() {
                    obj.children('li:first').remove();
                    obj.css('top', '0px');
                });

                clone.appendTo(obj);

             }
        };

        $.fn.vTicker = function( method ) {
            if (vTickerMethods[method] ) {
              return vTickerMethods[method].apply( this, Array.prototype.slice.call( arguments, 1 ));
            } else if ( typeof method === 'object' || ! method ) {
              return vTickerMethods.init.apply( this, arguments );
            } else {
              // Error
            }

        };

        $.shuffle = function(arr) {
            for (var j, x, i = arr.length; i; j = parseInt(Math.random() * i), x = arr[--i], arr[i] = arr[j], arr[j] = x) {}
            return arr;
        };

        function mainJobbDirekte(data, startPage) {

            var items = [],
                html = "";

            if (data.ads.ad) {

                for (i = 0; i < data.ads.ad.length; i++) {
                    if (data.ads.ad[i].logo) {
                        data.ads.ad[i].logo =  vTickerMethods.options.imgDirectory + data.ads.ad[i].logo.substr( data.ads.ad[i].logo.lastIndexOf('=') +1 ) + ".gif";
                    }
                    items.push(data.ads.ad[i]);
                }

                sandbox.render('widgets.jobAdListings.views.jobbdirekte', {len: data.ads.ad.length, items: items, xitiId: sandbox.model[0].xitiId}, function (html) {
                    sandbox.container.find('.content').empty().html(html);
                    sandbox.container.find('.list').vTicker({
                       pause: 2000
                       ,showItems: 7
                       ,speed: 1200
                        ,height: 367
                    });

                });
            }
        }

        // TODO Fjern denne fra globalt scope
        function callback(data) {
            globalJobbdirekteData = data;
            if (data.ads.ad) {
                $.shuffle(data.ads.ad);
                mainJobbDirekte(globalJobbdirekteData);
            }
        }

        callJobbDirekte = function (data) {
            callback.call(that.instance, data);
        };

        function init() {
            if (sandbox.container) {
                sandbox.getScript({
                    url:this.jsonUrl + 'jobbdirekte.json'

                });
            }
        }

        function destroy() {

        }

        return  {
            init: init,
            destroy: destroy
        };
    }
});
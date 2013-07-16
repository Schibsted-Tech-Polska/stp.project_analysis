mno.core.register({
    id:'widget.contentSearch.mobileNavigators',
    creator: function (sandbox) {
        var $ = sandbox.$;

        function init() {

            var navContent = sandbox.container.find('.navigator');

            sandbox.container.gestures({
                callback:function(gesture) {
                    if(gesture.horizontal === 'right'){
                        $('.navigator > li').animate({marginLeft:0}, 250);
                        $('.navigator ul').animate({left:'100%'}, 250);   
                    }


                }

            });

            $('a[data-navigate-param1]').click(function(e){
                e.preventDefault();
                var $this = $(this);
                sandbox.notify({
                    type:'contentSearch-navigator-change',
                    data:{
                        param1:$this.attr('data-navigate-param1'),
                        param2:$this.attr('data-navigate-param2'),
                        e:e
                    }
                });
            });

            $('.toggle').bind('click', function (e) {
                $(this).toggleClass('active');
                $('.toggleContainer').toggle(250);
                e.preventDefault();
            });

            $('.navigator .drilldown').bind('click', function () {
                $('.navigator > li').animate({marginLeft:'-100%'}, 250);
                $(this).siblings('ul').animate({left:0}, 250);
                return false;
            });

            navContent.hide();

        }

        function destroy() {

        }

        return {
            init:init,
            destroy:destroy
        };
    }
});
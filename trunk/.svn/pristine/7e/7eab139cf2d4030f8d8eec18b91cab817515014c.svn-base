/**
 * Created by IntelliJ IDEA.
 * User: ARISINAB
 * Date: 03.des.2010
 * Time: 16:17:59
 * To change this template use File | Settings | File Templates.
 */



mno.core.register({
    id:'widget.mobileStoryContent.map',
    extend:['widget.map.default'],
    creator:function (sandbox) {

        function init() {
            var that = this;
            if(sandbox.container)
            {
                sandbox.container.each(function(i,element){
                    var $element = $(element),
                            width = $('body').width(),
                            height = Math.floor(width/1.5);
                    $element.css("height",height);
                    $element.css("width", width);
                });
                

            }
            sandbox.listen({
                'gapiReady':function () {
                    setTimeout(function () {
                        that.helper(sandbox);
                    }, 15);
                }
            });

            

        }

        function destroy() {}

        return {
            init:init,
            destroy:destroy
        };
    }
});
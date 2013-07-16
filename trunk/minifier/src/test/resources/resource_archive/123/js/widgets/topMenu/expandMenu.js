/**
 * Created by IntelliJ IDEA.
 * User: ARISINAB
 * Date: 02.des.2010
 * Time: 12:29:39
 * To change this template use File | Settings | File Templates.
 */
mno.core.register({
    id:'widget.topMenu.expandMenu',
    creator: function (sandbox) {
        return {
            /*require: [],*/
            init: function(){
                var container = sandbox.container;
                container.find(".expandMenuToggleButton").click(function(){
                    container.find(".expandMenuContainer").toggle("slow");
                    var button = $(this).find(".arrow");
                    if(button.length > 0)
                    {
                        if(button.hasClass("arrowRight"))
                        {
                            button.addClass("arrowDown");
                            button.removeClass("arrowRight");
                        }
                        else
                        {
                            button.addClass("arrowRight");
                            button.removeClass("arrowDown");
                        }
                    }

                });

            },
            destroy: function(){
                //var $ = null;
            }

        };
    }
});
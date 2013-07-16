mno.core.register({
    id:'widget.tvGuide.default',
    creator:function (sandbox) {
        var $ = sandbox.$;
        function init() {
            if(sandbox.container){
                sandbox.container.each(function(i, element){
                    var $element = $(element);
                    $element.find(".event a").bind("click",function(e){
                        var $this = $(this);
                        var $desc = $this.closest(".event").next(".hiddenDescription");
                        if(window.jQuery.trim($desc.html()) !== ""){
                            e.preventDefault();
                            e.stopPropagation();
                        }
                        if($desc.queue("fx").length === 0 && window.jQuery.trim($desc.html()) !== ""){
                            if($desc.css("display") === "none"){
                                $desc.show("slow");
                            }else{
                                $desc.hide("slow");
                            }
                        }

                    });
                });
            }
        }

        function destroy() {}

        return {
            init:init,
            destroy:destroy
        }
    }
});
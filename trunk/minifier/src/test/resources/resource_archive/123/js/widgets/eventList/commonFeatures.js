mno.core.register({
    id:'widget.eventList.commonFeatures',
    creator:function(sandbox) {

        function rotate(){
            var elements = Array.prototype.splice.call(document.querySelectorAll('.item'), 0);
            //var elements = $('.item');
            /*var elements = $('.item');*/

            setInterval(function () {
                /*elements.removeClass('.active');*/
                for (var i = 0; elements[i];i++) {
                    elements[i].setAttribute('class','item');
                }
                elements.unshift(elements.pop());
                /*$(elements[0]).addClass('active');*/
                elements[0].setAttribute('class','item active');
            }, 3000);
        }





        function init() {
            rotate();
        }
        function destroy() {}

        return {
            init:init,
            destroy:destroy
        }
    }
});
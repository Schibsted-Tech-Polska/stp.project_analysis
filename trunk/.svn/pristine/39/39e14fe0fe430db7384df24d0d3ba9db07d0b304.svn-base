mno.namespace('mno.uiResources.singleLineList');
mno.uiResources.singleLineList = function(container) {
    function _animateRight(el, distance) {
        el.animate({marginLeft:-distance}, distance*10, 'linear', function() {
            setTimeout( function () {
                _animateLeft(el,distance)
            },2000)
        });
    }
    function _animateLeft(el, distance) {
        el.animate({marginLeft:0}, distance*10, 'linear');
    }

    /*container.delegate('li', 'mouseenter', function (e) {
        var $this = $(this);
        $this.scrollLeft(1);
        if ($this.scrollLeft() !== 0) {
            $this.scrollLeft(0);
            var a = $this.find('a');
            _animateRight(a, a.innerWidth() - $this.width() + 40);
        }
    });*/
};
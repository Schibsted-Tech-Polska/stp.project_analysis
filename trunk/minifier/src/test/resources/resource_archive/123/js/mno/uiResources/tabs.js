mno.namespace('mno.uiResources.tabs');
mno.uiResources.tabs = function(container) {
    var lastFocus = {};

    function storeFocus(id, el) {
        lastFocus[id] = el;
    }
    function setFocus(id) {
        if (lastFocus.hasOwnProperty(id)) {
            lastFocus[id].focus();
        }
    }

    function next($this) {
        var tabs = container.find('[role=tab]'),
            index = tabs.index($this);
        ((index !== tabs.length-1) ? $this.next() : tabs.first()).focus();
    }

    function prev($this) {
        var tabs = container.find('[role=tab]'),
            index = tabs.index($this);
        ((index !== 0) ? $this.prev() : tabs.last()).focus();
    }

    function keyDown(target, siblings, e) {
        var no_modifier_pressed_flag = !e.ctrlKey && !e.shiftKey && !e.altKey,
            control_modifier_pressed_flag = e.ctrlKey && !e.shiftKey && !e.altKey,
            index;

        switch (e.keyCode) {
            case 34: //PAGEDOWN
                if (control_modifier_pressed_flag === true) {
                    next(target);
                    e.stopPropagation();
                } // endif
                break;

            case 33: //PAGEUP
                if (control_modifier_pressed_flag === true) {
                    prev(target);
                    e.stopPropagation();
                } // endif
                break;

            case 36: //HOME
                if( no_modifier_pressed_flag === true) {
                    container.find('[role=tab]').first().focus();
                    e.stopPropagation();
                }
                break;
            case 35: //END
                if( no_modifier_pressed_flag === true) {
                    container.find('[role=tab]').last().focus();
                    e.stopPropagation();
                }
                break;

            case 9: //TAB
                if( e.ctrlKey && !e.altKey ) {
                    if( e.shiftKey ) {
                        prev(target);
                    } else {
                        next(target);
                    }

                    e.stopPropagation();
                    return false;
                }
                break;
        }
        return true;
    }

    container.delegate('*:not([role=tab]', 'focus', function (){
        var $this = $(this),
            id = $this.parent('[role=tabpanel]').attr('aria-labelledby');
        if (typeof id === 'string') {
            //storeFocus(id, $this);
        }
    });

    container.delegate('[role=tab]', 'click', function () {
        $(this).focus();
    });

    container.delegate('[role=tab]', 'focus', function () {
        var $this = $(this),
            id = $this.attr('id');
        container.find('[aria-selected=true]').not(this).attr('aria-selected','false').attr('aria-label','not selected').blur();
        container.find('[aria-hidden=false]').not('[aria-labelledby=' + id + ']').attr('aria-hidden', 'true');
        $this.attr('aria-selected','true').attr('aria-label','selected');
        container.find('[aria-labelledby=' + id + ']').attr('aria-hidden', 'false');

        if(id === 'tabFbComments') {
            mno.utils.facebook.fbConnectInit();
        }

        setFocus(id);
    });

    container.delegate('[role=tab]', 'keydown', function (e) {
        // Save information about a modifier key being pressed
        var no_modifier_pressed_flag = !e.ctrlKey && !e.shiftKey && !e.altKey,
            $this = $(this),
            index;

        switch( e.keyCode ) {
            case 37: //LEFT
            case 38: //UP:
                if (no_modifier_pressed_flag === true) {
                    prev($this);
                    e.stopPropagation();
                } // endif
                break;

        case 39: //RIGHT
        case 40: //DOWN
                if (no_modifier_pressed_flag === true) {
                    next($this);
                    e.stopPropagation();
                } // endif
                break;
        }
        keyDown($this, container.find('[role=tab]'),e);
    });

    container.delegate('[role=tabpanel]','keydown', function (e) {
        var index = container.find('[role=tabpanel]').index($(this));
        keyDown(container.find('[role=tab]')[index], container.find('[role=tab]'),e);
    });

    container.bind('keypress', function (e) {
        switch( e.keyCode ) {
            case 33: //PAGEUP
            case 34: //PAGEDOWN
                if( e.ctrlKey && !e.altKey && !e.shiftKey ) {
                    e.stopPropagation();
                    return false;
                } // endif
                break;
            case 9: //TAB
                if( e.ctrlKey && !e.altKey ) {
                    e.stopPropagation();
                    return false;
                } // endif
                break;
        }
    });
};
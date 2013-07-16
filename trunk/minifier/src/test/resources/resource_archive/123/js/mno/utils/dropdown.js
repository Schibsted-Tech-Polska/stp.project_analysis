mno.namespace('utils.dropdown');

mno.utils.dropdown = function (config) {
    var settings = {
            autoOpen:false, // Open on initiation?
            close:false,
            state:false,
            onOpen: new Function(),
            onClose: new Function()
        },
        $dropdown = $('<div class="mnoDropdown" />'),
        $dropdownArrow = $('<div class="arrow" />').appendTo($dropdown),
        $dropdownContent = $('<div class="mnoDropdownContent" />').appendTo($dropdown),
        $dropDownClose;


    if (config.trigger === undefined) {
        mno.core.log(1, 'Missing trigger element for mno.dropdown');
        return false;
    }

    // Update settings with config parameters
    for (var key in config) {
        if (config.hasOwnProperty(key)) {
            settings[key] = config[key];
        }
    }

    if (settings.close === true) {
        $('<div class="icon close">x</div>').on('click', function () {
            close();
        }).appendTo($dropdown);
    }

    function setTrigger(trigger){
        settings.trigger = trigger;
    }

    function setPosition() {
        var windowWidth = $(window).width(),
            triggerPos = settings.trigger.offset(),
            relativeTriggerPos = settings.trigger.position(),
            dropDownWidth = $dropdown.width();

        if (windowWidth < 480 ) {
            $dropdown.css({
                left:10,
                right:10
            });
            $dropdownArrow.hide(0);
        } else {
            $dropdownArrow.show(0);
            if ((triggerPos.left + dropDownWidth) > windowWidth) {  // Dropdown cannot fit on the right of trigger
                if ((triggerPos.left + (dropDownWidth/2)) > windowWidth) { // Dropdown cannot fit. Centered on the right of trigger
                    $dropdown.css({
                        left: (relativeTriggerPos.left - (dropDownWidth/2)) + 'px'
                    });
                    $dropdownArrow.show(0).css({
                        marginLeft:((dropDownWidth/2) -10) +'px'
                    });
                } else if ((triggerPos.left - dropDownWidth) < 0) { // Dropdown cannot fit on left side of trigger
                    $dropdown.css({
                        left:10,
                        right:10
                    });
                    $dropdownArrow.hide(0);
                } else { // align dropdown to the left
                     $dropdown.css({
                        left: (relativeTriggerPos.left - dropDownWidth +40) + 'px'
                    });
                    $dropdownArrow.show(0).css({
                        marginLeft:(dropDownWidth - 40) +'px'
                    });
                }
            } else { // place dropdown to the right
                $dropdown.css({
                    left: (relativeTriggerPos.left - 40) + 'px'
                });
                $dropdownArrow.show(0).css({
                    marginLeft:(30 + (settings.trigger.width()/2)) +'px'
                });
            }
        }
    }

    $(window).on('resize', setPosition);

    /**
     * Updates content
     * @param content
     */
    function update(content) {
        content = content || settings.content;
        settings.content = content;
        $dropdownContent.contents().detach();
        $dropdownContent.append($(content));
    }

    /**
     * Open the dropdown modal
     * Pattern: Lazy function definition
     */
    var toggle = function () {
        var show,
            hide,
            height;

        update();

        $dropdown.css('top',settings.trigger.position().top + settings.trigger.outerHeight(true));
        settings.trigger.before($dropdown);
        height = $dropdownContent.outerHeight()+15; // Add height of arrow (20)
        setPosition();

        if (mno.features.transition !== false) {
            show = function() {
                settings.trigger.addClass('triggered');
                $dropdown.css('height' ,height + 'px');
                setTimeout(function () {
                    $dropdown.css('overflow' ,'visible');
                },300);
                settings.onOpen();
            };
            hide = function() {
                settings.trigger.removeClass('triggered');
                $dropdown.css({
                    height:0,
                    overflow:'hidden'
                });
                settings.onClose();
            };
        } else {
            $dropdown.css('overflow','visible');
            show = function() {
                settings.trigger.addClass('triggered');
                $dropdown.show(250);
                settings.onOpen();
            };
            hide = function() {
                settings.trigger.removeClass('triggered');
                $dropdown.hide(250);
                settings.onClose();
            };
        }

        toggle = function () {
            (settings.state) ? hide() : show();
            settings.state = !settings.state;
        };
        return toggle();
    };

    function close() {
        settings.state = true;
        toggle();
    }

    if (settings.autoOpen === true) {
        toggle();
    }

    return {
        close:close,
        toggle:toggle,
        setTrigger:setTrigger,
        setPosition:setPosition,
        update:update
    };
};
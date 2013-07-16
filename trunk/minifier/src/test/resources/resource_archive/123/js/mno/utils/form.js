/****************************************************************/
/* Form.js                                                      */
/* Author: Tor Brekke Skjøtskift                                */
/*                                                              */
/* Styles OS elements not directly available to CSS             */
/* Emulates basic html5 capabilities for non-compliant browsers */
/****************************************************************/

mno.namespace('utils.form');

mno.utils.form = function () {
    var inputTest = document.createElement('input');

    function _markError(el, msg) {
        el.parents('form:first').addClass('error');
        el.css({
            backgroundColor:'#Fcc'
        });

        if (typeof msg !== 'undefined') {
            $('<p />').css({color:'#900',fontSize:'10px'}).html(msg).insertAfter(el);
        }
    }

    /*******************************/
    /*  HTML5 Placeholder support  */
    /*******************************/

    function placeholder(context) {
        context = context || document;
        if (!('placeholder' in inputTest)) {
            $('input[placeholder]', context).each(function () {
                var $this = $(this),
                    placeholder = $this.attr('placeholder');

                if ($this.val() === '') {
                    $this.val(placeholder);
                }

                $this.bind('focus', function () {
                    var $this = $(this),
                        placeholder = $this.attr('placeholder');

                    if ($this.val() === placeholder) {
                        $this.val('');
                    }
                }).bind('change blur', function () {
                    var $this = $(this),
                        placeholder = $this.attr('placeholder'),
                        value = $this.val();

                    if ((value === '') || (value === placeholder)) {
                        $this.val(placeholder);
                    }
                });

                $this.parents('form:first').bind('submit', function () {
                    var $thisForm = $(this),
                        placeholder = $this.attr('placeholder'),
                        value = $this.val();

                    if ((value === '') || (value === placeholder)) {
                        $this.val('');
                    }
                });
            }); /* end each */
        } /* end if */
    }


    /********************
     * Date
     */

    function datePicker(context) {
        context = context || document;
        if ($('input[type="date"]', context).length !== 0 ) {
            var dayLabels=['Man', 'Tir', 'Ons','Tor', 'Fre','L&oslash;r', 'S&oslash;n'],
                monthLabels=['Januar','Februar','Mars','April','Mai','Juni','Juli','August','September','Oktober','November','Desember'],
                daysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31],
                curDate = new Date();

            function createCalendar(callback, curDay, month, year) {
                month = (isNaN(month) || month ===null) ? curDate.getMonth() : parseInt(month,10);
                year = (isNaN(year) || year === null)? curDate.getFullYear() :year;
                curDay =  (isNaN(curDay) || curDay === null)? curDate.getDate() : parseInt(curDay,10);

                var firstDay = new Date(year, month, 1),
                    startingDay = firstDay.getDay() || 7,
                    monthLength = daysInMonth[month],
                    html='',
                    i = 0,
                    j = 0,
                    day = 1,
                    template = {
                        months:[],
                        years:[],
                        dayLabels:dayLabels,
                        row:[]
                    };

                if (month === 1) { // February only!
                    if ((year % 4 === 0 && this.year % 100 !== 0) || year % 400 === 0){  /*Leap year*/
                        monthLength = 29;
                    }
                }

                for (i = 0; i <=11 ; i++) {
                    template.months.push({
                        selected: (month === i) ? ' selected="selected"' : '',
                        value:i,
                        name:monthLabels[i]
                    });
                }

                for (i = curDate.getFullYear(); i >= 1860 ; i--) {
                    template.years.push({
                        selected: (parseInt(year) === i) ? ' selected="selected"' : '',
                        value:i,
                        name:i
                    });
                }

                for (i = 0; i < 9; i++) {  // this loop is for is weeks (rows)
                    template.row[i] = {
                        cell:[]
                    };
                    for (j = 1; j <= 7; j++) {  // this loop is for weekdays (cells)
                        if (day <= monthLength && (i > 0 || j >= startingDay)) { /*fill the cell only if we haven't run out of days, and we're sure we're not in the first row, or this day is after the starting day for this month.*/
                            html = '<div datetime="' + year + '-' + (month+1) + '-' + day + '">' + day + '</div>';
                            day++;
                        }
                        template.row[i].cell.push({
                            current: (curDay+1 !== day) ? '' : ' class="current"',
                            time:html
                        });
                        html = '';
                    }

                    if (day > monthLength) {  // stop making rows if we've run out of days
                        break;
                    }
                }
                mno.views.render('mno.views.calendar',template,callback);

            }

            $(context).delegate('input[type="date"]','click', function () {
                var $this = $(this),
                    value = $this.val().split('/'),
                    now = new Date(),
                    day = value[0] || now.getDate(),
                    month = value[1] !== undefined ? value[1] - 1 : now.getMonth(),
                    year = value[2] || now.getFullYear();

                function renderCal() {
                    createCalendar(function (el) {
                        $this.attr('disabled', 'disabled');
                        $('body').bind('click.date', function () {
                            $this.removeAttr('disabled');
                            el.remove();
                            $('body').unbind('click.date');
                        });

                        el.bind('click', function () {
                            return false;
                        });
                        el.insertBefore($this);

                        el.find('select').bind('change', function () {
                            if ($(this).attr('name') === 'month') {
                                month = $(this).val();
                            } else {
                                year = $(this).val();
                            }

                            el.remove();
                            renderCal();
                        });

                        el.find('tbody div').bind('click', function () {
                            value = $(this).attr('datetime').split('-');
                            $this.val(value[2]+'/'+value[1]+'/'+value[0]);
                            $this.removeAttr('disabled');
                            el.remove();
                            $('body').unbind('click.date');
                        });

                    },day, month, year);
                }
                renderCal();
            });
        }
    }

    /**************************/
    /* HTML5 required support */
    /**************************/

    function required(context) {
        context = context || document;
        if (!('required' in inputTest)) {
            $('input[required], textarea[required]', context).each(function () {
                var $this = $(this);

                $this.parents('form:first').bind('submit', function (e) {
                    if ($this.val() === "") {
                        _markError($this, 'Feltet kan ikke v&aelig;re tomt');
                        e.preventDefault();
                    }
                });
            });
        }
    }

    /***********************/
    /* HTML5 Email support */
    /***********************/
    function email(context) {
        context = context || document;
        inputTest.setAttribute('type', 'email');
        if (inputTest.type !== 'email') {
            $('input[type="email"]', context).each(function () {
                var $this = $(this),
                    reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
                $this.parents('form:first').bind('submit', function (e) {
                    if (!reg.test($this.val())) {
                        _markError($this, 'Ugyldig epostadresse');
                        e.preventDefault();
                    }
                });
            });
        }
    }

    /****************************/
    /* HTML5 maxlength support  */
    /****************************/
    function maxLength(context) {
        context = context || document;
        if (!('maxlength' in inputTest)) {
            /* for IE7, opera */
            $('input[maxlength][maxlength!=-1][maxlength!=524288][maxlength!=2147483647][type="text"],textarea[maxlength][maxlength!=-1][maxlength!=524288][maxlength!=2147483647]', context).not('[data-mno-form]').each(function () {
                var $this = $(this),
                    el = $('<p />').addClass('formCharCounter').insertAfter($this);

                $this.attr('data-mno-form', 'true')
                    .bind('keyup', function() {
                    var max = $this.attr('maxlength') || 500,
                        text = $this.val(),
                        len = text.length;

                    if (len > max) {
                        $this.val(text.substr(0, max));
                        el.html('Du har <strong>0</strong> tegn igjen');
                        return false;
                    } else {
                        el.html('Du har <strong>' + (max - len) + '</strong> tegn igjen');
                        return true;
                    }
                });
            });
        }
    }

    /********************/
    /*  Select styling  */
    /********************/
    function select(context, update) {
        context = context || document;
        update = update || false;
        if (update === false) {
            $('select', context).not('[data-mno-form]').each(function (i) {
                var $this = $(this),
                    outerWidth = $this.outerWidth(),
                    dropDown = $('<div />').addClass('pillBox selectDropDown'),
                    input = $('<input />').attr('type','text')
                        .val($this.find('option').filter(function () {
                            return $(this).val() === $this.val();
                        }).html()).appendTo(dropDown),
                    btn = $('<span />').addClass('button').html('\u25BC');

                $this.attr('data-mno-form', 'true');
                $this.data('fakeElement', dropDown);
                $this.parent().addClass('relative');

                dropDown.css({
                    top:$this.position().top + 'px',
                    left:$this.position().left + 'px',
                    zIndex:1,
                    width:outerWidth + 'px'
                }).append(btn);


                if ($this.parents('.pillBox').length !== 0 ) {
                    if ($this.get(0) === $this.parents('.pillBox').first().children().last().get(0)) {
                        dropDown.insertAfter($this);
                    } else {
                        dropDown.insertBefore($this);
                    }
                } else {
                    dropDown.insertBefore($this);
                }
                input.css('width', (outerWidth - btn.outerWidth() - (input.outerWidth() - input.width())) + 'px');

                $this.css({
                    position:'relative',
                    zIndex:2,
                    opacity:0
                }).bind('change', function () {
                    input.val($this.find('option').filter(function () {
                        return $(this).val() === $this.val();
                    }).html());
                });
            });
        } else {
            $('select[data-mno-form]').each(function () {
                var $this = $(this),
                    outerWidth = $this.outerWidth(),
                    $fake = $this.data('fakeElement'),
                    $input = $fake.find('input'),
                    $btn = $fake.find('.button');

                $fake.css({
                    top:$this.position().top + 'px',
                    left:$this.position().left + 'px',
                    zIndex:1,
                    width:outerWidth + 'px'
                });

                $input.css('width', (outerWidth - $btn.outerWidth() - ($input.outerWidth() - $input.width())) + 'px');
            });
        }
    }

    /*****************************/
    /*  Input type=file styling  */
    /*****************************/
    function fileInput(context) {
        context = context || document;

        $('.fileInput', context).not('[data-mno-form]').each(function () {
            var el = $('<div />').addClass('pillBox').html('<input type="text" name="fake" /><span class="button">Bla gjennom</span>')
                    .css({position:'absolute',zIndex:1,top:0,left:0});

            var $this = $(this);
            $this.attr('data-mno-form', 'true');

            $this.find('input[type=file]')
                .css({opacity:0,position:'relative',zIndex:2})
                .data('fake', el)
                .bind('change mouseout', function () {
                    $(this).data('fake').find('input').val($(this).val());
                });

            $this.append(el);

        });
    }

    /*******************/
    /* Sliding labels  */
    /*******************/
    function slidingLabels(context) {
        context = context || document;
        $('.rightAlignedLabels input, .rightAlignedLabels textarea', context).not('[data-mno-form]').each(function () {
            var $this = $(this),
                label = $('label[for=' + $this.attr('id') + ']');

            function labelSlideOut() {
                if (!label.data('active')) {
                    $this.unbind('focus')
                            .bind('blur', labelSlideBack)
                            .focus();

                    label.animate({
                        left:(label.position().left - label.width() - 11 ) + 'px',
                        opacity:1
                    }, 250, function () {
                        label.data('active', true);
                    });
                }
            }
            function labelSlideBack() {
                if ((label.data('active')) && ($this.val() === "")) {
                    $this.bind('focus', labelSlideOut)
                            .unbind('blur')
                            .blur();
                    label.animate({
                        left:($this.position().left + 6) + 'px',
                        opacity:0.5
                    }, 250, function () {
                        label.data('active', false);
                    });
                }
            }

            $this.attr('data-mno-form', 'true');

            if ($this.val() === '' && !$this.attr('placeholder')) {
                label.css({
                    opacity:0.5,
                    left:($this.position().left + 6) + 'px',
                    textAlign:'left',
                    width:'auto'
                })
                        .data('active', false);
            } else {
                label.data('active', true);
            }

            //label.bind('click', activeLabel);
            if (label.length !== 0) {
                $this.bind('focus', labelSlideOut);
                label.bind('click', function (e) {
                    labelSlideOut();
                    return false;
                });
            }
        });
    }

    return {
        placeholder:placeholder,
        datePicker:datePicker,
        required:required,
        email:email,
        maxLength:maxLength,
        select:select,
        fileInput: fileInput,
        slidingLabels: slidingLabels,
        styleAll: function (context) {
            context = context || document;
            placeholder(context);
            datePicker(context);
            required(context);
            email(context);
            maxLength(context);
            select(context);
            slidingLabels(context);
        }
    }
}();


$(document).ready(function () {
    mno.utils.form.styleAll();
});

mno.namespace('mno.uiResources.rotator');
mno.uiResources.rotator = function(container) {
    function rotate($elements ,cb){
        $elements = Array.prototype.slice.call($elements, 0);
        cb = cb || function () {};

        return setInterval(function () {
            for (var i = 0; $elements[i];i++) {
                $($elements[i]).removeClass('active');
            }
            $elements.unshift($elements.pop());
            $($elements[0]).addClass('active');
            cb();
        }, 3000);
    }

    function setUp(el, callback) {
        var width = el.$this.width(),
            imgWidth = Math.floor(width/400*2)*100 + 80,
            data = {
                width:imgWidth,
                items:[]
            };

        function setVars() {
            var height = 0;
            el.$items = el.$this.find('.item');
            el.$items.each(function () {
                if (height < $(this).find('.large').height()) {
                    height =  $(this).find('.large').height();
                }
            });
            el.contentHeight = height;
            el.$this.find('.large').height(height);
            el.$content.height(height);
            el.height = el.$items.height();
        }

        if (el.$this.find('ul.content .item .large').length === 0) {  // implement new markup if markup is not correctly implemented?
            el.$content = $('<ul class="content" style="padding-left:'+imgWidth+'px"></ul>');

            el.$items.each(function () {
                var $this = $(this),
                    img = $this.find('img').attr('src');

                data.items.push({
                    title: $this.find('h2').text(),
                    link: $this.find('a').attr('href'),
                    img: img,
                    largeImg: img.replace(/w\d+/, 'w' + imgWidth),
                    teaser: $this.find('.teaserText').text()
                });
            });

            el.$this.children('*').not('header, .footer').remove();
            el.$this.addClass('clearfix');

            mno.views.render('rotator', data, function (html) {
                el.$content.append(html);
                el.$this.append(el.$content);
                setVars();
                callback();
            });
        } else {
            el.$content = el.$this.find('.content');
            setVars();
            callback();
        }
    }

    container.each(function () {
        var $this = $(this),
            $items = $this.find('article'),
            el = {
                $this: $this,
                $items : $items,
                len: $items.length
            },
            rotateInterval;

        function startRotator(cb) {
            return rotate(el.$items, cb);
        }

        setUp(el, function () {
            var cb;
            function animateAccordion() {
                $this.find('.item').not('.active').animate({
                    height: ( (el.contentHeight - el.height + 5) / (el.len) ) + 'px'
                }, 500);
                $this.find('.item.active').animate({
                    height:el.height + 'px'
                }, 500);
            }

            if (el.contentHeight < (el.height * el.len)) {
                el.$content.height(el.contentHeight);
                cb = animateAccordion;
            } else {
                cb = function() {};
            }

            rotateInterval = startRotator(cb);

            el.$items.hover(function () {
                clearInterval(rotateInterval);
                el.$items.stop().removeClass('active');
                $(this).addClass('active');
                cb();
            }, function () {
                rotateInterval = startRotator(cb);
            });
            cb();
        });
    });

};
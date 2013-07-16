mno.core.register({
    id:'widget.realEstateInfo.generalInfo',
    extend:['widget.realEstateInfo.common'],

    creator:function (sandbox) {

        function init() {
            var parent = this;
            if (sandbox.container) {
                // loop through instances of the widget

                this.getData(function (objData) {
                    sandbox.container.each(function (widgetIndex, element) {
                        // assign locally a model variable for the current instance
                        var model = sandbox.model[widgetIndex];
                        var $view = $(element);

                        var propertyInfo = [];
                        var info = objData.properties.generalInfoItems;
                        if (typeof(info) !== "undefined") {
                            for (var i = 0; i < info.length; i++) {
                                propertyInfo.push({ label: info[i].heading, value: info[i].text });
                            }

                            sandbox.render("widgets.realEstateInfo.views.generalInfo", { obj:objData, info:propertyInfo }, function ($html) {
                                $view.html($html);


                                var $items = $view.find('.informationItem');
                                $items.each(function(i, el) {
                                    var $el = $(el);
                                    var $header = $el.find('header');
                                    var $seeMore = $header.find('.seeMore');
                                    var $content = $el.find('.content');
                                    var fullHeight = $content.height() + 10; // spacing

                                    var open = false;
                                    $header.click(function() {
                                        open = !open;
                                        if (open) {
                                            $content.animate({
                                                height: fullHeight,
                                                opacity: 1
                                            });
                                            $seeMore.animate({
                                                opacity: 0
                                            });
                                        } else {
                                            $content.animate({
                                                height: 0,
                                                opacity: 0
                                            });
                                            $seeMore.animate({
                                                opacity: 1
                                            });
                                        }
                                    });
                                    // initial hide
                                    $content.css({
                                        height: 0,
                                        opacity: 0
                                    });
                                    $header.css({
                                        cursor: "pointer"
                                    });
                                });
                            });
                        }
                    });
                });
            }
        }

        function destroy() {
        }

        return {
            init:init,
            destroy:destroy
        }
    }
});
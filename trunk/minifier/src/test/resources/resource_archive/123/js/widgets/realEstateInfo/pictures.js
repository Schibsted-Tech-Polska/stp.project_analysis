mno.core.register({
    id:'widget.realEstateInfo.pictures',
    extend:['widget.slideshow.main', 'widget.realEstateInfo.common'],
    creator:function (sandbox) {

        var commonData = {
            publication:sandbox.publication.name
        };

        function init() {
            var parent = this;
            if (sandbox.container) {
                // loop through instances of the widget
                this.getData(function (objData) {

                    sandbox.container.each(function (widgetIndex, element) {
                        // assign locally a model variable for the current instance
                        var model = sandbox.model[widgetIndex];
                        var $element = $(element);
                        var $picturesList = $("<div class='slideshow-wrapper' />");
                        $element.html($picturesList);

                        var images = objData.properties.images;
                        if (typeof(images) !== "undefined") {
                            $picturesList.css('display', 'block');
                            $picturesList.html('<ul class="picturesList slideshow-list"></ul>');
                            $ul = $picturesList.find('ul');
                            for (var i = 0; i < images.length; i++) {
                                var picture = images[i];

                                $ul.append('<li class="slideshow-element"><img src="' + picture.url.replace('_xl.', '.') + '" alt="' + picture.name + '"><span>' + (picture.description || "") + '</span></li>');
                            }
                        } else {
                            $picturesList.remove();
                        }

                        if ($picturesList.length > 0) {
                            parent.slideshow($element, { markOrientation: true, thumbnails: !objData.isMobile });
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
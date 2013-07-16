mno.core.register({
    id: 'widget.classifiedBox.vertical',
    extend: ['widget.classifiedBox.common'],

    creator: function (sandbox) {

        function init() {
            var parent = this;
            if (sandbox.container) {
                sandbox.container.each(function (widgetIndex, element) {
                    parent.helper(sandbox, widgetIndex, function (result, shared) {
                        var $carousel = $(element);
                        var $adList = $carousel.find('.resultListBox');

                        var filtered = shared.filterAdsByCategory();
                        var data = filtered.category;
                        var categoryId = filtered.categoryId;

                        if (result.config.carouselLinkToItemsName === '') {
                            $carousel.find('.overviewLink').hide();
                        }

                        shared.renderCategories(
                            result.config.categoriesDisplay,
                            result.categories,
                            function (html) {
                                var $categories = $carousel.find('.categories');

                                if (result.config.skinColor === 'blackTheme') {
                                    $categories.appendTo($carousel);
                                }
                                $categories.html(html);


                                shared.bindCategoriesEvents($categories, renderAds);

                                shared.setSelectedCategory({
                                    container: $categories,
                                    type: result.config.categoriesDisplay,
                                    selected: categoryId
                                });

                            }
                        );
                        renderAds(data);


                        function renderAds(data) {
                            var i;

                            for (i = 0; i < data.ads.length; i++) {
                                if (data.ads[i].heading.length > 58) {
                                    data.ads[i].heading = jQuery.trim(data.ads[i].heading).substring(0, 55).split(" ").slice(0, -1).join(" ") + "...";
                                }
                            }

                            sandbox.render('widgets.classifiedBox.views.layouts.' + result.config.type + '.' + result.config.publication + '.vertical', {
                                items: data.ads,
                                widgetIndex: widgetIndex,
                                landingUrl: result.config.landingUrl
                            }, function (html) {
                                $adList.html(html);

                                $adList.find('a.resultItemLink').each(function (index) {

                                    shared.bindTrackEvent(
                                        data.ads[index].objectId,
                                        shared.VIEW
                                    );

                                    $(this).on('click', function (event) {
                                        shared.bindTrackEvent(
                                            data.ads[index].objectId,
                                            shared.CLICK
                                        );
                                    });
                                });
                            });
                        }
                    });
                });
            }
        }

        function destroy() {
            $carousel.detach();
        }

        return {
            init: init,
            destroy: destroy
        };
    }
});
mno.core.register({
    id: 'widget.classifiedBox.overview',
    extend: ['widget.classifiedBox.common'],

    creator: function (sandbox) {

        function init() {
            var parent = this;

            if (sandbox.container) {
                sandbox.container.each(function (widgetIndex, element) {
                    parent.helper(sandbox, widgetIndex, function (result, shared) {

                        var $carousel = $(element);


                        var $adList = $carousel.find('.resultListBox'),
                            data = null,
                            categoryId = null;

                        if (result.config.categoryId === null) {

                            if (result.config.skinColor === 'blackTheme') {
                                $carousel.find('.header').hide();
                            }

                            var merged = [],
                                i,
                                j;
                            for (i in result.categories) {
                                if (result.categories.hasOwnProperty(i)) {
                                    if (i !== 'all') {
                                        for (j = 0; j < result.categories[i].ads.length; j++) {
                                            merged.push(result.categories[i].ads[j]);
                                        }
                                    }
                                }
                            }

                            data = {
                                ads: merged
                            };
                        } else {
                            var filtered = shared.filterAdsByCategory();
                            data = filtered.category;
                            categoryId = filtered.categoryId;

                            if (result.config.skinColor === 'blackTheme') {
                                $carousel.find('.header').show();
                                $carousel.find('.header h2').html(result.categories[categoryId].name);
                            }

                        }

                        shared.renderCategories(
                            result.config.categoriesDisplay,
                            result.categories,
                            function (html) {
                                var $categories = $carousel.find('.categories');
                                $categories.html(html);

                                shared.bindCategoriesEvents($categories, refreshAds);

                                shared.setSelectedCategory({
                                    container: $categories,
                                    type: result.config.categoriesDisplay,
                                    selected: categoryId
                                });
                            }
                        );

                        var packsize = result.config.itemsPerPage;
                        var pageNum = result.config.page;
                        var offset = ((pageNum - 1) * packsize);
                        var limit = offset + packsize;
                        var $html;
                        filterAdsByPaginating(pageNum);

                        function refreshAds(categoryData) {
                            data = categoryData;
                            pageNum = 1;
                            offset = ((pageNum - 1)) * packsize;
                            limit = offset + packsize;
                            filterAdsByPaginating(pageNum);
                        }

                        function filterAdsByPaginating(pageNum) {
                            offset = ((pageNum - 1)) * packsize;
                            limit = offset + packsize;
                            var slicedData = data.ads.slice(offset, limit);

                            renderAds({
                                ads: slicedData
                            }, data);
                        }


                        function renderAds(data, allData) {
                            var i;

                            $html = renderPageLinks(Math.ceil($(allData.ads).length / packsize));

                            var textLength = result.config.skinColor === 'blackTheme' ? 255 : 68;
                            for (i = 0; i < data.ads.length; i++) {
                                if (data.ads[i].heading.length > textLength) {
                                    data.ads[i].heading = jQuery.trim(data.ads[i].heading).substring(0, textLength - 3).split(" ").slice(0, -1).join(" ") + "...";
                                }
                            }

                            sandbox.render('widgets.classifiedBox.views.layouts.' + result.config.type + '.' + result.config.publication + '.overview', {
                                items: data.ads,
                                widgetIndex: widgetIndex,
                                landingUrl: result.config.landingUrl,
                                config: result.config,
                                skinColor: result.config.skinColor
                            }, function (html) {
                                $adList.html(html);

                                $adList.append($html);
                                $html.clone(true).prependTo($adList);


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


                                if (result.config.randomCategoryId === null) {
                                    $carousel.find('h2').html(
                                        result.categories[result.config.categoryId].name
                                    );
                                }

                            });
                        }


                        function switchPage(destPageNum) {
                            pageNum = destPageNum;
                            filterAdsByPaginating(destPageNum);
                        }


                        function renderPageLinks(pageCount) {
                            var $html = $("<ol/>").addClass("pagelinks");
                            var ellipsisUsed = false;
                            var p;
                            var $li = $('<li><a>&laquo;</a></li>');

                            if (pageNum > 1) {
                                $li.find('a')
                                    .addClass('prev')
                                    .click(function (ev) {
                                        if (pageNum > 1) {
                                            switchPage(pageNum - 1);
                                        }
                                        ev.preventDefault();
                                        return false;
                                    });

                                if (1 === pageNum) {
                                    $li.addClass('skip');
                                }
                                $html.append($li);
                            }

                            for (p = 1; p <= pageCount; p++) {

                                /* calculate distances to interesting points */
                                var toFirst = p - 1;
                                var toActive = pageNum > p ? pageNum - p : p - pageNum;
                                var toLast = pageCount - p;

                                /* get the shortest one */
                                var dist = Math.min(toFirst, toActive, toLast);

                                /* and skip this number if we are more than 2 units from any of them */
                                /* but leave at least 5 first links... */
                                /* but when we're in the middle, we don't need that many links around */
                                if ((dist > 2 && p > 5) || (p > 5 && pageNum > 8 && dist > 1)) {
                                    if (!ellipsisUsed) {
                                        $html.append("<li class='skip'>&hellip;</li>");
                                        ellipsisUsed = true;
                                    }
                                    continue;
                                } else {
                                    ellipsisUsed = false;
                                    /* reset the flag */
                                }

                                var current = (p === pageNum);
                                /* the magic below creates things object-wise
                                 so we can attach events in the meantime */
                                $li = $('<li/>');
                                if (current) {
                                    $li.addClass('current');
                                }
                                $a = $('<a/>').html(p);

                                $a.click((function (p) {
                                    // we have to create a local scope (closure) to preserve the CURRENT value of p
                                    return function (ev) {
                                        switchPage(p);
                                        ev.preventDefault();
                                        return false;
                                    };
                                })(p));

                                $html.append($li.append($a));
                            }

                            if (pageNum < pageCount) {
                                $li = $('<li><a>&raquo;</a></li>');

                                $li.find('a')
                                    .addClass('next')
                                    .click(function (ev) {
                                        if (pageNum < pageCount) {
                                            switchPage(pageNum + 1);
                                        }
                                        ev.preventDefault();
                                        return false;
                                    });

                                if (pageCount === pageNum) {
                                    $li.addClass('skip');
                                }
                                $html.append($li);
                            }


                            return $html;
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
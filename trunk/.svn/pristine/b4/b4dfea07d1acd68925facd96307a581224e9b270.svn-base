/**
 * Created by IntelliJ IDEA.
 * User: ARISINAB
 * Date: 02.des.2010
 * Time: 12:29:39
 * To change this template use File | Settings | File Templates.
 */
mno.core.register({
    id:'widget.topMenu.standardMenu',
    /*require:['mno.utils.params', 'mno.utils.siteGestures'],*/
    creator: function (sandbox) {
        var $ = sandbox.$;

        /**
         * Creates sticky-menu on scroll
         */
        function initScroll() {
            var $ = window.jQuery;

            if($('.topMainMenu').length > 0) {

            var html = '<nav id="smallHeader" class="smallHeader"><div id="innerSmallHeader" class="span12 gridRow">',
                mainNav = $('.topMainMenu').clone(true).addClass('floatLeft').removeClass('gridRow span7'),
                search = $('#header .search form').clone(true),
                smallHeader,
                posFixed;


            mno.features.positionFixed(function (fixed) {

                var $header = window.jQuery('#header'),
                    headerVisible = false;
                posFixed = fixed;

                search.addClass('floatRight');
                html += '<a class="floatLeft logo" href="'+sandbox.publication.url+'"><img src="' + sandbox.publication.url + 'skins/global/gfx/' + sandbox.publication.name +'_logo_small.png" alt =""/></a>';
                html += '</div></nav>';

                if(typeof mno.core.utils !== 'undefined' && typeof mno.core.utils.innerShiv === 'function'){
                    smallHeader = $(mno.core.utils.innerShiv(html,false));

                }else{
                    smallHeader = $(html);
                }
                var innerSmallHeader = smallHeader.find('#innerSmallHeader');
                innerSmallHeader.append(mainNav);
                innerSmallHeader.append(search);
                $('body').append(smallHeader);

                smallHeader.hide();

                if (posFixed === true) {
                    sandbox.listen({
                        'scrollmove': function (data) {
                            if (data.y > ($header.height() + $header.offset().top)) {
                                if (headerVisible === false) {
                                    smallHeader.show();
                                    headerVisible = true;
                                }
                            } else {
                                if (headerVisible === true) {
                                    smallHeader.hide();
                                    headerVisible = false;
                                }
                            }
                        }
                    });
                }
            });
            }
        }
        /**
         * Creates swipe navigation on section pages
         */
        function initSwipe() {
            var menuItems = [mno.publication.url];
            sandbox.container.find('> ul > li > a').each(function () {
                menuItems.push($(this).attr('href'));
            });

            var path = mno.utils.params.getPath();
            var sectionIndex = window.jQuery.inArray(path, menuItems);

            if (sectionIndex !== -1) {
                menuItems.rotate(sectionIndex);

                sandbox.listen({
                    'gesture':function (direction) {
                        var url;
                        if (direction.horizontal ==='left') {
                            url = menuItems.pop();
                        } else if (direction.horizontal === 'right') {
                            if (menuItems[1]) {
                                url=menuItems[1];
                            }
                        }
                        if (url !== undefined && url !== path) {
                            window.location.href = url;
                        }
                    }
                });
            }
        }

        function _addToJumplist() {
            if (typeof window.external !== 'undefined' && typeof window.external.msIsSiteMode !== 'undefined') {
                window.external.msSiteModeCreateJumpList('Seksjoner');
                $('#header .topMainMenu > ul > li > a').each(function (i,el) {
                    var $this = $(this);
                    if (i<5) {
                        window.external.msSiteModeAddJumpListItem($this.text(), $this.attr('href'), mno.publication.url + 'skins/publications/'+ mno.publication.id +'/gfx/icons/favicon.ico');
                    }
                });
                window.external.msSiteModeShowJumplist();

            }
        }

        function init() {
            sandbox.container.find('[href="/indeks"]').live('click', function (e) {
                sandbox.requireWidget('widget.siteIndex.default');
                e.preventDefault();
            });
            initScroll();
            initSwipe();
            _addToJumplist();
        }

        function destroy () {
            $ = null;
        }


        return {
            init: init,
            destroy: destroy

        };
    }
});
mno.core.register({
    id:'widget.topMenu.sideMenuGeneral',
    creator:function(sandbox){
        function Menu(container, bg) {

            // Set paramaters for the content
            this.state = false; // The menu is not visible at the moment
            this.page = $('#page'); // Where the article/content lives
            this.sideMenu = $('#sideMenu'); // Where the whole sideMenu lives
            this.sideMenuNav = $('nav.widget.topMenu.sideMenuGeneral'); // Where the meny content lives
            this.menuWidth = this.sideMenuNav.attr("data-menuwidth"); // The width for the menu in pixels
            this.body = $('body'); // The page body
            this.trigger = $('.sideMenuTrigger'); // The trigger for the menu
            this.menulinks = this.sideMenuNav.find('.link'); // Menulinks
            this.submenulinks = $('.openclose'); // Subitems in the menu

            // Move the menu html to the correct div
            this.sideMenuNav.addClass('sideMenuActive').prependTo( this.sideMenu );
            // Now that the menu content has been moved to a hidden div, we can display it
            this.sideMenuNav.css('display','block');
            this.sideMenuNav.css('width',  this.menuWidth + 'px');
            this.sideMenuNav.find('.link').css('width',  this.menuWidth + 'px');

            // Add the click event to the menutrigger
            var that = this;
            this.trigger.bind('click', function (e) {
                that.toggle(e);
                e.stopPropagation();
            });

            // Add the click event to page to close the menu if it is open
            var that = this;
            this.page.bind('click', function (e) {
                if ( that.state == true ) {
                    that.toggle(e);
                    e.stopPropagation();
                }
            });

            // Add click event to every menu item
            this.menulinks.bind('click', function (e) {
                window.location.href = $(this).attr("data-menu-href");
            });

            // For every menu item with sub items, add click event when clicking on the plus/cross icon
            this.submenulinks.bind('click', function (e) {
                // Find the parent (the div for the subitems), and close it
                var that = $(this).parent().parent().find('ul');
                that.toggleClass("closed");

                // Toggle the the class, so the plus/x-sign is showed
                $(this).toggleClass("cross");
                e.preventDefault();
                e.stopPropagation();
            });
        }

        Menu.prototype.toggle = function(e) {
            var that = this;
            if (this.state === false) {
                this.page.animate({
                    left: this.menuWidth + 'px'
                }, 200,'',function() {

                });
            } else {
                this.page.animate({
                    left:'0'
                }, 200,'',function() {
                });
            }
            this.state = !this.state;
            e.preventDefault()
        };

        function init() {
            sandbox.container.each(function () {
                var $this = $(this),
                        sideMenu = new Menu($this);
            });
        }

        function destroy() {
        }

        return {
            init:init,
            destroy:destroy
        };
    }
});
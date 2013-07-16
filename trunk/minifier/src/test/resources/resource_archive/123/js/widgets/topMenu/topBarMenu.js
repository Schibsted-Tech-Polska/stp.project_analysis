mno.core.register({
    id:'widget.topMenu.topBarMenu',
    creator:function(sandbox){
        function Menu(container, bg) {
            bg = bg || '#282828';

            // The menu is not visible at the moment
            this.state = false;

            // Add the click event to the menutrigger
            var that = this;
            sandbox.container.find('.sideMenuTrigger').bind('click', function (e) {
                that.toggle(e);
            });

            // Add click event to every menu item
            sandbox.container.find('span.link').each(function (e) {
                $(this).bind('click',function(e){
                    window.location.href = $(this).attr("data-menu-href");
                } );
            });
        }

        Menu.prototype.toggle = function(e) {
            if (this.state === false) {
                this.page.animate({
                    left:'200px'
                }, 200);
            } else {
                this.page.animate({
                    left:'0'
                }, 200);
            }
            this.state = !this.state;
            e.preventDefault()
        };


        function init() {
            sandbox.container.each(function () {
                var $this = $(this),
                        sideMenu = new Menu($this);
            });
            sandbox.listen({
                'dialog-close': function(data) {
                    if(data.id !== sandbox.moduleId){
                        sandbox.container.find('div.topBarMenu').removeClass('block').addClass('none');
                    }
                }
            });
            sandbox.container.find('.mainMenu a').attr('href','').bind('click', function(e){
                e.stopPropagation();
                e.preventDefault();
                sandbox.notify({
                    type:'dialog-close',
                    data:{
                        id:sandbox.moduleId
                    }
                });
                sandbox.container.find('div.topBarMenu').toggleClass('none').toggleClass('block');
            });
        }

        function destroy() {
        }

        return {
            init:init,
            destroy:destroy
        };
    }
})
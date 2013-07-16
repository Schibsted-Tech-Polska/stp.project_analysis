mno.core.register({
    id:'widget.list.videoArchive',
    creator:function (sandbox) {
        function init() {
            getPaging();
            sectionListener();
        }
        function getVideos(pagingNr,section){
            var el = sandbox.container.find('.videos');
            el.css({
               'background-image' : 'url(/skins/global/gfx/loader.gif)',
               'background-position' : 'center',
               'background-repeat' : 'no-repeat'
            });

            jQuery.ajax({
                type: "GET",
                url: mno.publication.rel + "template/widgets/list/controller/videoArchive.jsp",
                cache: false,
                data: "paging="+pagingNr+"&section="+section+"&ajax=true",
                success:function(msg){
                    renderResult(msg);
                },
                error:function(jqHXR, textStatus, errorThrown){
                    mno.core.log(1,'error: '+textStatus+' '+errorThrown);
                }
            });

        }
        function renderResult(data){
            sandbox.container.find('.paging').remove();
            sandbox.container.find('.videos').replaceWith(data);
        }
        function getActiveSection(){
             return sandbox.container.find('.videos')[0].id;
        }
        function getPaging(){
             sandbox.container.find('.paging a').live('click', function () {
                sandbox.container.find('.paging a').removeClass('active');
                $(this).addClass('active');
                var clickedPaging_id = $(this).attr("id");
                getVideos(clickedPaging_id,getActiveSection());
                return false;
             });
        }
        function sectionListener(){
            sandbox.container.find('.categories a').live('click', function () {
                sandbox.container.find('.categories a').removeClass('active');
                $(this).addClass('active');
                var clickedSection_id = $(this).attr("id");
                getVideos(1,clickedSection_id);
                $(this).parent().addClass(clickedSection_id);
                return false;
            });

        }
        function destroy() {
        }
        return {
            init:init,
            destroy:destroy
        }
    }
});
mno.core.register({
    id:'widget.code.template.common.code.videoSlideShowTeaser.jsp',
     creator: function (sandbox) {
        return {
            init: function() {
               getPaging();
            },

            destroy: function() {
                $ = null;
            }
        };
        function getPaging(){
            $('#videoTeaserNext').live('click',function(){
                var clickedPaging_id = $(this).attr("class");
                getVideos(clickedPaging_id);
                return false;
            });

            $('#videoTeaserPrev').live('click',function(){
                var clickedPaging_id = $(this).attr("class");
                getVideos(clickedPaging_id);
                return false;
            });
        }
        function getVideos(pagingNr){
            jQuery.ajax({
                type: "GET",
                url: mno.publication.url + "template/common/code/videoSlideShowTeaser.jsp",
                cache: false,
                data: "ajax=true"+"&paging="+pagingNr,
                success:function(msg){
                    renderResult(msg);
                    mno.core.log(1, 'Success');
                },
                error:function(jqHXR, textStatus, errorThrown){
                    mno.core.log(1,'error: '+textStatus+' '+errorThrown);
                }
            });
        }
        function renderResult(data){
            $('#headerVideoTeaser').remove();
            $('#videoTeaser').replaceWith(data);
        }
    }
});


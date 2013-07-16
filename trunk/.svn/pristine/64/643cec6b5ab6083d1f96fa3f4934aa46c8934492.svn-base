mno.core.register({
    id:'widget.storyContent.main',
    creator: function (sandbox) {
        function _createFootnotes(container) {
            var notes = window.jQuery('<section class="printOnly footnotes"><h2>Sluttnoter</h2></section>'),
                ol = window.jQuery('<ol></ol>'),
                links = container.find('.bodyText a[href]:not(.excludeFromFootnotes)').filter(function() {
                    return $(this).parents('.noPrint').length === 0;
                });

            if (links.length > 0) {
                links.each(function (i) {
                    var $this = $(this);
                    $this.after('<sup class="printOnly">'+ (i+1) + '</sup>');
                    ol.append('<li>'+$this.attr('href') +'</li>');
                });
                notes.append(ol);
                container.append(notes);
            }
        }

        function init() {}
        function destroy() {}

        function initArticle(sandbox, that) {
            sandbox.container.each(function(i, element){
                var $this= $(this),
                    storyContentModel = sandbox.model[i];

                var videoview = 'silverlight';
                if(storyContentModel.videoView){
                    videoview = storyContentModel.videoView;
                }

                if(storyContentModel.flashArticlesInBody) {
                    jQuery.each(storyContentModel.flashArticlesInBody, function(k, flash){
                        that.showFlash(flash);
                    });
                }

                if (typeof $.fn.mnoExpand === 'function') {
                    $('.photo').mnoExpand({
                        content: {
                            location:{
                                attr:'data-picture-original'
                            },
                            type:'image'
                        },
                        expandedWidth: 6,
                        direction:'right'
                    });

                    $('.video').mnoExpand({
                        content: {
                            location: {
                                attr: 'data-video'
                            },
                            type: 'flash'
                        },
                        expandedWidth: 6,
                        direction:'right'
                    });
                }

                if (storyContentModel.mapData !== undefined) {
                    sandbox.requireWidget('widget.storyContent.map');
                }
                _createFootnotes($this);
            });
        }

        return {
            init:init,
            destroy:destroy,
            initArticle:initArticle
        }
    }
});
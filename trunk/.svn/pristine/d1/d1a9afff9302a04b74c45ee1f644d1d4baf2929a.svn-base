mno.core.register({
    id: 'widget.storyContent.bodyText',
    extend:['mno.utils.flash'],
    creator: function (sandbox) {
        var $ = sandbox.$;

        function _createFootnotes(container) {
            var notes = window.jQuery('<section class="noPrint"><h2>Fotnoter</h2></section>'),
                ol = window.jQuery('<ol></ol>'),
                clone = container.clone(true);  // Clone to prevent reflow
                
            clone.find('a[href]').each(function (i) {
                var $this = $(this);
                $this.insertAfter('<sup class="nopPrint">'+ i+ '</sup>');
                ol.append('<li>'+$(this).attr('href') +'</li>');
            });
            notes.append(ol);
            clone.append(notes);
            container.replaceWith(clone);
        }

        return {
            init: function () {
                var runThis = this.showFlash;

                sandbox.container.each(function(i, element){
                    var $this= $(this);
                    storyContentModel = sandbox.model[i];

                    var videoview = 'silverlight';
                    if(storyContentModel.videoView){
                        videoview = storyContentModel.videoView;
                    }

                    if(storyContentModel.flashArticlesInBody) {
                        jQuery.each(storyContentModel.flashArticlesInBody, function(k, flash){
                            runThis(flash);
                        });
                    }

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
                    _createFootnotes($this);
                });
            },

            destroy: function () {
            }
        };
    }
});

mno.core.register({
    id:'widget.minimizedFrontpagePart.default',
    creator: function (sandbox) {
        var publicationUrl,
            zoom = typeof document.body.style.zoom !== 'undefined';

        function retrieveFrontpageLevels(section, startLevel, endLevel){
            jQuery.ajax({
                type: "GET",
                url: publicationUrl+"?service=loadLevel&fromLevel="+startLevel+"&toLevel="+endLevel,
                success:function(data){
                    transformAndAppendLevels(section, data);
                },
                error:function(jqHXR, textStatus, errorThrown){
                    mno.core.log(1,'error: '+textStatus+' '+errorThrown);
                }
            });
        }

        function transformAndAppendLevels(section, data){
            section.full.width(380);
            section.full.append(data);

            var gridRow = section.full.find('.gridRow');

//            section.zoom.find('.inner').append(gridRow.clone(true));

            gridRow.addClass('span10');
            var newHeight = 0;
            gridRow.each(function () {
                var h = $(this).height()*0.4;

                $(this).wrap('<div style="height:'+h+'px;overflow:hidden;margin-bottom:5px"></div>');
                newHeight += h;
                if (zoom === true) {
                    $(this).wrapInner('<div class="ieZoom"></div>');
                }
            }); //+30 because of header

            section.full.height(newHeight);
            gridRow.addClass('squeezeToFit4Cols');

            section.full.css('overflow', 'hidden');
//            $('body').append(section.zoom);
            section.y2 = section.full.offset().top + section.full.height();
        }

        return {
            init: function() {
                sandbox.container.each(function(i, element){
                    var model = sandbox.model[i],
                        $this = $(this),
                        transform = mno.features.transform,
                        content = $this.find('.content'),
                        offset = content.offset(),
                        section = {
                            full:content,
//                            zoom: $('<div class="zoomSection"><div class="fix"><div class="inner"></div></div></div>'),
                            x1: offset.left,
                            x2: offset.left + content.width(),
                            y1: offset.top,
                            y2: offset.top + content.height()
                        };

                    publicationUrl = model.pubUrl;

                    if (transform !== false || zoom === true) {
                        retrieveFrontpageLevels(section, model.startLevel, model.endLevel);
                    }


//                    section.full.bind('mouseenter', function (e) {
//                        var timer;
//
//                        section.zoom.css({
//                            left:(e.pageX-150) + 'px',
//                            top:(e.pageY-150) +'px'
//                        }).addClass('init');
//
//                        $('body').bind('mousemove.minimizedFrontpagePart', function (e) {
//                            section.zoom.css({
//                                left:(e.pageX-150) + 'px',
//                                top:(e.pageY-150) +'px'
//                            });
//
//                            section.zoom.find('.inner').css({
//                                left: -((e.pageX-section.x1)/0.4-150) + 'px',
//                                top: -((e.pageY-section.y1)/0.4-150) + 'px'
//                            });
//
//                            if (e.pageX < section.x1 || e.pageX > section.x2 || e.pageY < section.y1 || e.pageY > section.y2) {
//                                $('body').unbind('mousemove.minimizedFrontpagePart');
//                                section.zoom.removeClass('init');
//                                setTimeout(function () {section.zoom.css('left', '-10000px')}, 500);
//                            }
//                        });
//                    });
                });



            },

            destroy: function() {
                $ = null;
            }
        };
    }
});
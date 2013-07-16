mno.core.register({
    id:'widget.mobilePopupBox.default',
    creator:function (sandbox) {

        function init () {
        
        	sandbox.container.each(function (i, el) {
        		/* Save box and remove it from markup */
        		var box = $(el).remove(),
        			model = sandbox.model[i]
        			appId = model.popUrl.replace(/[^a-zA-Z 0-9]/g, ''),
                    isApp =  mno.utils.params.getParameter('hideTopBottom');

        			/*localStorage.removeItem('mno_' + appId);*/

        		/* Scroll box to viewport */
        		function scroll() {
        			if (mno.features.transform !== false) {
        				box.css(mno.features.transform, 'translateY('+($(window).scrollTop() + 50) + 'px)');
        				box.css('opacity', 1);
        			} else {
	        			box.stop();
    	    			box.animate({top:$(window).scrollTop() + 50, opacity:1},250)
    	    		}
        		}

        		function popupClick(id) {
        			try {
        				localStorage.setItem('mno_' + id, true);
        	        } catch (e) {
        	        }
        	        box.remove();
        	        sandbox.ignore('scrollstop');
        		}

        		/* Is localstorage supported */
                var doRender = false;

                switch (model.showOnMobileAndOrApp)
                {
                case "mobileWebOnly":
                    //console.log("mobileWebOnly");
                    doRender=(isApp === 'true')?false:true;
                    break
                case "appOnly":
                    //console.log("appOnly");
                    doRender=(isApp === 'true')?true:false;
                    break
                default:
                    doRender = true;
                }

            	if (typeof localStorage !== 'undefined' && navigator.userAgent.toLowerCase().search(model.device) > -1 && doRender === true) {

            		/* Test if user has seen the popup */
                	if (!localStorage.getItem('mno_' + appId)) {
						
						var id = appId;
						
                		/* Create Markup */
    	            	var	btnNeg = $('<a href="#" class="button last" value="'+model.popNegative+'">'+model.popNegative+'</button>');
        	        		btnPos = $('<a href="'+model.popUrl+'" class="button" target="_blank" value="'+model.popPositive+'">'+model.popPositive+'</button>');
            	    		inner = box.find('.inner');

            	    	$('<div class="popupIcon" style="background-image:url('+ model.icon +');" />').appendTo(inner);
                		inner.append($('<p>'+ model.popText +'</p>')).append(btnNeg).append(btnPos);

                		/* Style */
                		box.css({
    	            		display:'block',
            	    		opacity:0,
            	    		top:0
                		});
                		if (mno.features.transform !== false) {
                			box.css(mno.features.transform, 'translateY('+ ($(window).scrollTop() - 200) + 'px)');
                			box.addClass('animate');
                		} else {
	                		box.css('top',$(window).scrollTop() - 200);
                		}

                		/* Add events */
	                	btnPos.bind('click', popupClick, id);

                		btnNeg.bind('click', function () {
	                		popupClick( id);
        	        		return false;
            	    	});

                		/* Insert pop up*/
                		$('body').append(box);

	 	               	/* Show popup */
    	            	setTimeout(scroll, 500);
        	        	sandbox.listen({
            	    		'scrollstop':scroll
                		});
                	}
            	}
            });
        }

        function destroy () {}

        return {
            init:init,
            destroy:destroy
        }
    }
});
mno.core.register({
        id:'widget.eventPlaceSearch.default',
        extend: ['widget.eventPlaceSearch.main'],
        creator:function(sandbox){
            function init(){
                var model,
                    that = this;

                if (sandbox.container) {
                    sandbox.container.each(function (widgetIndex, element) {
                        var $this = $(this);
                        model = sandbox.model[widgetIndex];

                        $this.submit(function (event) {
                            event.preventDefault();
                            var data =  {
                                text: $this.find('[name=text]').val(),
                                resultsPerPage: 10,
                                featureIds: [],
                                resultsIndex: 0
                            };

                            if (window.location.href.split('#')[0] === model.url) {
                                that.search(model.jsonUrl, data);
                            } else {
                                window.location.href = model.url + '##' + that.encodeHash(data);
                            }
                        });

                        if (window.location.href.split('#')[0] === model.url) {
                            that.search(model.jsonUrl);
                        }
                    });
                }
            }

            function destroy(){
            }
            
            
            
            return {
                init:init,
                destroy:destroy
            }
        }
    }

);
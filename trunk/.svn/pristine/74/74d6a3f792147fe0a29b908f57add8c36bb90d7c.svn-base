mno.core.register({
    id:'widget.weather.forecastSummary',
    creator:function (sandbox) {
        var model, container;

        function init() {
            model = sandbox.model[0];
            container = sandbox.container[0];

            sandbox.listen({
                'weatherSearch-searchPerformed':function (data) {
                    if(data.forecast!=undefined){
                        showWeatherSummary(data.forecast.forecast.text_location);
                    }else{
                        $(container).hide();
                    }
                }
            });

        }

        function showWeatherSummary(forecastSummary){
            sandbox.render('widgets.weather.view.forecastSummary',{forecastSummary:forecastSummary}, function(html){
                $(container).html(html);
                var expandCollapse = $(container).find('.expandCollapse');
                var text = $(expandCollapse).find('.text');
                var arrow = $(expandCollapse).find('.arrow');
                var forecasts = $(container).find('.forecasts');
                $(forecasts).hide();
                $(expandCollapse).click(function(){
                    $(forecasts).toggle();
                    if($(arrow).hasClass('down')){
                        $(arrow).removeClass('down').addClass('up');
                        $(text).html('Skjul ');
                    }else{
                        $(arrow).removeClass('up').addClass('down');
                        $(text).html('Vis ');
                    }
                })
                if(model.showYr){
                    sandbox.render('widgets.weather.view.yrDisclaimer', {yrUrl:''}, function(html){
                        $(container).append(html);
                    });
                }
            });
        }

        function destroy() {}

        return {
            init:init,
            destroy:destroy
        }
    }
});
/**
 * Created by IntelliJ IDEA.
 * User: ARISINAB
 * Date: 06.des.2010
 * Time: 13:34:42
 * To change this template use File | Settings | File Templates.
 */
mno.core.register({
    id:'widget.stormWeather.default',
    creator: function (sandbox) {
        
        var longitude = sandbox.model[0].longitude,
            latitude = sandbox.model[0].latitude;

        function setWeather (day, temperature, symbol){
            var warm = (temperature > 0) ? 'warm' :'';
            $('.stormWeather-'+day+' .stormWeather-symbol').addClass('icon'+symbol);
            $('.stormWeather-'+day+' .stormWeather-degrees').html(temperature + '&deg;').addClass(warm);
        }

        function init () {
            $.ajax({
                url:'http://tjenestercache.aftenposten.no/storm/wod.json?la=' + latitude + '&lo=' + longitude + '&callback=?',
                cache: true,
                dataType:"jsonp",
                jsonpCallback: 'stormWeatherReturnFunction893394044712',
                success: function(data){
                    if(data.DsWOD.length >= 1){
                        setWeather('today', data.DsWOD[0].temperature, data.DsWOD[0].symbol);
                    }

                    if(data.DsWOD.length >= 4){
                        setWeather('tomorrow', data.DsWOD[3].temperature, data.DsWOD[3].symbol);
                    }

                }
            });
        }

        function destroy () {
            longitude = null;
            latitude = null;
        }

        return {
            setWeather: setWeather,
            init: init,
            destroy: destroy
        };
    }
});
mno.core.register({
    id:'widget.code.template.common.code.weatherSearch.jsp',
   creator: function (sandbox) {
        return {
            init: function() {
                sandbox.container.each(function(i, element){
                   $('form#weatherSearch').bind('submit', function (event) {
                       var weatherSearchInput =  $('form#weatherSearch input[name="search"]');  //Finner input-feltet "search"
                       var query =  escape(weatherSearchInput.val());// input.val() henter inntastet streng. Escape gjør strengen portabel.
                       var param = weatherSearchInput.attr('name');  //Henter navnet "search"
                       if (query == weatherSearchInput.attr('placeholder')) {
                          weatherSearchInput.val('');
                       } else  {
                          document.location.href = $(this).attr('action') + "?" + param + "=" + query;   // Lager en fullstendig URL manuelt  (bruk av encodeURI ga problemer).
                          return false;
                       }
                   });
                })
            },

            destroy: function() {
                $ = null;
            }
        };
   }
});



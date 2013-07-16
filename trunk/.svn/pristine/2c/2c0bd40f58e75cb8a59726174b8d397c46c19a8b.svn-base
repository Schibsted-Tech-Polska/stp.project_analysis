mno.namespace('utils.openWindow');

mno.utils.openWindow = function(url, settings) {
    var config = {
        width:800,
        height: 600,
        options: {
            resizable: 'yes',
            scrollbars: 0
        },
        name: 'openWindow'
        },
        windowWidth = $(window).width(),
        windowHeight = $(window).height(),
        optionsString = '';

    for (var key in settings) {
         if (settings.hasOwnProperty(key)) {
             config[key] = settings[key];
         }
    }

    optionsString = 'width='+config.width+',height='+config.height+',screenX='+(windowWidth-config.width)/2+', screenY='+(windowHeight-config.height)/2;

    for (var i in config.options) {
        if (config.options.hasOwnProperty(i)) {
            optionsString += ', ' + i + '=' + config.options[i];
        }
    }

    window.open(
        url,
        config.name,
        optionsString
    )
};
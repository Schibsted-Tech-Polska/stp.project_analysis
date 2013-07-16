mno.namespace('utils.imageResizer');

/**
 * Reisizes and crops an image using the lisa-service
 * @param options
 * @param service
 */
mno.utils.ImageResizer = function(options, service) {
    this.params = '';

    this.service = service || 'http://lisacache.aftenposten.no/utils/img.php';

    if (typeof options.resize === 'undefined') {
        options.resize = 'resize';
    }

    for (var key in options) {
        if (options.hasOwnProperty(key)) {
            if (options[key] !== null) {
                this.params = this.params + '&' + key + '=' + options[key];
            }
        }
    }
};

mno.utils.ImageResizer.prototype = {
    getImage: function (url) {
        return this.service + '?' + this.params + '&src=' + encodeURIComponent(url);
    }
};
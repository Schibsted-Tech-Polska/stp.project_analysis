mno.namespace('mno.views');

mno.views = (function () {

    function render(type,data,callback) {
        try{
        if (data.constructor === Array) {
            data = [{items:data}];
        }

        if ($.template[type] !== undefined) {
            callback($.tmpl(type, data));
            data = null;
        } else {
            var url = (function () {
                if (type.indexOf('.') !== -1) {
                    return mno.publication.rel + 'resources/js/' + type.replace(/\./g, '/')+'.tmpl';
                } else {
                    return mno.publication.rel + 'resources/js/mno/views/' + type + '.tmpl';
                }
            }());

            $.ajax({
                url:url,
                success: function (result) {
                    try{
                        $.template(type, result);
                        callback($.tmpl(type,data));
                        data = null;
                    } catch(e) {
                        mno.core.log(1,e);
                    }
                }
            });
        }
        }
        catch(e){mno.core.log(3,e);}
    }

    return  {
        render:render
    };
}());